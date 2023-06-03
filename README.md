# GoodNight

This GoodNight using Ruby 3.1.2 (see `.ruby-version`) and Rails 7.0.5 (see `Gemfile`).

# Design


## Database

### users

+ id: pk
+ name

### sleeps

+ id: pk
+ user_id: fk -> users.id
+ sleep_at
+ wakeup_at
+ duration

### follows

+ user_id: fk-> users.id
+ user_target_id: fk-> users.id

## APIs:

### GET /users

List all users

+ Response 200 (application/json)

    [
        {
            "id": 234,
            "name": "John",
        },
        ...
    ]

### POST /users/{id}/follows/{target_id}

Follow target id.

+ Response 200

### DELETE /users/{id}/follows/{target_id}

Unfollow target id.

+ Response 200

### GET /users/{id}/sleeps

Return all friends sleep records within past week ordered by duration.

+ Response 200 (application/json)

    [
        {
            "user_id": 10,
            "name": "John",
            "sleep_at": "2023-05-10T20:00:00.000Z",
            "wakeup_at": "2023-05-11T05:00:00.000Z",
            "duration", "09:00:00"
        },
        ...
    ]

---

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
