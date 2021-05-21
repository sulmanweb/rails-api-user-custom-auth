# README

created by @[sulmanweb](https://sulmanweb.com)

### Built With

- Docker
- Ruby 2.7.3
- Postgresql
---

## How To Run

1. Install [Docker](https://www.docker.com/)

2. In terminal run
    ```bash
    docker compose up -d --build 
    ```

3. After operation completes, run:
    ```bash
    docker compose run web rails db:create
    ```

4. Finally run:
    ```bash
    docker compose run web rails db:migrate
    ```

5. The app is available now at [http://localhost:3000](http://localhost:3000)

6. To run the console run:
    ```bash
    docker compose run web rails console
    ```
---

## Services

**Sign Up**

`POST` [http://localhost:3000/auth/sign_up](http://localhost:3000/auth/sign_up)
```json
{
    "email": "hello@hello.com",
    "password": "abcd@1234",
    "name": "Hello World"
}
```

**Destroy Self User**

`DELETE` [http://localhost:3000/auth/destroy](http://localhost:3000/auth/destroy)

`headers`

```
Authorization: Bearer xxxxxxxxx
```
Empty Body

**Sign In**

`POST` [http://localhost:3000/auth/sign_in](http://localhost:3000/auth/sign_in)
```json
{
    "email": "hello@hello.com",
    "password": "abcd@1234"
}
```

**Validate Token**

`GET` [http://localhost:3000/auth/validate_token](http://localhost:3000/auth/validate_token)

`headers`

```
Authorization: Bearer xxxxxxxxx
```

**Sign Out**

`DELETE` [http://localhost:3000/auth/sign_out](http://localhost:3000/auth/sign_out)

`headers`

```
Authorization: Bearer xxxxxxxxx
```

**Confirm Email**

`GET` [http://localhost:3000/auth/confirm_email](http://localhost:3000/auth/confirm_email)

`query params`

```
token: xxxxxxxxx
```

**Resend Confirmation Email**

`PUT` [http://localhost:3000/auth/resend_confirm_email](http://localhost:3000/auth/resend_confirm_email)

`headers`

```
Authorization: Bearer xxxxxxxxx
```
Empty Body

**Forgot Password Request**

`POST` [http://localhost:3000/auth/forgot_password_email](http://localhost:3000/auth/forgot_password_email)

```json
{
    "email": "hello@world.com"
}
```

**Verify Forgot Password Token Received In Email**

`GET` [http://localhost:3000/auth/verify_reset_password_email](http://localhost:3000/auth/verify_reset_password_email)

`query params`

```
token: xxxxxxxxx
```

**Change Password For Logged In User**

`PUT` [http://localhost:3000/auth/reset_password](http://localhost:3000/auth/reset_password)

`headers`

```
Authorization: Bearer xxxxxxxxx
```

OR `query params`

```
token: xxxxxxxxx
```

```json
{
    "password": "abcd@1234",
    "confirm_password": "abcd@1234"
}
```
---
## License

**MIT**