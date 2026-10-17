# DevOps-Exercises

Solutions to the 10 exercises assigned from the instructor's repository `sunagP/DevOps-Lab` → `Exercises/` (files `1-…` to `10-…`). Each folder contains the **original question verbatim** (`QUESTION.md`), the code/config, `run.sh` with every command, a README with explanations and Q&A, `logs/` (real captured output) and `screenshots/`.

> **Honesty note.** This project was prepared in a sandbox that had **Python, Flask, Git and curl only** – no Docker, Minikube, kubectl, Jenkins, AppArmor or Prometheus/Grafana. Everything that could run there *was* run; everything else is marked ⛔ **not run**. The PNG files in `screenshots/` named `terminal-capture-*.png` are **images rendered from the real log files** (`tools_render_log.py`), not GUI screenshots. Real screenshots of Kubernetes/Jenkins/Grafana still have to be taken by running each exercise's `run.sh` on a suitable machine.

## Index and verification status
| # | Exercise | Folder | Status | What was really executed | Not executed |
|---|---|---|---|---|---|
| 1 | Kubernetes Hello Pod | [Exercise01](Exercise01) | 🔴 BLOCKED | YAML syntax check | everything on Minikube |
| 2 | Flask on Minikube (kubectl + YAML) | [Exercise02](Exercise02) | 🟡 PARTIAL | Flask app + curl, YAML syntax | docker build, deploy |
| 3 | Scaling with ReplicaSets | [Exercise03](Exercise03) | 🟡 PARTIAL | Flask endpoints + curl, YAML syntax | build, RS, scale, self-heal |
| 4 | Docker networking | [Exercise04](Exercise04) | 🟡 PARTIAL | Flask API + curl | all Docker network/containers |
| 5 | Docker security – AppArmor | [Exercise05](Exercise05) | 🔴 BLOCKED | Python syntax check | profile, container tests |
| 6 | Prometheus/Grafana monitoring | [Exercise06](Exercise06) | 🔴 BLOCKED | Python/YAML syntax checks | metrics run, Prometheus, Grafana, Jenkins |
| 7 | CI intro + Jenkins install | [Exercise07](Exercise07) | 🔴 BLOCKED | – (notes written) | Jenkins install |
| 8 | Jenkins Hello-World job | [Exercise08](Exercise08) | 🟡 PARTIAL | script run, local git init/add/commit | GitHub push, Jenkins job |
| 9 | Jenkins multi-stage pipeline | [Exercise09](Exercise09) | 🟡 PARTIAL | unit test, deploy, app run & curl (by hand) | pipeline inside Jenkins |
| 10 | Multi-node, multi-app Minikube | [Exercise10](Exercise10) | 🟡 PARTIAL | both services + curl, YAML syntax | 3-node cluster, anti-affinity |

**No exercise is marked fully ✅ PASS**, because none could be run end-to-end here.

## How to run
Each exercise: `cd ExerciseNN && bash run.sh` (read the README first; Ex. 6 is in `Exercise06/delivery_monitoring/`). Needs: Docker, Minikube + kubectl (Ex. 1-3, 10), Docker (4-7), Ubuntu with AppArmor (5), Python 3.10+ (all), a GitHub account + fine-grained PAT (8-9).
Suggested order on your machine: 7 → 1 → 2 → 3 → 10 → 4 → 5 → 8 → 9 → 6.

## Corrections to the manual that I found
The original markdown contains several errors that would stop it from working (file names, missing Dockerfile, wrong namespace, mysql without password, profile name…). Each exercise README lists the fixes under "Fixes"/"Changes".

## Git / GitHub (terminal only, as required)
Commits were created locally with real `git` commands. **Nothing has been pushed** – I have no access to your GitHub account. Do this on your computer:
```bash
cd DevOps-Exercises
git config user.name  "<your real name>"          # history below was committed with a placeholder identity
git config user.email "<your GitHub e-mail>"
git rebase -r --root --exec 'git commit --amend --no-edit --reset-author'   # re-author existing commits with the identity above
# create an EMPTY private repo named DevOps-Exercises on github.com (no README), then:
git remote add origin https://github.com/AyushiPachauri54/DevOps-Exercises.git
git branch -M main
git push -u origin main        # username + personal access token (or: gh auth login)
git log --oneline ; git remote -v ; git status
```
