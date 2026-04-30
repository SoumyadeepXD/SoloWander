-- ═══════════════════════════════════════════════════════════
-- USERS (extends Supabase auth.users)
-- ═══════════════════════════════════════════════════════════
create table users (
  id                    uuid primary key references auth.users(id) on delete cascade,
  email                 text unique not null,
  name                  text,
  avatar_url            text,
  home_country          text default 'IN',
  preferred_currency    text default 'INR',
  subscription_status   text default 'free',
  subscription_expires_at timestamptz,
  login_attempts        int  default 0,
  locked_until          timestamptz,
  last_seen_at          timestamptz,
  badges                text[] default '{}',
  deleted_at            timestamptz,
  created_at            timestamptz default now()
);

-- ═══════════════════════════════════════════════════════════
-- REFERENCE DATA (public read, admin write)
-- ═══════════════════════════════════════════════════════════
create table hostels (
  id               uuid primary key default gen_random_uuid(),
  name             text not null,
  city             text not null,
  country          text not null,
  price_per_night  int  not null,
  currency         text default 'INR',
  rating           numeric(3,2),
  solo_rating      numeric(3,2),
  amenities        text[],
  photos           text[],
  google_place_id  text unique,
  lat              numeric(10,7),
  lng              numeric(10,7),
  address          text,
  is_verified      boolean default false,
  created_at       timestamptz default now()
);

create table transport_options (
  id                   uuid primary key default gen_random_uuid(),
  city                 text not null,
  country              text not null,
  transport_type       text not null,
  provider_name        text,
  avg_cost_inr         int,
  avg_cost_usd         int,
  unit                 text,   -- per_km | per_ride | per_day | per_hour
  booking_method       text,   -- app | street | counter
  app_link             text,
  notes                text,
  last_verified_at     timestamptz,
  verified_by_user_id  uuid references users(id),
  verification_count   int default 0
);

create table city_affordability (
  id                       uuid primary key default gen_random_uuid(),
  city                     text not null,
  country                  text not null,
  transport_score          numeric(3,1),
  food_score               numeric(3,1),
  stay_score               numeric(3,1),
  shoestring_budget_inr    int,
  comfortable_budget_inr   int,
  splurge_budget_inr       int,
  avg_hostel_dorm_inr      int,
  avg_street_meal_inr      int,
  avg_local_transport_inr  int,
  last_updated             timestamptz default now()
);

create table emergency_contacts (
  id               uuid primary key default gen_random_uuid(),
  country          text not null,
  country_code     text not null,
  police           text,
  ambulance        text,
  fire             text,
  tourist_helpline text,
  women_helpline   text
);

-- ═══════════════════════════════════════════════════════════
-- USER DATA (RLS protected)
-- ═══════════════════════════════════════════════════════════
create table trips (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid references users(id) on delete cascade,
  destination   text not null,
  city          text,
  country       text,
  lat           numeric(10,7),
  lng           numeric(10,7),
  start_date    date,
  end_date      date,
  total_budget  int  not null,
  currency      text default 'INR',
  itinerary     jsonb,
  is_public     boolean default false,
  public_slug   text unique,
  created_at    timestamptz default now()
);

create table expenses (
  id           uuid primary key default gen_random_uuid(),
  trip_id      uuid references trips(id) on delete cascade,
  user_id      uuid references users(id),
  name         text not null,
  amount       int  not null,    -- stored in paise / cents
  category     text not null,
  expense_date date default current_date,
  notes        text,
  synced_at    timestamptz,
  created_at   timestamptz default now()
);

create table bookings (
  id                  uuid primary key default gen_random_uuid(),
  user_id             uuid references users(id),
  hostel_id           uuid references hostels(id),
  trip_id             uuid references trips(id),
  check_in            date not null,
  check_out           date not null,
  total_price         int  not null,
  commission          int  not null,
  currency            text default 'INR',
  status              text default 'pending',
  razorpay_order_id   text,
  razorpay_payment_id text,
  created_at          timestamptz default now()
);

create table packing_lists (
  id      uuid primary key default gen_random_uuid(),
  user_id uuid references users(id),
  trip_id uuid references trips(id),
  items   jsonb default '[]'
);

-- ═══════════════════════════════════════════════════════════
-- COMMUNITY
-- ═══════════════════════════════════════════════════════════
create table community_posts (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references users(id) on delete cascade,
  city        text,
  post_type   text default 'general',
  title       text not null,
  body        text,
  upvotes     int  default 0,
  is_flagged  boolean default false,
  created_at  timestamptz default now()
);

create table price_corrections (
  id                   uuid primary key default gen_random_uuid(),
  transport_option_id  uuid references transport_options(id),
  user_id              uuid references users(id),
  suggested_cost       int,
  note                 text,
  status               text default 'pending',
  created_at           timestamptz default now()
);

-- ═══════════════════════════════════════════════════════════
-- AUDIT & USAGE
-- ═══════════════════════════════════════════════════════════
create table audit_log (
  id         uuid primary key default gen_random_uuid(),
  user_id    uuid references users(id),
  action     text not null,
  ip_address text,
  user_agent text,
  created_at timestamptz default now()
);

create table usage_logs (
  id      uuid primary key default gen_random_uuid(),
  user_id uuid references users(id),
  feature text not null,
  used_at timestamptz default now()
);

-- ═══════════════════════════════════════════════════════════
-- PERFORMANCE INDEXES
-- ═══════════════════════════════════════════════════════════
create index on hostels(city);
create index on hostels(google_place_id);
create index on transport_options(city, country);
create index on city_affordability(city, country);
create index on expenses(trip_id);
create index on expenses(user_id, expense_date);
create index on community_posts(city, created_at desc);
create index on usage_logs(user_id, feature, used_at);
