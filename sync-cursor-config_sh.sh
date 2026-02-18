#!/bin/sh
# Syncs flutter-cursor-config: submodule at .cursor/global, symlinks rules/skills/commands into
# .cursor/, and copies skills to ~/.cursor/skills/ so Cursor's agent discovers them.
set -e

REPO_URL="https://github.com/reglobe/flutter-cursor-config.git"
BASE_DIR=".cursor"
SUBMODULE_DIR=".cursor/global"
BACKUP_DIR=".cursor_backup_$(date +%s)"

echo "Syncing Cursor global config..."

# Function: check if path is registered submodule
is_submodule() {
    git config --file .gitmodules --get-regexp path | grep -q "$1" 2>/dev/null
}

# Function: symlink each file in global/rules, global/skills, global/commands into .cursor/rules,
# .cursor/skills, .cursor/commands so global files sit alongside any local files in the same dir.
# - Ensures .cursor/$dir is a directory (if it was a symlink, replace with dir + per-file symlinks).
# - Removes old $dir/global symlink if present.
# - For each item in global/$dir/*: symlink at .cursor/$dir/<name> -> global/$dir/<name> (skip if
#   a non-symlink already exists there, so local files are kept).
link_global_to_cursor() {
    _link_cursor_base="$1"
    cd "$_link_cursor_base"
    for dir in rules skills commands; do
        if [ ! -d "global/$dir" ]; then
            continue
        fi
        if [ -L "$dir" ]; then
            rm -f "$dir"
        fi
        if [ ! -e "$dir" ]; then
            mkdir -p "$dir"
        fi
        if [ -e "$dir/global" ]; then
            rm -f "$dir/global"
        fi
        for item in "global/$dir"/*; do
            [ -e "$item" ] || continue
            name=$(basename "$item")
            if [ -e "$dir/$name" ] && [ ! -L "$dir/$name" ]; then
                continue
            fi
            ln -sf "../global/$dir/$name" "$dir/$name"
            echo "  $dir/$name -> global/$dir/$name"
        done
    done
    cd - >/dev/null
}

# Step 1: If WRONG submodule exists at .cursor (not .cursor/global) → remove it cleanly
# Only remove when path is exactly .cursor; .cursor/global is the correct path
submodule_path=$(git config --file .gitmodules --get submodule."$BASE_DIR".path 2>/dev/null || true)
if [ -n "$submodule_path" ] && [ "$submodule_path" = "$BASE_DIR" ]; then
    echo "Removing incorrect .cursor submodule..."

    git submodule deinit -f "$BASE_DIR" || true
    git rm -f "$BASE_DIR" || true
    rm -rf ".git/modules/$BASE_DIR" || true

    echo "Incorrect submodule removed."
fi

# Ensure base directory exists
mkdir -p "$BASE_DIR"

# Step 2: If correct submodule missing → add it
if ! is_submodule "$SUBMODULE_DIR"; then
    # If directory exists but not submodule → backup
    if [ -d "$SUBMODULE_DIR" ] && [ ! -d "$SUBMODULE_DIR/.git" ]; then
        echo "$SUBMODULE_DIR exists but is not a submodule. Backing up to $BACKUP_DIR"
        mv "$BASE_DIR" "$BACKUP_DIR"
        mkdir -p "$BASE_DIR"
    fi

    echo "Adding submodule at $SUBMODULE_DIR ..."
    git submodule add "$REPO_URL" "$SUBMODULE_DIR"
    git submodule update --init --recursive

    echo "Submodule added."
fi

# Step 3: Update existing correct submodule (no-op if we just added it)
if is_submodule "$SUBMODULE_DIR"; then
    echo "Updating existing submodule..."
    git submodule update --remote --merge "$SUBMODULE_DIR"
fi

# Step 4: Create/refresh symlinks so Cursor discovers rules, skills, and commands (incl. any newly added in global)
echo "Linking rules, skills, and commands from global..."
link_global_to_cursor "$BASE_DIR"

# Step 5: Sync skills to user Cursor config so the agent discovers them (Cursor reads ~/.cursor/skills/)
USER_SKILLS_DIR="$HOME/.cursor/skills"
GLOBAL_SKILLS="${BASE_DIR}/global/skills"
if [ -d "$GLOBAL_SKILLS" ]; then
    echo "Syncing skills to user config ($USER_SKILLS_DIR)..."
    mkdir -p "$USER_SKILLS_DIR"
    for skill_dir in "$GLOBAL_SKILLS"/*; do
        [ -d "$skill_dir" ] || continue
        name=$(basename "$skill_dir")
        dest="$USER_SKILLS_DIR/$name"
        mkdir -p "$dest"
        for f in "$skill_dir"/*; do
            [ -e "$f" ] || continue
            fname=$(basename "$f")
            if [ -d "$f" ]; then
                rm -rf "$dest/$fname"
                cp -R "$f" "$dest/$fname"
            else
                cp "$f" "$dest/$fname"
            fi
        done
        # Remove any stray symlinks inside dest (e.g. from a previous run)
        find "$dest" -maxdepth 1 -type l -exec rm {} \; 2>/dev/null || true
        echo "  $name -> $USER_SKILLS_DIR/$name"
    done
    echo "User skills synced."
fi

echo "Sync completed."
