# Operation Container Rescue

**A Docker Desktop Hackathon**

Welcome, Container First Responder! A critical distributed application has gone down and you have been called in to rescue it. Each fix you make reveals a **flag** (secret code). Collect as many flags as you can in 75 minutes!

## Scoring

| Tier | # | Challenge | Points |
|------|---|-----------|--------|
| Tier 1 - Container Basics | 1 | The Broken Build | 10 pts |
| | 2 | The Missing Link | 10 pts |
| | 3 | The Bloated Image | 10 pts |
| Tier 2 - Compose and Networking | 4 | Network Nightmare | 20 pts |
| | 5 | Volume Vanishing Act | 20 pts |
| | 6 | Health Check Hero | 20 pts |
| Tier 3 - Kubernetes and KinD | 7 | KinD Deployment | 30 pts |
| | 8 | Service Exposure | 30 pts |
| Tier 4 - Resilience (Coming Soon) | 9 | The Failover Finale | TBD |
| | | **Maximum Total** | **150 pts** |

**Time bonus:** First to complete all 8 flags gets +25 pts. Second +15 pts. Third +10 pts.

> **Bonus:** Get Challenge 3's image under 20MB for a special badge on your leaderboard!

## Getting Started

### 0. Start Your Leaderboard

```bash
docker run -d -p 9000:9000 -v leaderboard-data:/data --name leaderboard rescue-leaderboard:latest
```

Open **http://localhost:9000** in your browser. Your progress will update automatically as you complete challenges.

### 1. Verify Your Environment

```bash
./scripts/setup-check.sh
```

This validates that you have Docker Desktop running, Kubernetes enabled in KinD mode, and kubectl ready to go.

### 2. Start Rescuing!

Work through the challenges in order (Tier 1 through Tier 3). Each challenge folder contains:

- `README.md` - The problem description and hints
- Broken files to fix (Dockerfiles, compose files, manifests)
- `validate.sh` - Run this to check your solution and reveal the flag

### 3. Track Your Progress

Your leaderboard at **http://localhost:9000** updates automatically each time you run a `validate.sh` script. It tracks your flags, completion times, and challenge-specific metrics. No need to note anything down manually.

## Challenge Structure

```
operation-container-rescue/
├── tier1-basics/
│   ├── challenge1-broken-build/
│   ├── challenge2-missing-link/
│   └── challenge3-bloated-image/
├── tier2-compose/
│   ├── challenge4-network-nightmare/
│   ├── challenge5-volume-vanishing/
│   └── challenge6-health-check-hero/
├── tier3-kubernetes/
│   ├── challenge7-kind-deployment/
│   └── challenge8-service-exposure/
├── tier4-resilience/           <- coming soon
│   └── challenge9-failover-finale/
├── leaderboard/                <- personal progress dashboard
└── scripts/
    └── setup-check.sh
```

## Rules

1. No internet access to Docker Hub - use internal registry images only
2. Work individually or in pairs (your choice)
3. Ask for help if you are truly stuck - learning is the goal!
4. Have fun!

## When Time Is Called

1. Stop where you are
2. Your leaderboard shows your final score, all captured flags, and completion timestamps - leave it open for the host to verify
3. Wait for the host to call out scores

**Good luck, First Responder. Those containers are counting on you!**
