#!/usr/bin/env bash
# =============================================================================
# migrate-to-nuxt.sh
# Nuxt 3 SSG migration — deterministic filesystem steps
#
# WHAT THIS SCRIPT DOES
# Handles every step that is a pure filesystem or config operation:
#   - Step 2:  Standardize Lighthouse folder
#   - Step 6:  Move images to public/images/, fonts stay in public/fonts/
#   - Step 7:  Rename VITE_ env vars to NUXT_PUBLIC_ in .env.*.example files
#   - Step 11: Update deploy scripts from dist/ to .output/public/
#
# WHAT THIS SCRIPT DOES NOT DO
# Steps that require code generation (Nuxt init, component rewrites,
# analytics rewrite, nginx config updates, actual deploy) are left
# for Copilot task prompts. This script only moves and renames.
#
# IDEMPOTENCY
# Every operation checks whether it has already been done before acting.
# Safe to run more than once — will skip completed steps and report them.
#
# HOW TO RUN
#   cd ~/Projects/web-portfolio
#   bash scripts/migrate-to-nuxt.sh
#
# Review the output line by line. Each action is printed before it runs.
# If anything looks wrong, Ctrl-C stops execution cleanly.
# =============================================================================

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC}  $1"; }
done_()   { echo -e "${GREEN}[DONE]${NC}  $1"; }
skip()    { echo -e "${YELLOW}[SKIP]${NC}  $1"; }
warn()    { echo -e "${RED}[WARN]${NC}  $1"; }
section() { echo -e "\n${BLUE}==============================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}==============================${NC}"; }

# Confirm we are in the right directory
if [[ ! -f "package.json" ]] || ! grep -q "egonzalezcortes\|vue\|vite" package.json 2>/dev/null; then
  warn "This does not look like the egonzalezcortes web-portfolio root."
  warn "Run this script from ~/Projects/web-portfolio"
  exit 1
fi

info "Running from: $(pwd)"

# =============================================================================
# STEP 2 — Standardize Lighthouse folder
# Move all Lighthouse JSON reports from docs/perf/lighthouse/ to docs/lighthouse/
# =============================================================================
section "STEP 2 — Standardize Lighthouse folder"

LIGHTHOUSE_SRC="docs/perf/lighthouse"
LIGHTHOUSE_DEST="docs/lighthouse"

if [[ ! -d "$LIGHTHOUSE_SRC" ]]; then
  skip "Source folder $LIGHTHOUSE_SRC does not exist — already migrated or never present."
else
  mkdir -p "$LIGHTHOUSE_DEST"
  info "Created $LIGHTHOUSE_DEST (or already existed)"

  JSON_COUNT=$(find "$LIGHTHOUSE_SRC" -maxdepth 1 -name "*.json" | wc -l | tr -d ' ')
  info "Found $JSON_COUNT JSON files in $LIGHTHOUSE_SRC"

  if [[ "$JSON_COUNT" -eq 0 ]]; then
    skip "No JSON files to move in $LIGHTHOUSE_SRC"
  else
    while IFS= read -r FILE; do
      BASENAME=$(basename "$FILE")
      DEST_FILE="$LIGHTHOUSE_DEST/$BASENAME"

      if [[ -f "$DEST_FILE" ]]; then
        skip "Already exists at destination: $DEST_FILE"
      else
        # Only move non-empty files; warn on empty ones
        if [[ -s "$FILE" ]]; then
          mv "$FILE" "$DEST_FILE"
          done_ "Moved: $BASENAME"
        else
          warn "Skipping empty file: $BASENAME (Copilot left a placeholder — delete manually if desired)"
        fi
      fi
    done < <(find "$LIGHTHOUSE_SRC" -maxdepth 1 -name "*.json")
  fi

  # Remove the now-empty src folder (only if empty)
  REMAINING=$(find "$LIGHTHOUSE_SRC" -mindepth 1 | wc -l | tr -d ' ')
  if [[ "$REMAINING" -eq 0 ]]; then
    rmdir "$LIGHTHOUSE_SRC"
    done_ "Removed empty folder: $LIGHTHOUSE_SRC"

    # Clean up docs/perf/ if also now empty
    if [[ -d "docs/perf" ]]; then
      PERF_REMAINING=$(find "docs/perf" -mindepth 1 | wc -l | tr -d ' ')
      if [[ "$PERF_REMAINING" -eq 0 ]]; then
        rmdir "docs/perf"
        done_ "Removed empty folder: docs/perf"
      else
        skip "docs/perf still has files — leaving it in place"
      fi
    fi
  else
    warn "$LIGHTHOUSE_SRC still has $REMAINING item(s) — review manually before deleting"
  fi
fi

# Append to WORK_LOG.md
TODAY=$(date +%Y-%m-%d)
WORKLOG="docs/WORK_LOG.md"

if [[ ! -f "$WORKLOG" ]]; then
  info "Creating $WORKLOG"
  echo "# WORK_LOG" > "$WORKLOG"
  echo "" >> "$WORKLOG"
fi

# Only append if today's Step 2 entry is not already there
if ! grep -q "$TODAY.*Lighthouse folder standardized" "$WORKLOG" 2>/dev/null; then
  echo "[$TODAY] — Step 2: Lighthouse folder standardized — moved JSON reports from docs/perf/lighthouse/ to docs/lighthouse/" >> "$WORKLOG"
  done_ "Appended Step 2 entry to $WORKLOG"
else
  skip "Step 2 entry already in $WORKLOG for $TODAY"
fi

# =============================================================================
# STEP 6 — Move hero images to public/images/
# Fonts stay in public/fonts/ — already correct location per audit.
# =============================================================================
section "STEP 6 — Move hero images to public/images/"

IMG_SRC="src/assets/imgs"
IMG_DEST="public/images"

if [[ ! -d "$IMG_SRC" ]]; then
  skip "Source folder $IMG_SRC does not exist — already migrated or never present."
else
  mkdir -p "$IMG_DEST"
  info "Created $IMG_DEST (or already existed)"

  FILE_COUNT=$(find "$IMG_SRC" -maxdepth 1 -type f | wc -l | tr -d ' ')
  info "Found $FILE_COUNT files in $IMG_SRC"

  if [[ "$FILE_COUNT" -eq 0 ]]; then
    skip "No files to move in $IMG_SRC"
  else
    while IFS= read -r FILE; do
      BASENAME=$(basename "$FILE")
      DEST_FILE="$IMG_DEST/$BASENAME"

      if [[ -f "$DEST_FILE" ]]; then
        skip "Already exists at destination: $DEST_FILE"
      else
        mv "$FILE" "$DEST_FILE"
        done_ "Moved: $BASENAME"
      fi
    done < <(find "$IMG_SRC" -maxdepth 1 -type f)
  fi

  # Remove now-empty source folder
  REMAINING=$(find "$IMG_SRC" -mindepth 1 | wc -l | tr -d ' ')
  if [[ "$REMAINING" -eq 0 ]]; then
    rmdir "$IMG_SRC"
    done_ "Removed empty folder: $IMG_SRC"
  else
    warn "$IMG_SRC still has $REMAINING item(s) — review manually"
  fi
fi

# Confirm fonts are already in the right place
if [[ -d "public/fonts" ]]; then
  FONT_COUNT=$(find "public/fonts" -name "*.woff2" | wc -l | tr -d ' ')
  done_ "Fonts confirmed in public/fonts/ ($FONT_COUNT woff2 files) — no move needed"
else
  warn "public/fonts/ not found — check font location manually"
fi

if ! grep -q "$TODAY.*Images moved to public/images" "$WORKLOG" 2>/dev/null; then
  echo "[$TODAY] — Step 6: Images moved to public/images/ — src/assets/imgs/ removed" >> "$WORKLOG"
  done_ "Appended Step 6 entry to $WORKLOG"
else
  skip "Step 6 entry already in $WORKLOG for $TODAY"
fi

# =============================================================================
# STEP 7 — Rename VITE_ env vars to NUXT_PUBLIC_ in .env example files
# Updates .env.example, .env.production.example, .env.staging.example
# Does NOT touch actual .env files (those are gitignored and live on the server)
# =============================================================================
section "STEP 7 — Rename VITE_ to NUXT_PUBLIC_ in .env example files"

ENV_FILES=(".env.example" ".env.production.example" ".env.staging.example")

for ENV_FILE in "${ENV_FILES[@]}"; do
  if [[ ! -f "$ENV_FILE" ]]; then
    skip "$ENV_FILE not found — skipping"
    continue
  fi

  if grep -q "VITE_" "$ENV_FILE"; then
    # Show what will change before changing it
    info "In $ENV_FILE, renaming:"
    grep "VITE_" "$ENV_FILE" | while read -r LINE; do
      NEW_LINE=$(echo "$LINE" | sed 's/VITE_/NUXT_PUBLIC_/g')
      info "  $LINE  ->  $NEW_LINE"
    done

    # Perform the rename in-place
    sed -i 's/VITE_/NUXT_PUBLIC_/g' "$ENV_FILE"
    done_ "Updated $ENV_FILE"
  else
    skip "$ENV_FILE has no VITE_ vars (already updated or none present)"
  fi
done

if ! grep -q "$TODAY.*VITE_ renamed to NUXT_PUBLIC_" "$WORKLOG" 2>/dev/null; then
  echo "[$TODAY] — Step 7: VITE_ renamed to NUXT_PUBLIC_ in .env example files" >> "$WORKLOG"
  done_ "Appended Step 7 entry to $WORKLOG"
else
  skip "Step 7 entry already in $WORKLOG for $TODAY"
fi

# =============================================================================
# STEP 11 — Update deploy scripts from dist/ to .output/public/
# Updates scripts/prod-deploy.sh and scripts/staging-deploy.sh
# =============================================================================
section "STEP 11 — Update deploy scripts: dist/ -> .output/public/"

DEPLOY_SCRIPTS=("scripts/prod-deploy.sh" "scripts/staging-deploy.sh")

for SCRIPT in "${DEPLOY_SCRIPTS[@]}"; do
  if [[ ! -f "$SCRIPT" ]]; then
    skip "$SCRIPT not found — skipping"
    continue
  fi

  if grep -q "dist/" "$SCRIPT"; then
    info "In $SCRIPT, replacing dist/ with .output/public/:"
    grep "dist/" "$SCRIPT" | while read -r LINE; do
      NEW_LINE=$(echo "$LINE" | sed 's|dist/|.output/public/|g')
      info "  $LINE"
      info "  -> $NEW_LINE"
    done

    sed -i 's|dist/|.output/public/|g' "$SCRIPT"
    done_ "Updated $SCRIPT"
  else
    skip "$SCRIPT has no dist/ references (already updated or none present)"
  fi
done

if ! grep -q "$TODAY.*Deploy scripts updated.*output/public" "$WORKLOG" 2>/dev/null; then
  echo "[$TODAY] — Step 11: Deploy scripts updated — dist/ replaced with .output/public/" >> "$WORKLOG"
  done_ "Appended Step 11 entry to $WORKLOG"
else
  skip "Step 11 entry already in $WORKLOG for $TODAY"
fi

# =============================================================================
# SUMMARY
# =============================================================================
section "Migration script complete"

echo ""
echo "Steps handled by this script:"
echo "  Step 2  — Lighthouse JSON files moved to docs/lighthouse/"
echo "  Step 6  — Hero images moved to public/images/"
echo "  Step 7  — VITE_ vars renamed to NUXT_PUBLIC_ in .env example files"
echo "  Step 11 — Deploy scripts updated from dist/ to .output/public/"
echo ""
echo "Steps NOT handled here (require Copilot or manual work):"
echo "  Step 1  — Audit (already complete)"
echo "  Step 3  — Nuxt 3 init (nuxi init — run manually or via Copilot)"
echo "  Step 4  — Component migration (Copilot task prompt)"
echo "  Step 5  — pages/index.vue creation (Copilot task prompt)"
echo "  Step 8  — nginx config updates (Copilot task prompt)"
echo "  Step 9  — Build verification + headless Lighthouse baseline"
echo "  Step 10 — Cleanup: remove src/, vite.config.js, index.html"
echo "  Step 12 — Deploy to production"
echo "  Step 13 — Regenerate APP_FLOW.md and SESSION_HANDOFF.md"
echo ""
echo "Review the output above for any [WARN] lines before continuing."
echo "Check $WORKLOG to confirm entries were appended correctly."