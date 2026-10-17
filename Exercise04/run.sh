#!/bin/bash
# Exercise 4 - needs Docker
set -x
docker network create --driver bridge my-bridge-net
docker network ls
docker network inspect my-bridge-net
docker build -t flask-api .
# mysql refuses to start without a root password, so we pass one
docker run -d --name mysql --net=my-bridge-net -e MYSQL_ROOT_PASSWORD=devops123 mysql:latest
docker run -d --name redis --net=my-bridge-net redis:latest
docker run -d --name flask --net=my-bridge-net -p 5001:5001 flask-api
sleep 5
curl http://localhost:5001/about
# python:slim has no 'ping', so test name resolution + TCP connectivity with python:
docker exec flask python -c "import socket;print('mysql ->',socket.gethostbyname('mysql'));print('redis ->',socket.gethostbyname('redis'))"
docker exec flask python -c "import socket;s=socket.create_connection(('redis',6379),5);print('TCP to redis:6379 OK')"
docker network inspect my-bridge-net
docker stop mysql redis flask && docker rm mysql redis flask
docker network rm my-bridge-net
