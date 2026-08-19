#  🚗 Ride-Sharing Data Model Project

A relational database design for a ride-hailing platform (Uber/Ola-style), covering drivers, riders, vehicles, rides, payments, and ratings.

## Overview

This project models the core entities and relationships needed to run a ride-hailing service:

- **Driver** and **Rider** profiles
- **Vehicle** registration linked to drivers
- **Ride** lifecycle — request, pickup/drop coordinates, completion, cancellation
- **Payment** processing per ride
- **Rating** feedback per completed ride

The schema is normalized to 3NF, with foreign keys and indexes defined for all relationships.

## Entity Relationship Diagram
<img width="1634" height="1320" alt="data-model" src="https://github.com/user-attachments/assets/3f64d046-f944-48a6-b671-63e67b6428f1" />

## Schema Summary

| Table     | Purpose                                              |
|-----------|-------------------------------------------------------|
| `DRIVER`  | Driver profile, activity status, availability         |
| `RIDER`   | Rider profile and aggregate rating                     |
| `VEHICLE` | Vehicle details, one-to-one with driver                |
| `RIDE`    | Core ride record — links driver, rider, vehicle, payment, rating |
| `PAYMENT` | Transaction details per ride                            |
| `RATING`  | Score and comment per completed ride                    |

### Key relationships

- `DRIVER 1 — N RIDE`
- `RIDER 1 — N RIDE`
- `DRIVER 1 — 1 VEHICLE`
- `RIDE 1 — 1 PAYMENT`
- `RIDE 1 — 1 RATING` (nullable — a ride may be unrated)

## Design notes

- `RIDE.rating_id` is nullable and set only after a rating is submitted (`ON DELETE SET NULL`), avoiding a circular insert dependency between `RIDE` and `RATING`.
- `RATING` references `ride_id` only — driver/rider can be derived via a join on `RIDE`, avoiding transitive dependency.
- `PAYMENT` has no direct `rider_id`; it's derivable through `RIDE`.
- Money fields (`ride_fare`, `amount`) use `DECIMAL` rather than floating-point types to avoid rounding errors.
- `DRIVER.total_ride` and `RIDER.rating` are denormalized aggregate fields, intended to be maintained via application logic or triggers for fast reads.

## Project structure

```
ride-hailing-db-schema/
├── README.md
├── schema/
│   └── schema.sql          # Full DDL: tables, constraints, foreign keys, indexes
├── erd/
│   ├── erd-diagram.png     # Visual entity-relationship diagram
│   └── data-model.json     # Exported schema model (source for the ERD tool)
└── docs/                   # Additional notes / future documentation
```

## Setup

Run the schema against any PostgreSQL-compatible database:

```bash
psql -U <username> -d <database_name> -f schema/schema.sql
```

## Tech

- SQL (PostgreSQL-flavored DDL)
- ERD designed with [dbdiagram-style schema tool]

## Status

Schema design phase — no application layer yet. Structure is set up to extend with a backend (API + queries) in future iterations.

## License

MIT
