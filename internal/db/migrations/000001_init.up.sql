CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS customers (
  "id" uuid PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
  "first_name" VARCHAR(255) NOT NULL,
  "last_name" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(15) NOT NULL UNIQUE,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
)

CREATE TABLE IF NOT EXISTS addresses(
  "id" uuid PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
  "lat" INT NOT NULL,
  "lng" INT NOT NULL,
  "house_number" VARCHAR(6) NOT NULL,
  "street" VARCHAR(255) NOT NULL,
  "city" VARCHAR(255) NOT NULL,
  "coutry" VARCHAR(255) NOT NULL,
  "postcode" VARCHAR(8) NOT NULL,
  "complement" VARCHAR(255) NOT NULL,
  "reference" VARCHAR(255) NOT NULL,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
  FOREIGN KEY (merchant_id) REFERENCES merchants(id) ON DELETE CASCADE
)
