# Exercise 5 – Docker Security with AppArmor and Python

## Overview

This exercise demonstrates how to secure a Flask application running inside a Docker container using AppArmor. An AppArmor profile is configured and applied to the container using Docker's security options and the Docker SDK for Python.

The exercise also tests whether restricted actions, such as reading `/etc/passwd` and executing `/bin/bash`, are prevented by the configured security profile.

## Project Files

- `app.py` – Flask application.
- `Dockerfile` – Configuration for building the Docker image.
- `my-apparmor-profile` – AppArmor security profile.
- `apply_apparmor.py` – Applies the AppArmor profile using the Docker SDK for Python.
- `test_restricted_actions.py` – Tests restricted actions inside the container.
- `run.sh` – Script to run the exercise.
- `QUESTION.md` – Original assignment questions and answers.
- `logs/` – Directory for execution logs and verification results.

## Requirements

- Linux system with AppArmor enabled.
- Docker installed and running.
- `apparmor_parser` utility.
- Python 3 and pip.
- Docker SDK for Python.

**Note:** AppArmor is a Linux security feature. Run this exercise on a compatible Linux system with AppArmor enabled.

## Execution

Navigate to the Exercise 5 directory and run:

```bash
bash run.sh
```

The script is intended to perform the exercise's setup and testing steps. If any command fails, investigate the error before proceeding.

## Security Configuration

The AppArmor profile is named `my-apparmor-profile` and defines restrictions intended to limit access to sensitive files and execution of selected binaries.

The Docker container is configured to use the profile through Docker's `security-opt` option. The Python scripts use the Docker SDK to apply the configuration and test restricted actions.

## Verification

After execution, verify the following:

- AppArmor is enabled and the profile is loaded.
- The Docker image builds successfully.
- The container starts with the intended AppArmor profile.
- The test for reading `/etc/passwd` produces the expected security result.
- The test for executing `/bin/bash` produces the expected security result.
- Docker inspection and AppArmor logs are checked for confirmation.

Record the actual output and results from your run. Do not mark a test as passed unless it has been executed and verified.

## Screenshots

Save screenshots of your actual execution in the `screenshots/` directory.

Suggested filenames:

- `01-aa-status.png` – AppArmor status.
- `02-apply-output.png` – Output from applying the profile.
- `03-restricted-tests.png` – Results of the restricted-action tests.




## Conclusion

This exercise demonstrates the use of AppArmor to add security restrictions to Docker containers and the use of Python's Docker SDK to configure and inspect container security. The final results should be based on the actual execution and verification performed.
