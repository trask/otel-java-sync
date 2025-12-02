#!/usr/bin/env bash
set -euo pipefail

repos=(
  "opentelemetry-java"
  "opentelemetry-java-contrib"
  "opentelemetry-java-examples"
  "opentelemetry-java-instrumentation"
  "opentelemetry-proto-java"
  "semantic-conventions-java"
)

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for repo in "${repos[@]}"; do
  repo_path="${repo_root}/${repo}"
  if [[ ! -d "${repo_path}" ]]; then
    echo "Skipping ${repo}: directory not found" >&2
    continue
  fi

  echo "Processing ${repo}"
  (
    cd "${repo_path}"
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      echo "  Skipping ${repo}: not a git repository" >&2
      exit 0
    fi

    git fetch upstream
    # Stash any local changes before switching branches
    git stash --include-untracked
    if git show-ref --verify --quiet refs/heads/main; then
      git checkout main
    else
      git checkout -b main upstream/main
    fi
    git branch --set-upstream-to=upstream/main main >/dev/null 2>&1 || true
    git reset --hard upstream/main
  )
done
