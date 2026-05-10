#!/bin/bash
# Shay-Rolls — On-prem CI pipeline
# Run on your Jenkins/Gitea/self-hosted runner
set -e
python3 -c "import json; json.load(open('.shay-rolls/manifest.json'))" && echo "✅ Manifest valid"
python3 .claude/scripts/secret-scan.py && echo "✅ No secrets"
echo "✅ Shay-Rolls CI passed"
