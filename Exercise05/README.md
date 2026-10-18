# Exercise 5 – Docker Security with AppArmor and Python

## Objective

To secure a Docker container using an AppArmor profile and apply security restrictions using Python's Docker SDK.

## Files

- `app.py` – Flask application
- `Dockerfile` – Docker image configuration
- `my-apparmor-profile` – AppArmor security profile
- `apply_apparmor.py` – Applies the AppArmor profile
- `test_restricted_actions.py` – Tests restricted actions
- `run.sh` – Execution script

## Task 1 & 2: Flask Application and Docker Image

Build the Docker image:

```bash
docker build -t flask-apparmor .
```

## Task 3: Load and Apply AppArmor Profile

Load the AppArmor profile:

```bash
sudo cp my-apparmor-profile /etc/apparmor.d/my-apparmor-profile
sudo apparmor_parser -r /etc/apparmor.d/my-apparmor-profile
```

Run the container with the AppArmor profile:

```bash
docker run --security-opt="apparmor=my-apparmor-profile" -p 5000:5000 flask-apparmor
```

## Task 4: Apply AppArmor Using Docker SDK

Install the Docker SDK:

```bash
python3 -m pip install docker
```

Run the Python script:

```bash
python3 apply_apparmor.py
```

## Task 5: Test Restricted Actions

Run the test script:

```bash
python3 test_restricted_actions.py
```

## Screenshots

Add screenshots of the command execution and test output below.

## Conclusion

The exercise covers Docker image creation, AppArmor profile configuration, applying container security through Python, and testing restricted actions.

