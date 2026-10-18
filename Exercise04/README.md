# Exercise 4: Docker Networking with Multiple Containers

## Objective

To understand Docker networking and configure communication between a Flask REST API, MySQL database, and Redis cache using a user-defined bridge network.

## Architecture

```text
          +----------------------+
          |     User / Browser   |
          +----------+-----------+
                     |
                     | HTTP :5001
                     v
          +----------------------+
          |      Flask API       |
          |    /about endpoint   |
          +----------+-----------+
                     |
             Docker Bridge Network
                my-bridge-net
                     |
            +--------+--------+
            |                 |
            v                 v
     +-------------+   +-------------+
     |    MySQL    |   |    Redis    |
     |  Database   |   |    Cache    |
     |   :3306     |   |   :6379     |
     +-------------+   +-------------+
```

## Files

- `app.py` – Flask REST API with an `/about` endpoint.
- `requirements.txt` – Python dependencies.
- `Dockerfile` – Instructions to build the Flask image.
- `run.sh` – Script for setup, testing, and cleanup.
- `QUESTION.md` – Original lab instructions and questions.

---

## Part 1: Verify Docker

Check that Docker is installed and running.

```bash
docker --version
docker info
docker ps
```


![Docker Verification](screenshots/01-docker-verification.png)

---

## Part 2: Create the Working Directory

Create a directory for the lab if you do not already have one.

```bash
mkdir docker-networking-lab
cd docker-networking-lab
```


---

## Part 3: Create a Bridge Network

Create a user-defined bridge network named `my-bridge-net`.

```bash
docker network create --driver bridge my-bridge-net
```

Verify that the network exists.

```bash
docker network ls
```


![Network Created](screenshots/02-network-created.png)

---

## Part 4: Inspect the Network

Display the network configuration.

```bash
docker network inspect my-bridge-net
```



![Network Inspected](screenshots/03-network-inspected.png)

---

## Part 5: Prepare the Flask Application

The Flask application provides an `/about` endpoint that returns the API name, version, and description in JSON format.

The application should listen on port `5001` and bind to `0.0.0.0` to accept connections from outside the container.

```python
app.run(host="0.0.0.0", port=5001, debug=False)
```

---

## Part 6: Configure Dependencies

The `requirements.txt` file contains the required Python packages.

```text
Flask==2.0.1
Werkzeug==2.0.3
```

Werkzeug is pinned to a compatible version for Flask 2.0.1.

---

## Part 7: Build the Flask Image

Build the Docker image using the Dockerfile.

```bash
docker build --no-cache -t flask-api .
```

Verify that the image has been created.

```bash
docker images
```



![Flask Image](screenshots/04-flask-image-built.png)

---

## Part 8: Test the Flask API

Start a temporary container and publish port `5001`.

```bash
docker run -d --name flask-test -p 5001:5001 flask-api
```

Test the endpoint.

```bash
curl http://localhost:5001/about
```

Expected response:

```json
{
  "name": "Simple REST API",
  "version": "1.0",
  "description": "This is a simple REST API built with Flask."
}
```

After testing, remove the temporary container.

```bash
docker stop flask-test
docker rm flask-test
```

![Flask API Test](screenshots/05-flask-api-test.png)

---

## Part 9: Start the MySQL Container

Run MySQL on the bridge network.

```bash
docker run -d \
  --name mysql \
  --network my-bridge-net \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  -e MYSQL_DATABASE=devopsdb \
  mysql:latest
```

The environment variables configure the initial root password and create the `devopsdb` database.

---

## Part 10: Start the Redis Container

Run Redis on the same bridge network.

```bash
docker run -d \
  --name redis \
  --network my-bridge-net \
  redis:latest
```

Redis uses port `6379` inside the container by default.

---

## Part 11: Start the Flask Container

Start Flask on the same network and publish its port to the host.

```bash
docker run -d \
  --name flask \
  --network my-bridge-net \
  -p 5001:5001 \
  flask-api
```

The `-p` option maps host port `5001` to container port `5001`.

---

## Part 12: Verify the Containers

Check which containers are running.

```bash
docker ps
```



![Running Containers](screenshots/06-containers-running.png)

---

## Part 13: Test Container Name Resolution

Check whether Flask can resolve the MySQL and Redis container names.

```bash
docker exec flask getent hosts mysql
docker exec flask getent hosts redis
```

Docker's embedded DNS resolves container names on a user-defined bridge network.



![DNS Resolution](screenshots/07-dns-resolution.png)

---

## Part 14: Test Redis

Run a ping command against Redis.

```bash
docker exec -it redis redis-cli ping
```

Expected response:

```text
PONG
```

![Redis Test](screenshots/08-redis-test.png)

---

## Part 15: Test MySQL

Connect to MySQL and list the databases.

```bash
docker exec mysql mysql -uroot -prootpass -e "SHOW DATABASES;"
```



![MySQL Test](screenshots/09-mysql-test.png)

---

## Part 16: Verify the Flask API

Test the API after all three containers have been started.

```bash
curl http://localhost:5001/about
```



![Final API Test](screenshots/10-final-api-test.png)

---

## Part 17: Final Verification Checklist

| Check | Command |
|---|---|
| Docker status | `docker info` |
| Network created | `docker network ls` |
| Network inspected | `docker network inspect my-bridge-net` |
| Image built | `docker images` |
| Containers running | `docker ps` |
| MySQL name resolution | `docker exec flask getent hosts mysql` |
| Redis name resolution | `docker exec flask getent hosts redis` |
| Redis service | `docker exec redis redis-cli ping` |
| MySQL service | `docker exec mysql mysql -uroot -prootpass -e "SHOW DATABASES;"` |
| Flask API | `curl http://localhost:5001/about` |

---

## Part 18: Cleanup

Stop the containers.

```bash
docker stop mysql redis flask
```

Remove the containers.

```bash
docker rm mysql redis flask
```

Remove the bridge network.

```bash
docker network rm my-bridge-net
```

Optionally, remove the Flask image.

```bash
docker rmi flask-api
```

Verify that the network has been removed.

```bash
docker network ls
```

![Cleanup](screenshots/11-cleanup.png)

---


---

## Conclusion

This exercise demonstrates how to create and inspect a user-defined bridge network, build a Flask Docker image, run multiple containers on the same network, test container name resolution, verify the MySQL and Redis services, publish a port, and clean up Docker resources.

## References

- [Docker Networking Documentation](https://docs.docker.com/engine/network/)
- [Docker Bridge Network Documentation](https://docs.docker.com/engine/network/drivers/bridge/)
