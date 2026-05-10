# Shay-Rolls Claude Core

> Military-grade coding discipline for teams using Claude Code Enterprise.
> Built by [Giggso](https://giggso.com). MIT License.

## Install — One Command

```bash
curl -fsSL https://raw.githubusercontent.com/giggso/shay-rolls-claude/main/install.sh | bash
```

Then from **any project directory**:
```bash
cd YourProject && shay-rolls-setup
```

That's it. Two commands total. No zip. No path hunting.

---


---

## What It Does

Enforces consistent coding standards, stack discipline, and production safety across distributed dev teams — without killing developer productivity.

| During coding | At git commit | At CI/CD |
|---|---|---|
| Agents advise | Pre-commit hook blocks | Pipeline validates |
| Skills guide | CVE check fires | Thin trigger only |
| No hard blocks | All violations caught | Last safety net |

---

## Components

### Core Agents (`.claude/agents/`)

| Agent | Fires On | Action |
|---|---|---|
| `manifest-checker` | Every action | Hard block if manifest missing |
| `style-enforcer` | File edit | Advise during coding, block at commit |
| `stack-validator` | Import detected | CVE check, approval flow |
| `architecture-guard` | New file | Warn → 24h grace → block |

### Skills (`.claude/skills/shay-rolls-core/`)

Progressive disclosure — ~100 tokens at startup, rules load only when triggered.

| Rule file | Loads when |
|---|---|
| `rules/stack.md` | Import or library detected |
| `rules/style.md` | Style check triggered |
| `rules/architecture.md` | New file created |
| `rules/commit.md` | Git commit attempted |

### Commands (`.claude/commands/`)

| Command | Does |
|---|---|
| `/shay-scaffold` | Plan before code — dependency map + file structure |
| `/shay-approve {lib}` | Architect approves library request |
| `/shay-debug` | Full boot diagnostic |
| `/incident {p1\|p2\|p3}` | Manual incident record |

### Scripts (`.claude/scripts/`)

| Script | Does |
|---|---|
| `cve-check.py` | Three-tier CVE — PyPI Safety + GPT-5.4-Cyber |
| `secret-scan.py` | Detects API keys, passwords, tokens in staged files |
| `setup-claudemem.sh` | Installs Claude Mem (95% token reduction) |

### Pre-commit Hook (`.git/hooks/pre-commit`)

5 checks — any failure = hard block:

1. Manifest valid
2. Secrets not staged
3. CVE check on all imports
4. Style violations (print, lines, type hints)
5. File deletions without `[GUARD:ALLOW-DELETE]` flag

---

## Library Approval — Three Tiers

| Tier | Condition | Result |
|---|---|---|
| 1 | Org whitelist | Auto-approved, zero friction |
| 2 | Category whitelist | Auto-approved, zero friction |
| 3 | Unknown | Approval flow → email Prism7 → PR |
| 3 | CVE CVSS >7 | Hard block, no override |

---

## Install

```bash
cd YourProject && git init
bash ../shay-rolls-claude/shay-rolls-setup.sh
```

See [HOW-TO-USE.md](HOW-TO-USE.md) for full setup guide.

---

## Repo Structure

```
shay-rolls-claude/
├── CLAUDE.md                        ← Claude Code entry point
├── HOW-TO-USE.md                    ← Full enterprise guide
├── README.md
├── LICENSE
├── shay-rolls-setup.sh               ← Setup script
├── core/
│   ├── agents/                      ← 4 Core agents
│   ├── skills/shay-rolls-core/      ← Progressive disclosure skill
│   ├── commands/                    ← /scaffold /approve /debug /incident
│   ├── hooks/                       ← pre-commit + settings.json
│   ├── scripts/                     ← cve-check.py secret-scan.py setup-claudemem.sh
│   └── ci/                         ← github-actions.yml gitlab-ci.yml on-prem-pipeline.sh
├── manifest/                        ← Schema + examples
└── templates/                       ← architecture.md template
```

---

## Companion Repo

**[shay-rolls-claude-guard](https://github.com/giggso/shay-rolls-claude-guard)**
Production protection — Git watch, DB watch, Infra watch, Firewall watch, Incident management.
Install after Core. Separate audience (DevOps/architects).

---

## License

MIT — [Giggso](https://giggso.com)
