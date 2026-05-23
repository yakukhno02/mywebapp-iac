#!/bin/bash

echo "Running DB migration..."

export PGPASSWORD=12345678

psql -h 192.168.252.10 -U app -d mywebapp <<EOF

CREATE TABLE IF NOT EXISTS items (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO items (name, quantity, created_at)
VALUES
  ('Laptop', 10, NOW()),
  ('Phone', 25, NOW()),
  ('Keyboard', 15, NOW()),
  ('Mouse', 30, NOW()),
  ('Monitor', 8, NOW())
ON CONFLICT (name) DO NOTHING;

EOF

echo "Migration done!"
