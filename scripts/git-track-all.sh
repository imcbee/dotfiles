#!/bin/bash

# -----------------------------
# Git Track All Remote Branches
# -----------------------------
# Creates or updates local branches to track remote ones
# without switching your current branch.
# -----------------------------

set -e

# Check if we're inside a Git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "❌ Error: This is not a Git repository."
  exit 1
fi

# Remote to use (default: origin)
remote="origin"

# Check if the remote exists
if ! git remote get-url "$remote" >/dev/null 2>&1; then
  echo "❌ Error: Remote '$remote' does not exist."
  echo "Available remotes:"
  git remote -v
  exit 1
fi

echo "🔄 Fetching all branches from remote: $remote..."
git fetch --all --prune

# Get the current branch so we don't interfere with it
current_branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")

# Loop through remote branches
for remote_branch in $(git branch -r | grep -v '\->'); do
  # Strip 'origin/' prefix to get local branch name
  local_branch="${remote_branch#${remote}/}"

  # Skip special or temporary branches if needed
  if [[ "$local_branch" == "HEAD" ]]; then
    continue
  fi

  # Check if the local branch already exists
  if git show-ref --verify --quiet refs/heads/"$local_branch"; then
    echo "✅ Local branch exists: $local_branch"
    git branch --set-upstream-to="$remote_branch" "$local_branch" 2>/dev/null

    if [[ "$local_branch" == "$current_branch" ]]; then
      echo "🔄 Pulling latest changes for current branch: $local_branch"
      git pull --no-rebase --ff-only
    else
      echo "⏩ Skipping pull on branch '$local_branch' (not currently checked out)"
    fi
  else
    echo "➕ Creating new local branch '$local_branch' to track '$remote_branch'"
    git branch --track "$local_branch" "$remote_branch"
  fi
done

echo "✅ Done. All remote branches are now tracked locally."
