# GoodNight

This GoodNight using Ruby 3.1.2 (see `.ruby-version`) and Rails 7.0.5 (see `Gemfile`).

# Usage

First run setup to init database, default using local sqlite3.

```sh
$ bin/setup
```

Only once, to add default users:

```sh
$ bin/rails db:seed
```

Spawn the server:

```sh
$ bin/rails server
```

To create user, please use rails console:

```sh
$ bin/rails console

irb> User.create(name: "Joe")

=> #<User:0x1234 id: 5, name: "Joe"
```

# Testing

Test using default rails/minitest:

```sh
$ bin/rails test
```

# Design

This simple sleep tracker, using REST API, and single database.

```

            +------+      +---------+
Client <--> | API  | <--> |   DB    |
            +------+      +---------+

```
## Database

### users

+ id: pk
+ name

### follows

+ user_id: fk-> users.id
+ target_id: fk-> users.id

### sleeps

+ id: pk
+ user_id: fk -> users.id
+ sleep_at
+ wakeup_at
+ duration: in seconds

## APIs:

### GET /users

List all users.

+ Response 200 (application/json)

    ```json
    [
        {
            "id": 234,
            "name": "John",
        },
        ...
    ]
    ```

### GET /users/{id}/follows

List friends.

+  Response 200 (application/json)

    ```json
    [
        {
            "id": 234,
            "name": "John",
        },
        ...
    ]
    ```

### POST /users/{id}/follows/{target_id}

Follow target id.

+ Response 200

### DELETE /users/{id}/follows/{target_id}

Unfollow target id.

+ Response 200

### POST /users/{id}/sleeps

Add user sleeps.

+ Request (application/json)

    ```json
    {
        "sleep_at": "2023-05-10T20:00:00.000Z",
        "wakeup_at": "2023-05-11T05:00:00.000Z",
    }
    ```

+ Response 201

    ```json
    {
        "id": 1
    }
    ```

### GET /users/{id}/sleeps

List current user sleep records.

+ Response 200 (application/json)

    ```json
    [
        {
            "sleep_at": "2023-05-10T20:00:00.000Z",
            "wakeup_at": "2023-05-11T05:00:00.000Z",
            "duration": 32400
        },
        ...
    ]
    ```

### GET /users/{id}/follows/sleeps

Return all friends sleep records within past week ordered by duration.

+ Response 200 (application/json)

    ```json
    [
        {
            "sleep_at": "2023-05-10T20:00:00.000Z",
            "wakeup_at": "2023-05-11T05:00:00.000Z",
            "duration": 32400,
            "user": {
                "id": 10,
                "name": "John"
            }
        },
        ...
    ]
    ```
