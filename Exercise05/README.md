# Exercise 5 – Docker security with AppArmor and Python

**Status: 🔴 BLOCKED – written but NOT executed.** Needs Linux with AppArmor + Docker. Only a Python syntax check was done.

## Question (original text in [`QUESTION.md`](QUESTION.md))
Containerise a Flask app, write an **AppArmor profile** that blocks sensitive files (`/etc`, `/var`) and execution of binaries, load it with `apparmor_parser`, run the container with `--security-opt apparmor=my-apparmor-profile`, apply it using the **Docker SDK for Python** (`apply_apparmor.py`), test restricted actions (`test_restricted_actions.py`: read `/etc/passwd`, run `/bin/bash`), and answer 5 questions.

## Files
`app.py`, `Dockerfile`, `my-apparmor-profile`, `apply_apparmor.py`, `test_restricted_actions.py`, `run.sh`.

## How to run (Ubuntu/Debian host with Docker)
```bash
bash run.sh
```

## Changes to the manual
1. The manual's profile starts with `/usr/bin/python3 { … }`. Docker selects a profile **by name**, so `apparmor=my-apparmor-profile` would not find it. I declared `profile my-apparmor-profile flags=(attach_disconnected,mediate_deleted) { … }` (the form Docker's own default profile uses) and added `#include <abstractions/base>`.
2. The manual's `deny /etc/** r` would also stop Python from reading its own config and probably break the container; I deny only `/etc/passwd` and `/etc/shadow`. **This profile is untested – expect to adjust it when you run it** (check `dmesg | grep apparmor` or `journalctl` for DENIED lines).
3. Scripts now also remove the container after stopping it.
4. The "expected output" in the manual (exit 1 / 126 with empty output) is only an example; the real exit codes/messages will be what your run prints – put those in your report.

## Simple explanation
AppArmor is a Linux security module: a profile lists what a program may touch. With Docker, `--security-opt apparmor=<name>` confines the container to that profile, so even if the app is hacked it cannot read secrets or start a shell. `deny` rules always beat `allow` rules.

## Verification
| Check | Result |
|---|---|
| 3 Python files compile | ✅ [`logs/static-checks.txt`](logs/static-checks.txt) |
| `apparmor_parser`, Docker present here | ❌ not installed → profile not loaded, no container tests |
| profile accepted, container runs, `cat /etc/passwd` and `/bin/bash` blocked | ⛔ **not run** |

## Answers
1. AppArmor adds an extra layer: it limits files, network and capabilities the container's processes can use. 2. A profile defines allowed/denied actions (files, execution, network, capabilities) so a compromised app is contained. 3. `/etc` and `/var` hold configs, users, logs and secrets – leaking or modifying them leads to privilege escalation. 4. Network access, executing binaries, writing paths, mounting, capabilities such as `sys_admin`. 5. `docker inspect <container>` → `HostConfig.SecurityOpt` (also `aa-status` on the host, and `cat /proc/1/attr/current` inside the container).

## To finish (needs you)
`bash run.sh` on Ubuntu; screenshots: `01-aa-status.png`, `02-apply-output.png`, `03-restricted-tests.png`.
