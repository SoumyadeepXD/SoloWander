-- ═══════════════════════════════════════════════════════════
-- ROW LEVEL SECURITY
-- ═══════════════════════════════════════════════════════════
alter table users            enable row level security;
alter table trips            enable row level security;
alter table expenses         enable row level security;
alter table bookings         enable row level security;
alter table packing_lists    enable row level security;
alter table community_posts  enable row level security;
alter table audit_log        enable row level security;
alter table usage_logs       enable row level security;
alter table price_corrections enable row level security;

create policy "own_users"    on users            for all using (auth.uid() = id);
create policy "own_trips"    on trips            for all using (auth.uid() = user_id);
create policy "own_expenses" on expenses         for all using (auth.uid() = user_id);
create policy "own_bookings" on bookings         for all using (auth.uid() = user_id);
create policy "own_packing"  on packing_lists    for all using (auth.uid() = user_id);
create policy "own_audit"    on audit_log        for select using (auth.uid() = user_id);
create policy "own_usage"    on usage_logs       for all using (auth.uid() = user_id);
create policy "own_corrections" on price_corrections for all using (auth.uid() = user_id);

create policy "posts_read"   on community_posts  for select using (true);
create policy "posts_insert" on community_posts  for insert with check (auth.uid() = user_id);
create policy "posts_update" on community_posts  for update using (auth.uid() = user_id);
create policy "posts_delete" on community_posts  for delete using (auth.uid() = user_id);

create policy "hostels_read"   on hostels           for select using (true);
create policy "transport_read" on transport_options  for select using (true);
create policy "city_read"      on city_affordability for select using (true);
create policy "emergency_read" on emergency_contacts for select using (true);
