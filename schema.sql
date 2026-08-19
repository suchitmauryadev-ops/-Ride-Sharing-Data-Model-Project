CREATE TABLE "DRIVER" (
	"driver_id" INTEGER NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	"email" VARCHAR(255) NOT NULL UNIQUE,
	"phone" VARCHAR(255) NOT NULL UNIQUE,
	"profile_pic_url" VARCHAR(255),
	"total_ride" INTEGER NOT NULL,
	"profile_created_at" TIMESTAMP NOT NULL,
	"is_active" BOOLEAN NOT NULL,
	"driver_availability" BOOLEAN NOT NULL,
	PRIMARY KEY("driver_id")
);

CREATE TABLE "RIDE" (
	"ride_id" INTEGER NOT NULL UNIQUE,
	"driver_id" INTEGER NOT NULL,
	"rider_id" INTEGER NOT NULL,
	"vehicle_id" INTEGER NOT NULL,
	"payment_id" INTEGER NOT NULL,
	"rating_id" INTEGER,
	"pickup_lat" DECIMAL NOT NULL,
	"pickup_long" DECIMAL NOT NULL,
	"drop_lat" DECIMAL NOT NULL,
	"drop_long" DECIMAL NOT NULL,
	"requested_at" TIMESTAMP NOT NULL,
	"completed_at" TIMESTAMP,
	"ride_type" VARCHAR(255) NOT NULL,
	"ride_status" VARCHAR(255) NOT NULL,
	"ride_fare" DECIMAL NOT NULL,
	"cancelled_by" VARCHAR(255),
	"cancellation_reason" VARCHAR(255),
	"cancelled_at" TIMESTAMP,
	"distance_km" DECIMAL,
	PRIMARY KEY("ride_id")
);

CREATE TABLE "RIDER" (
	"rider_id" INTEGER NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	"email" VARCHAR(255) NOT NULL UNIQUE,
	"phone" VARCHAR(255) NOT NULL UNIQUE,
	"rating" REAL,
	"created_at" TIMESTAMP,
	"profile_pic_url" VARCHAR(255) NOT NULL,
	PRIMARY KEY("rider_id")
);

CREATE TABLE "PAYMENT" (
	"payment_id" INTEGER NOT NULL UNIQUE,
	"transaction_id" VARCHAR(255) NOT NULL,
	"amount" DECIMAL,
	"currency" VARCHAR(255) NOT NULL,
	"payment_method" VARCHAR(255) NOT NULL,
	"create_at" TIMESTAMP NOT NULL,
	"process_at" TIMESTAMP,
	"payment_status" VARCHAR(255) NOT NULL,
	"payment_token" VARCHAR(255) NOT NULL,
	PRIMARY KEY("payment_id")
);

CREATE TABLE "VEHICLE" (
	"vehicle_id" INTEGER NOT NULL UNIQUE,
	"driver_id" INTEGER NOT NULL UNIQUE,
	"make" VARCHAR(255) NOT NULL,
	"model" VARCHAR(255) NOT NULL,
	"year" INTEGER NOT NULL,
	"license_no" VARCHAR(255) NOT NULL UNIQUE,
	"vehicle_no" VARCHAR(255) NOT NULL UNIQUE,
	"capacity" INTEGER NOT NULL,
	"color" VARCHAR(255) NOT NULL,
	PRIMARY KEY("vehicle_id")
);

CREATE TABLE "RATING" (
	"rating_id" INTEGER NOT NULL UNIQUE,
	"ride_id" INTEGER NOT NULL,
	"score" INTEGER,
	"comment" VARCHAR(255) NOT NULL,
	PRIMARY KEY("rating_id")
);

ALTER TABLE "RIDE"
ADD FOREIGN KEY("driver_id") REFERENCES "DRIVER"("driver_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "RIDE"
ADD FOREIGN KEY("rider_id") REFERENCES "RIDER"("rider_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "RIDE"
ADD FOREIGN KEY("vehicle_id") REFERENCES "VEHICLE"("vehicle_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "RIDE"
ADD FOREIGN KEY("payment_id") REFERENCES "PAYMENT"("payment_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "RIDE"
ADD FOREIGN KEY("rating_id") REFERENCES "RATING"("rating_id")
ON UPDATE NO ACTION ON DELETE SET NULL;

-- Indexes on foreign key columns
CREATE INDEX "idx_ride_driver_id" ON "RIDE"("driver_id");
CREATE INDEX "idx_ride_rider_id" ON "RIDE"("rider_id");
CREATE INDEX "idx_ride_vehicle_id" ON "RIDE"("vehicle_id");
CREATE INDEX "idx_ride_payment_id" ON "RIDE"("payment_id");
CREATE INDEX "idx_ride_rating_id" ON "RIDE"("rating_id");