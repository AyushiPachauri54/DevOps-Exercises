# Exercise 7 – Introduction to CI and Jenkins installation

**Status: 🔴 BLOCKED – documentation done, installation NOT executed** (no Docker here, and Jenkins could not be downloaded).

## Question (original text in [`QUESTION.md`](QUESTION.md))
Understand Continuous Integration (CI), its benefits and tools, understand Jenkins, and **install Jenkins with Docker**, unlock it with the initial admin password and reach the landing page on port 8080.

## Objective & prerequisites
Have a working Jenkins server for Exercises 6, 8 and 9. Needs Docker.

## Commands
```bash
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
docker ps
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword   # copy this
# browser: http://localhost:8080 → paste password → Install suggested plugins → create admin user
```
(`-v jenkins_home:…` keeps your jobs if the container is recreated – the manual's first command lacks it.)

## Short notes (own words)
* **CI**: developers merge small changes to a shared repo often; every push triggers an automatic build + tests, so bugs are found early.
* **Benefits**: early bug detection, less integration pain, faster releases, quality via automated tests.
* **Flow**: push → CI server notices → build → test → report result.
* **Other tools**: GitLab CI, CircleCI, Travis CI, Bamboo, TeamCity, Azure Pipelines, GitHub Actions, Spinnaker, Buildkite, Drone.
* **Jenkins**: open-source automation server. Key terms: *job/project*, *build*, *pipeline*, *plugin*, *node/agent*. Port 8080 = web UI, 50000 = agents.
* **Security note:** the initial admin password shown in the manual is an example – generate your own; never commit it.

## Verification
| Check | Result |
|---|---|
| Jenkins container running, unlock page, landing page | ⛔ **not run** |

No screenshots exist because nothing was executed.

## To finish (needs you)
Run the commands above; screenshots: `01-docker-ps.png`, `02-unlock-jenkins.png`, `03-jenkins-dashboard.png`.
