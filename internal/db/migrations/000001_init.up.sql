CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS customers (
  "id" uuid PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
  "first_name" VARCHAR(255) NOT NULL,
  "last_name" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(15) NOT NULL UNIQUE,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS merchants (
  "id" uuid PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
  "active" BOOLEAN NOT NULL DEFAULT false, 
  "slug" VARCHAR(255) NOT NULL UNIQUE,
  "status" VARCHAR(255) NOT NULL,
  "delivery_fee" FLOAT NOT NULL,
  "min_order_price" FLOAT NOT NULL,
  "title"VARCHAR(255) NOT NULL,
  "description" VARCHAR(255) NOT NULL,
  "image_url" VARCHAR(255) NOT NULL,
  "banner_url" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(15) NOT NULL UNIQUE,
  "started_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "finished_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS addresses (
  "id" uuid PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
  "customer_id" uuid,
  "merchant_id" uuid,
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
);