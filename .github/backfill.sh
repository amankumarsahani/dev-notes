#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

MONTHS_BACK=${1:-3}
echo "Backfilling ${MONTHS_BACK} months of commit history..."

START_DATE=$(date -v-${MONTHS_BACK}m +%Y-%m-%d 2>/dev/null || date -d "${MONTHS_BACK} months ago" +%Y-%m-%d)
END_DATE=$(date -v-1d +%Y-%m-%d 2>/dev/null || date -d "yesterday" +%Y-%m-%d)

echo "Date range: ${START_DATE} to ${END_DATE}"

TOPICS_GENERAL=(
    "git" "docker" "linux" "bash" "vim" "ssh" "nginx" "postgres"
    "redis" "tmux" "curl" "make" "systemd" "awk" "sed" "jq"
    "grep" "tar" "cron" "dns" "ssl" "http" "tcp" "regex"
)

TOPICS_DEV=(
    "typescript" "react" "node" "python" "go" "rust" "graphql"
    "rest-api" "websockets" "oauth" "jwt" "testing" "ci-cd"
    "kubernetes" "terraform" "aws" "gcp" "monitoring" "logging"
    "caching" "queues" "microservices" "databases" "security"
    "nextjs" "tailwind" "prisma" "drizzle" "trpc" "zod"
    "sqlite" "deno" "bun" "htmx" "astro" "svelte" "vue"
)

TOPICS_CONCEPTS=(
    "design-patterns" "solid-principles" "clean-code" "refactoring"
    "data-structures" "algorithms" "system-design" "networking"
    "concurrency" "performance" "debugging" "architecture"
    "event-driven" "cqrs" "ddd" "hexagonal" "twelve-factor"
    "cap-theorem" "consistency" "distributed-systems"
)

ALL_TOPICS=("${TOPICS_GENERAL[@]}" "${TOPICS_DEV[@]}" "${TOPICS_CONCEPTS[@]}")

pick_topic() {
    echo "${ALL_TOPICS[$((RANDOM % ${#ALL_TOPICS[@]}))]}"
}

LINK_DOMAINS=("github.com" "dev.to" "blog.pragmaticengineer.com" "martinfowler.com"
              "stackoverflow.com" "medium.com" "jvns.ca" "danluu.com"
              "overreacted.io" "kentcdodds.com" "brandur.org"
              "blog.cloudflare.com" "netflixtechblog.com")

rand_between() {
    local min=$1 max=$2
    echo $(( RANDOM % (max - min + 1) + min ))
}

generate_time() {
    local weight
    weight=$(rand_between 1 100)
    local hour

    if [ "$weight" -le 10 ]; then
        hour=$(rand_between 6 8)
    elif [ "$weight" -le 75 ]; then
        hour=$(rand_between 9 17)
    elif [ "$weight" -le 95 ]; then
        hour=$(rand_between 18 22)
    else
        hour=$(rand_between 23 24)
        [ "$hour" -eq 24 ] && hour=0
    fi

    printf "%02d:%02d:%02d" "$hour" "$(rand_between 0 59)" "$(rand_between 0 59)"
}

generate_content() {
    local topic="$1"
    local date_str="$2"
    local variant=$(( RANDOM % 12 ))
    local related=$(pick_topic)

    case $variant in
        0)
cat <<EOF
# ${topic}

Learned about ${topic} today.

## Key takeaway

$(shuf -e \
    "The default behavior is not what I expected - need to be explicit." \
    "Performance improves when you batch operations." \
    "Error handling is subtle - silent failures cause issues downstream." \
    "Documentation is misleading. Source code tells the real story." \
    "This interacts with ${related} in a non-obvious way." \
    -n 1)

_${date_str}_
EOF
        ;;
        1)
cat <<EOF
# ${topic} notes

Quick reference.

\`\`\`
# TODO: add code example
\`\`\`

See also: ${related}

_${date_str}_
EOF
        ;;
        2)
cat <<EOF
# ${topic}

## Problem

Ran into an issue with ${topic} where $(shuf -e \
    "the config wasn't being picked up correctly." \
    "connections were timing out under load." \
    "the order of operations mattered more than expected." \
    "defaults changed between versions." \
    -n 1)

## Solution

$(shuf -e \
    "Use absolute paths." \
    "Added retry logic with exponential backoff." \
    "Had to explicitly set the option." \
    "Pinned the version." \
    "Added validation at startup." \
    -n 1)

_${date_str}_
EOF
        ;;
        3)
cat <<EOF
# ${topic}

Useful patterns:

- $(shuf -e \
    "Always validate inputs at the boundary." \
    "Prefer composition over inheritance." \
    "Keep the hot path simple." \
    "Use feature flags instead of long-lived branches." \
    "Write the test first when fixing a bug." \
    -n 1)
- $(shuf -e \
    "Don't optimize until you've measured." \
    "Idempotency saves you when retries happen." \
    "Timeouts should always be explicit." \
    "Make illegal states unrepresentable." \
    -n 1)

_${date_str}_
EOF
        ;;
        4)
cat <<EOF
# ${topic} - bookmark

$(shuf -e \
    "Found a good explanation." \
    "This article made it click." \
    "Reference for future use." \
    -n 1)

**TL;DR**: $(shuf -e \
    "Mental model > API memorization." \
    "Start simple, add complexity when needed." \
    "Focus on the common case first." \
    -n 1)

Related: ${related}

_${date_str}_
EOF
        ;;
        5)
cat <<EOF
# ${topic}

## What I got wrong

$(shuf -e \
    "Assumed it worked like the previous version." \
    "Was overcomplicating it." \
    "Didn't account for edge cases." \
    "Forgot it runs differently in CI." \
    -n 1)

## What works

$(shuf -e \
    "Read the source." \
    "Start with minimal config." \
    "Test with real data." \
    "Check the changelog when upgrading." \
    -n 1)

_${date_str}_
EOF
        ;;
        6)
cat <<EOF
# ${topic} snippet

\`\`\`bash
# useful one-liner
echo "placeholder for ${topic} example"
\`\`\`

_${date_str}_
EOF
        ;;
        7)
cat <<EOF
# ${topic}

Quick ${topic} reference:

| Command | Description |
|---------|-------------|
| \`init\` | Setup |
| \`status\` | Check state |
| \`apply\` | Make changes |

_${date_str}_
EOF
        ;;
        8)
cat <<EOF
# ${topic} - links

## Resources

- [${topic} reference](https://${LINK_DOMAINS[$((RANDOM % ${#LINK_DOMAINS[@]}))]}/${topic// /-}) - $(shuf -e \
    "Good overview" "Practical guide" "Deep dive" "Worth reading" -n 1)

## Notes

$(shuf -e \
    "Come back to this for the ${related} integration." \
    "Useful context for the current project." \
    "Covers edge cases I hadn't considered." \
    -n 1)

_${date_str}_
EOF
        ;;
        9)
cat <<EOF
# ${topic}

## Details

$(shuf -e \
    "The issue shows up when you combine ${topic} with ${related}. Need to initialize ${topic} first." \
    "Spent a while debugging this. Root cause: ${topic} caches aggressively by default." \
    "The trick is to separate the read and write paths. Streaming is more resilient to timeouts." \
    -n 1)

## See also

- ${related}
- $(pick_topic)

_${date_str}_
EOF
        ;;
        10)
cat <<EOF
# ${topic} cheatsheet

Common operations:

1. Setup / init
2. Basic usage
3. Advanced patterns

> Filling in details as I go.

_${date_str}_
EOF
        ;;
        11)
cat <<EOF
# ${topic} - TIL

Today I learned that ${topic} $(shuf -e \
    "supports streaming out of the box." \
    "has a built-in profiler." \
    "handles back-pressure automatically." \
    "can be configured per-request, not just globally." \
    -n 1)

## Impact

$(shuf -e \
    "Reduces boilerplate by ~40%." \
    "Good to know for the next project." \
    "Fixes a subtle bug we had." \
    -n 1)

_${date_str}_
EOF
        ;;
    esac
}

update_random_file() {
    local date_str="$1"
    local existing
    existing=$(find notes snippets bookmarks -name "*.md" -type f 2>/dev/null | shuf -n 1)

    if [ -z "$existing" ] || [ ! -f "$existing" ]; then
        return 1
    fi

    local strategy=$(( RANDOM % 5 ))
    case $strategy in
        0)
            echo "" >> "$existing"
            echo "## Update (${date_str})" >> "$existing"
            echo "" >> "$existing"
            shuf -e \
                "Revisited this - approach still holds." \
                "Added context from recent project." \
                "Clarified some vague points." \
                "Found a better way to think about this." \
                -n 1 >> "$existing"
            echo "" >> "$existing"
            echo "_${date_str}_" >> "$existing"
            ;;
        1)
            if grep -q "^_[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_$" "$existing" 2>/dev/null; then
                sed -i '' "s/^_[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_$/_${date_str}_/" "$existing" 2>/dev/null || \
                sed -i "s/^_[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_$/_${date_str}_/" "$existing"
            fi
            ;;
        2)
            echo "" >> "$existing"
            echo "See also: $(pick_topic)" >> "$existing"
            ;;
        3)
            echo "" >> "$existing"
            shuf -e \
                "- TODO: add example" \
                "- Relevant to current work" \
                "- Worth revisiting" \
                "- Need to benchmark this" \
                -n 1 >> "$existing"
            ;;
        4)
            echo "" >> "$existing"
            ;;
    esac

    local topic
    topic=$(basename "$existing" .md | tr '-' ' ')
    echo "$topic"
}

generate_add_message() {
    local topic="$1"
    shuf -e \
        "add ${topic} notes" \
        "new: ${topic}" \
        "add notes on ${topic}" \
        "${topic}: initial notes" \
        "start ${topic} notes" \
        "add ${topic} reference" \
        -n 1
}

generate_update_message() {
    local topic="$1"
    shuf -e \
        "update ${topic} notes" \
        "${topic}: expand notes" \
        "revise ${topic}" \
        "add to ${topic} notes" \
        "${topic}: more details" \
        "update ${topic}" \
        -n 1
}

generate_misc_message() {
    shuf -e \
        "clean up formatting" \
        "fix typos" \
        "reorganize notes" \
        "minor edits" \
        "formatting pass" \
        "tidy up" \
        "small fixes" \
        "housekeeping" \
        -n 1
}

next_date() {
    local current="$1"
    date -j -f "%Y-%m-%d" -v+1d "$current" +%Y-%m-%d 2>/dev/null || \
    date -d "$current + 1 day" +%Y-%m-%d
}

day_of_week() {
    local d="$1"
    date -j -f "%Y-%m-%d" "$d" +%u 2>/dev/null || \
    date -d "$d" +%u
}

mkdir -p notes snippets bookmarks

CURRENT_DATE="$START_DATE"
TOTAL_COMMITS=0
VACATION_REMAINING=0
BURST_REMAINING=0

while [[ "$CURRENT_DATE" < "$END_DATE" ]] || [[ "$CURRENT_DATE" == "$END_DATE" ]]; do
    DOW=$(day_of_week "$CURRENT_DATE")

    if [ "$VACATION_REMAINING" -gt 0 ]; then
        VACATION_REMAINING=$((VACATION_REMAINING - 1))
        CURRENT_DATE=$(next_date "$CURRENT_DATE")
        continue
    fi

    if [ $(( RANDOM % 1000 )) -lt 25 ]; then
        VACATION_REMAINING=$(( RANDOM % 3 + 2 ))
        CURRENT_DATE=$(next_date "$CURRENT_DATE")
        continue
    fi

    SKIP_ROLL=$(( RANDOM % 100 + 1 ))
    if [ "$DOW" -ge 6 ]; then
        if [ "$SKIP_ROLL" -le 40 ]; then
            CURRENT_DATE=$(next_date "$CURRENT_DATE")
            continue
        fi
    else
        if [ "$SKIP_ROLL" -le 8 ]; then
            CURRENT_DATE=$(next_date "$CURRENT_DATE")
            continue
        fi
    fi

    IS_BURST=0
    if [ "$BURST_REMAINING" -gt 0 ]; then
        BURST_REMAINING=$((BURST_REMAINING - 1))
        IS_BURST=1
    elif [ $(( RANDOM % 100 )) -lt 8 ]; then
        BURST_REMAINING=$(( RANDOM % 3 + 2 ))
        IS_BURST=1
    fi

    if [ "$IS_BURST" -eq 1 ]; then
        NUM_COMMITS=$(rand_between 5 8)
    elif [ "$DOW" -ge 6 ]; then
        NUM_COMMITS=$(rand_between 1 3)
    else
        NUM_COMMITS=$(rand_between 2 6)
    fi

    declare -a DAY_TIMES=()
    for ((i = 0; i < NUM_COMMITS; i++)); do
        DAY_TIMES+=("$(generate_time)")
    done
    IFS=$'\n' SORTED_TIMES=($(sort <<<"${DAY_TIMES[*]}")); unset IFS

    for ((i = 0; i < NUM_COMMITS; i++)); do
        COMMIT_DATETIME="${CURRENT_DATE} ${SORTED_TIMES[$i]}"

        TYPE_ROLL=$(( RANDOM % 100 ))
        FILE_COUNT=$(find notes snippets bookmarks -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

        if [ "$TYPE_ROLL" -lt 40 ] || [ "$FILE_COUNT" -lt 3 ]; then
            TOPIC=$(pick_topic)
            SLUG=$(echo "$TOPIC" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

            FOLDER_ROLL=$(( RANDOM % 100 ))
            if [ "$FOLDER_ROLL" -lt 50 ]; then
                FOLDER="notes"
            elif [ "$FOLDER_ROLL" -lt 80 ]; then
                FOLDER="snippets"
            else
                FOLDER="bookmarks"
            fi

            FILEPATH="${FOLDER}/${SLUG}.md"
            [ -f "$FILEPATH" ] && FILEPATH="${FOLDER}/${SLUG}-$(( RANDOM % 100 )).md"

            generate_content "$TOPIC" "$CURRENT_DATE" > "$FILEPATH"
            MSG=$(generate_add_message "$TOPIC")

        elif [ "$TYPE_ROLL" -lt 75 ] && [ "$FILE_COUNT" -ge 3 ]; then
            UPDATED_TOPIC=$(update_random_file "$CURRENT_DATE")
            if [ -n "$UPDATED_TOPIC" ]; then
                MSG=$(generate_update_message "$UPDATED_TOPIC")
            else
                TOPIC=$(pick_topic)
                SLUG=$(echo "$TOPIC" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
                generate_content "$TOPIC" "$CURRENT_DATE" > "notes/${SLUG}.md"
                MSG=$(generate_add_message "$TOPIC")
            fi

        elif [ "$TYPE_ROLL" -lt 93 ]; then
            MSG=$(generate_misc_message)
            if [ -f "README.md" ]; then
                DATE_LINE="_Last updated: ${CURRENT_DATE}_"
                if grep -q "^_Last updated:" README.md 2>/dev/null; then
                    sed -i '' "s/^_Last updated:.*$/${DATE_LINE}/" README.md 2>/dev/null || \
                    sed -i "s/^_Last updated:.*$/${DATE_LINE}/" README.md
                else
                    echo "" >> README.md
                    echo "${DATE_LINE}" >> README.md
                fi
            fi

        elif [ "$TYPE_ROLL" -lt 97 ] && [ "$FILE_COUNT" -ge 10 ]; then
            VICTIM=$(find notes snippets bookmarks -name "*.md" -type f 2>/dev/null | shuf -n 1)
            if [ -n "$VICTIM" ] && [ -f "$VICTIM" ]; then
                VTOPIC=$(basename "$VICTIM" .md | tr '-' ' ')
                rm -f "$VICTIM"
                MSG=$(shuf -e \
                    "remove outdated ${VTOPIC} notes" \
                    "clean up: drop ${VTOPIC}" \
                    "remove stale ${VTOPIC}" \
                    -n 1)
            else
                MSG=$(generate_misc_message)
            fi

        else
            SOURCE=$(find notes snippets bookmarks -name "*.md" -type f 2>/dev/null | shuf -n 1)
            if [ -n "$SOURCE" ] && [ -f "$SOURCE" ]; then
                SDIR=$(dirname "$SOURCE")
                SNAME=$(basename "$SOURCE")
                for d in notes snippets bookmarks; do
                    if [ "$d" != "$SDIR" ]; then
                        mkdir -p "$d"
                        mv "$SOURCE" "${d}/${SNAME}"
                        MSG="move $(basename "$SNAME" .md | tr '-' ' ') to ${d}"
                        break
                    fi
                done
            else
                MSG=$(generate_misc_message)
            fi
        fi

        git add -A

        export GIT_AUTHOR_DATE="$COMMIT_DATETIME"
        export GIT_COMMITTER_DATE="$COMMIT_DATETIME"
        git commit -m "$MSG" --allow-empty 2>/dev/null || git commit -m "$MSG" 2>/dev/null || true
        unset GIT_AUTHOR_DATE GIT_COMMITTER_DATE

        TOTAL_COMMITS=$((TOTAL_COMMITS + 1))
    done

    CURRENT_DATE=$(next_date "$CURRENT_DATE")
done

echo ""
echo "Backfill complete: ${TOTAL_COMMITS} commits generated."
echo "Date range: ${START_DATE} to ${END_DATE}"
echo ""
echo "Review with: git log --oneline --since='${START_DATE}' | head -20"
echo ""
echo "If satisfied, push with: git push origin main"
