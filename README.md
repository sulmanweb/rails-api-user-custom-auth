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

---
## License

**MIT**