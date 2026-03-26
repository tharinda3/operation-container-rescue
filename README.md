# 🐳 Operation Container Rescue

**A Docker Desktop Hackathon**

Welcome, Container First Responder! A critical distributed application has gone down and you've been called in to rescue it. Each fix you make reveals a **flag** (secret code). Collect as many flags as you can in 75 minutes!

## 🏆 Scoring

| Tier | Challenge | Points |
|------|-----------|--------|
| 🟢 Tier 1 | Challenges 1-3 (Container Basics) | 10 pts each |
| 🟡 Tier 2 | Challenges 4-6 (Compose & Networking) | 20 pts each |
| 🔵 Tier 3 | Challenges 7-8 (Kubernetes & KinD) | 30 pts each |
| 🔴 Tier 4 | Challenge 9 (Resilience) | 50 pts |
| | **Maximum Total** | **200 pts** |

**Time bonus:** First to complete all 9 flags gets +25 pts. Second +15 pts. Third +10 pts.

## 🚀 Getting Started

### 1. Verify Your Environment

```bash
./scripts/setup-check.sh
```

This validates you have Docker Desktop, kubectl, and KinD ready to go.

### 2. Start Rescuing!

Work through the challenges in order (Tier 1 → Tier 4). Each challenge folder contains:
- `README.md` — The problem description and hints
- Broken files to fix (Dockerfiles, compose files, manifests)
- `validate.sh` — Run this to check your solution and reveal the flag

### 3. Record Your Flags

When you capture a flag, note it down! Format: `FLAG{xxxxx}`

At the end, we'll count flags and verify completion times.

## 📁 Challenge Structure

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
├── tier4-resilience/
│   └── challenge9-failover-finale/
└── scripts/
    └── setup-check.sh
```

## ⚠️ Rules

1. No internet access to Docker Hub — use internal registry images only
2. Work individually or in pairs (your choice)
3. Ask for help if truly stuck — learning is the goal!
4. Have fun! 🎉

## 🏁 When Time Is Called

1. Stop where you are
2. Note your final flag count and the timestamp of your last flag
3. Wait for the host to call out scores

**Good luck, First Responder. Those containers are counting on you!**
