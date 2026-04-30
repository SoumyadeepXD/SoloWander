-- Seed Hostels in India
INSERT INTO hostels (name, city, country, price_per_night, currency, rating, solo_rating, amenities) VALUES
('Zostel Mumbai', 'Mumbai', 'India', 900, 'INR', 4.5, 4.8, ARRAY['WiFi', 'AC', 'Locker', 'Common Room']),
('Locomo Hostel', 'Mumbai', 'India', 850, 'INR', 4.3, 4.5, ARRAY['WiFi', 'AC', 'Breakfast', 'Locker']),
('Wanderers Hostel', 'Goa', 'India', 500, 'INR', 4.6, 4.9, ARRAY['Pool', 'WiFi', 'Bar', 'AC']),
('Jungle by sturmfrei', 'Goa', 'India', 600, 'INR', 4.4, 4.7, ARRAY['WiFi', 'AC', 'Yoga', 'Events']),
('Moustache Jaipur', 'Jaipur', 'India', 450, 'INR', 4.7, 4.8, ARRAY['WiFi', 'Rooftop', 'AC', 'Tours']),
('The Hosteller Jaipur', 'Jaipur', 'India', 400, 'INR', 4.5, 4.6, ARRAY['WiFi', 'AC', 'Locker', 'Cafe']),
('Alt Life Manali', 'Manali', 'India', 700, 'INR', 4.8, 4.9, ARRAY['WiFi', 'Heating', 'Mountain View', 'Cafe']),
('Zostel Manali', 'Manali', 'India', 800, 'INR', 4.6, 4.7, ARRAY['WiFi', 'Bonfire', 'Locker', 'Common Room']),
('Cuckoo Hostel', 'Bangalore', 'India', 600, 'INR', 4.4, 4.5, ARRAY['WiFi', 'Workspace', 'Kitchen', 'Locker']),
('Draper Startup House', 'Bangalore', 'India', 750, 'INR', 4.5, 4.6, ARRAY['WiFi', 'Coworking', 'Events', 'AC']);

-- Seed Transport Options
INSERT INTO transport_options (city, country, transport_type, provider_name, avg_cost_inr, avg_cost_usd, unit, booking_method) VALUES
('Mumbai', 'India', 'Auto-rickshaw', 'Meter', 15, 0.18, 'per_km', 'Street'),
('Mumbai', 'India', 'Local Train', 'Mumbai Railways', 10, 0.12, 'per_ride', 'Counter'),
('Mumbai', 'India', 'BEST Bus', 'BEST', 8, 0.10, 'per_ride', 'Street'),
('Goa', 'India', 'Scooter Rental', 'Local Shops', 400, 4.80, 'per_day', 'Street'),
('Goa', 'India', 'Bicycle Rental', 'Local Shops', 150, 1.80, 'per_day', 'Street'),
('Goa', 'India', 'Pilot (Motorcycle Taxi)', 'Local', 50, 0.60, 'per_km', 'Street'),
('Jaipur', 'India', 'Auto-rickshaw', 'Meter', 12, 0.15, 'per_km', 'Street'),
('Jaipur', 'India', 'City Bus', 'JCTSL', 15, 0.18, 'per_ride', 'Street'),
('Jaipur', 'India', 'e-Rickshaw', 'Local', 10, 0.12, 'per_km', 'Street'),
('Manali', 'India', 'Local Bus', 'HRTC', 30, 0.36, 'per_ride', 'Counter'),
('Manali', 'India', 'Shared Taxi', 'Union', 300, 3.60, 'per_trip', 'Counter'),
('Bangalore', 'India', 'Namma Metro', 'BMRCL', 30, 0.36, 'per_ride', 'Counter'),
('Bangalore', 'India', 'Auto-rickshaw', 'Meter', 25, 0.30, 'per_km', 'Street'),
('Bangalore', 'India', 'BMTC Bus', 'BMTC', 10, 0.12, 'per_ride', 'Street');
