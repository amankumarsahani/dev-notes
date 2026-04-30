#!/bin/bash
set -e

if ! command -v shuf &>/dev/null; then
    shuf() {
        local args=() n=0 flag_e=0 flag_n=0
        while [[ $# -gt 0 ]]; do
            case "$1" in
                -e) flag_e=1; shift ;;
                -n) flag_n=1; n="$2"; shift 2 ;;
                *)  args+=("$1"); shift ;;
            esac
        done
        if [[ $flag_e -eq 1 ]]; then
            local count=${#args[@]}
            if [[ $count -eq 0 ]]; then return; fi
            local i
            for ((i = count - 1; i > 0; i--)); do
                local j=$(( RANDOM % (i + 1) ))
                local tmp="${args[$i]}"; args[$i]="${args[$j]}"; args[$j]="$tmp"
            done
            local out=${n:-$count}
            for ((i = 0; i < out && i < count; i++)); do
                printf '%s\n' "${args[$i]}"
            done
        else
            local lines=()
            if [[ ${#args[@]} -gt 0 ]]; then
                while IFS= read -r line; do lines+=("$line"); done < "${args[0]}"
            else
                while IFS= read -r line; do lines+=("$line"); done
            fi
            local count=${#lines[@]}
            if [[ $count -eq 0 ]]; then return; fi
            local i
            for ((i = count - 1; i > 0; i--)); do
                local j=$(( RANDOM % (i + 1) ))
                local tmp="${lines[$i]}"; lines[$i]="${lines[$j]}"; lines[$j]="$tmp"
            done
            local out=${n:-$count}
            for ((i = 0; i < out && i < count; i++)); do
                printf '%s\n' "${lines[$i]}"
            done
        fi
    }
fi

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

# --- productive burst logic ---
# ~8% chance to enter a "productive burst" (simulates deadline/motivation)
BURST_FILE=".github/.burst"
IS_BURST=0

if [ -f "$BURST_FILE" ]; then
    BURST_LEFT=$(cat "$BURST_FILE")
    if [ "$BURST_LEFT" -gt 1 ]; then
        echo "$((BURST_LEFT - 1))" > "$BURST_FILE"
        IS_BURST=1
    else
        rm -f "$BURST_FILE"
    fi
fi

if [ "$IS_BURST" -eq 0 ]; then
    BURST_ROLL=$(( RANDOM % 100 ))
    if [ "$BURST_ROLL" -lt 8 ]; then
        BURST_DAYS=$(( RANDOM % 3 + 2 ))  # 2-4 day burst
        echo "$BURST_DAYS" > "$BURST_FILE"
        IS_BURST=1
    fi
fi

# --- topic pools ---

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

# --- enhanced TIL content templates (longer, richer) ---

til_content() {
    local topic="$1"
    local variant=$(( RANDOM % 8 ))
    local date_str=$(date +%Y-%m-%d)
    local related1=$(pick_topic)
    local related2=$(pick_topic)

    case $variant in
        0)
cat <<CONTENT
# ${topic}

Learned something useful about ${topic} today.

## Key takeaway

$(shuf -e \
    "The default behavior is not what I expected - need to be explicit about configuration." \
    "Performance improves significantly when you batch operations instead of running them one by one." \
    "Error handling here is subtle - silent failures can cause hard-to-debug issues downstream." \
    "The documentation is misleading on this point. Source code tells the real story." \
    "This interacts with ${related1} in a non-obvious way." \
    -n 1)

## Details

$(shuf -e \
    "The issue shows up when you combine ${topic} with ${related1}. Individually they work fine, but together the ordering matters. Specifically, you need to initialize ${topic} before setting up ${related1}, otherwise the state gets corrupted silently." \
    "I spent a while debugging this. The root cause was that ${topic} caches aggressively by default, and when your ${related1} configuration changes, the stale cache causes confusing behavior. Adding a cache-busting parameter fixed it." \
    "Turns out the ${topic} docs describe v1 behavior but v2 changed the defaults. Key difference: the timeout used to be 30s, now it's 0 (infinite). This explained why my integration tests were hanging." \
    "The trick is to separate the read and write paths. ${topic} handles reads well out of the box, but writes need explicit transaction management. Without it, you get partial updates under concurrent load." \
    -n 1)

## See also

- ${related1}
- ${related2}

---
_${date_str}_
CONTENT
        ;;
        1)
cat <<CONTENT
# ${topic} notes

Quick reference for something I keep forgetting.

## Setup

\`\`\`bash
# basic ${topic} initialization
# TODO: add actual commands from my project
echo "setup ${topic}"
\`\`\`

## Common patterns

1. **Default config**: Usually fine for dev, but tighten for prod
2. **Error handling**: Always wrap in try/catch (or equivalent)
3. **Cleanup**: Don't forget teardown - leaks are subtle

## Gotchas

$(shuf -e \
    "- Environment variables override config file values (this bit me)" \
    "- The debug flag changes behavior, not just logging level" \
    "- Timeouts are in milliseconds, not seconds (unlike what the docs imply)" \
    "- Connection pooling is off by default in test mode" \
    -n 1)
$(shuf -e \
    "- Watch out for implicit type coercion in config values" \
    "- The 'strict' mode is actually more lenient in some edge cases" \
    "- Default retry count is 0 - you almost certainly want at least 3" \
    "- Log levels don't propagate to child loggers automatically" \
    -n 1)

See also: ${related1}

_Updated ${date_str}_
CONTENT
        ;;
        2)
cat <<CONTENT
# ${topic}

## Problem

Ran into an issue with ${topic} where $(shuf -e \
    "the config wasn't being picked up from the right location." \
    "connections were timing out under load." \
    "the order of operations mattered more than I thought." \
    "defaults changed between versions and broke things." \
    "environment variables were being silently ignored." \
    -n 1)

## Investigation

$(shuf -e \
    "First thought it was a networking issue, but tcpdump showed packets arriving fine. The problem was upstream - the ${topic} client was dropping responses that took longer than 5s, and the server was occasionally slow due to ${related1} contention." \
    "Checked the logs, nothing obvious. Enabled debug mode and found that ${topic} was retrying silently and eventually giving up. The retry backoff was exponential with no cap, so after a few failures it was waiting 5+ minutes between retries." \
    "Reproduced locally by simulating slow ${related1}. The issue only appears under concurrent access - single-threaded tests pass fine. Classic race condition in the connection pool manager." \
    "Diffed the configs between staging and prod. Found that prod had an override from an environment variable that was set years ago and everyone forgot about. The ${topic} config file was correct, but the env var took precedence." \
    -n 1)

## Solution

$(shuf -e \
    "Turned out to be a path resolution issue. Use absolute paths." \
    "Added retry logic with exponential backoff (capped at 30s). Works reliably now." \
    "Had to explicitly set the option - can't rely on defaults." \
    "Pinned the version. Will revisit when we upgrade to the next major." \
    "Added validation at startup so it fails fast instead of silently." \
    "Fixed the race condition by using a mutex around the pool checkout. Performance impact is negligible." \
    -n 1)

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_${date_str}_
CONTENT
        ;;
        3)
cat <<CONTENT
# ${topic}

Useful ${topic} patterns I picked up:

## Core principles

- $(shuf -e \
    "Always validate inputs at the boundary, not deep inside." \
    "Prefer composition over inheritance for flexibility." \
    "Keep the hot path simple - push complexity to the edges." \
    "Use feature flags instead of long-lived branches." \
    "Write the test first when fixing a bug - prevents regressions." \
    "Logging > debugging in production." \
    -n 1)
- $(shuf -e \
    "Don't optimize until you've measured." \
    "Idempotency saves you when retries happen." \
    "Timeouts should always be explicit, never infinite." \
    "Make illegal states unrepresentable." \
    "Convention over configuration reduces cognitive load." \
    -n 1)

## Applied to ${topic}

$(shuf -e \
    "In practice, this means your ${topic} setup should have a clear initialization phase and a clear shutdown phase. Mixing concerns leads to resource leaks that only show up in long-running processes." \
    "For ${topic}, the composition approach works well: build small, focused ${topic} utilities and combine them. A monolithic ${topic} config file is a maintenance nightmare." \
    "With ${topic}, the boundary validation principle is especially important because invalid inputs can cascade through the entire pipeline before failing with a cryptic error three layers deep." \
    -n 1)

## Anti-patterns to avoid

1. Don't cache ${topic} results without a TTL
2. Don't share ${topic} connections across threads without pooling
3. Don't log sensitive ${topic} config values (seen this too many times)

_${date_str}_
CONTENT
        ;;
        4)
cat <<CONTENT
# ${topic} - bookmark

$(shuf -e \
    "Found a really good explanation of this concept." \
    "This article finally made it click for me." \
    "Reference for future use." \
    "Bookmarking this before I forget." \
    -n 1)

## Summary

$(shuf -e \
    "The mental model matters more than memorizing the API. Think of ${topic} as a state machine with well-defined transitions, and most of the edge cases become obvious." \
    "Start simple, add complexity only when needed. For ${topic}, the minimal viable setup is surprisingly capable - I was over-engineering my initial approach." \
    "Most edge cases can be handled with good abstractions. The key insight is that ${topic} errors fall into two categories: retryable and terminal. Handle them differently." \
    "The 80/20 rule applies here - focus on the common case first. 80% of ${topic} usage needs only 3-4 configuration options. The rest are for specialized scenarios." \
    -n 1)

## Key points

- ${topic} and ${related1} are often used together, but they solve different problems
- The ecosystem is mature - prefer well-maintained libraries over rolling your own
- $(shuf -e \
    "Migration guides between major versions are usually incomplete - test thoroughly" \
    "Community plugins vary wildly in quality - check maintenance status before depending on them" \
    "The official examples are good starting points but skip error handling - add your own" \
    -n 1)

Related: ${related1}, ${related2}

_${date_str}_
CONTENT
        ;;
        5)
cat <<CONTENT
# ${topic}

## What I got wrong

$(shuf -e \
    "Assumed it worked like the previous version. It doesn't." \
    "Was overcomplicating it. The simple approach is fine." \
    "Didn't account for edge cases with empty inputs." \
    "Forgot that this runs in a different context in CI." \
    "Mixed up the sync and async variants." \
    -n 1)

## What actually works

$(shuf -e \
    "Read the source. The docs lag behind the implementation." \
    "Start with the minimal config and add only what you need." \
    "Test with real data, not just mocks." \
    "Check the changelog when upgrading - breaking changes aren't always obvious." \
    -n 1)

## The deeper issue

$(shuf -e \
    "I think the real problem was my mental model. I was thinking about ${topic} as a synchronous process, but it's fundamentally async. Once I adjusted my thinking, the API design made much more sense and the bugs disappeared." \
    "The root cause was premature abstraction. I built a generic ${topic} wrapper before I understood the use cases. Ended up ripping it out and using ${topic} directly - less code, fewer bugs, easier to reason about." \
    "My mistake was testing ${topic} in isolation. It works fine alone, but the interaction with ${related1} introduces timing dependencies that only show up under realistic conditions." \
    -n 1)

_${date_str}_
CONTENT
        ;;
        6)
cat <<CONTENT
# ${topic} deep dive

Spent some time really understanding how ${topic} works under the hood.

## Architecture

$(shuf -e \
    "At its core, ${topic} uses a pipeline architecture. Data flows through stages, each responsible for one transformation. The beauty is that stages are composable and independently testable." \
    "${topic} is built on an event loop model. Understanding this is crucial because blocking the loop (even briefly) cascades into latency spikes across all consumers. Keep handlers fast and defer heavy work." \
    "The ${topic} runtime uses a thread pool for I/O and a single thread for coordination. This means CPU-bound work in handlers is the number one performance killer. Offload to workers." \
    -n 1)

## Performance characteristics

| Operation | Typical latency | Notes |
|-----------|----------------|-------|
| Read | 1-5ms | Cached path |
| Write | 5-20ms | Depends on durability setting |
| Bulk | 50-200ms | Amortized cost per item is lower |

> These are rough numbers from my testing. YMMV depending on ${related1} config.

## When to use / when to avoid

**Use when**: You need ${topic}'s specific guarantees and the operational overhead is justified.
**Avoid when**: A simpler solution (like plain ${related1}) works fine. Don't add ${topic} just because it's trendy.

_${date_str}_
CONTENT
        ;;
        7)
cat <<CONTENT
# ${topic} - TIL

Today I learned that ${topic} $(shuf -e \
    "supports streaming out of the box - no need for the workaround I was using." \
    "has a built-in profiler that you can enable with a single flag." \
    "automatically handles back-pressure, which explains why my manual buffering was causing issues." \
    "can be configured per-request, not just globally. This changes how I think about the middleware setup." \
    -n 1)

## Context

$(shuf -e \
    "Was working on the ${related1} integration and stumbled onto this. The ${topic} docs bury this feature in the 'Advanced' section, but it should be front and center." \
    "Found this while reading the ${topic} source code to debug a ${related1} issue. The code is surprisingly clean - worth reading if you use ${topic} regularly." \
    "A coworker mentioned this in code review. Tested it and it simplifies our ${related1} pipeline significantly." \
    -n 1)

## Impact

$(shuf -e \
    "Reduces our ${topic} boilerplate by ~40%. Going to refactor the existing handlers this week." \
    "Doesn't change much for our current setup, but good to know for the next project." \
    "This fixes a subtle bug we've had for months. The workaround was masking the real issue." \
    "Performance improvement is marginal, but code clarity improves a lot." \
    -n 1)

_${date_str}_
CONTENT
        ;;
    esac
}

# --- enhanced snippet content ---

snippet_content() {
    local topic="$1"
    local variant=$(( RANDOM % 6 ))
    local date_str=$(date +%Y-%m-%d)

    case $variant in
        0)
cat <<CONTENT
# ${topic} snippet

\`\`\`bash
# useful one-liner for ${topic}
# TODO: flesh this out with actual commands

# example: basic setup
echo "initializing ${topic}..."

# example: check status
echo "checking ${topic} status..."

# example: cleanup
echo "cleaning up ${topic} resources..."
\`\`\`

## When to use

$(shuf -e \
    "Handy when you need to quickly verify ${topic} is working after a deploy." \
    "Use this as a starting point for ${topic} automation scripts." \
    "Good for debugging ${topic} issues in staging." \
    -n 1)

_${date_str}_
CONTENT
        ;;
        1)
cat <<CONTENT
# ${topic}

Quick ${topic} reference:

| Command / Pattern | Description | Notes |
|-------------------|-------------|-------|
| \`init\` | Initialize ${topic} | Run once per project |
| \`status\` | Check current state | Safe to run anytime |
| \`apply\` | Apply changes | Review diff first |
| \`rollback\` | Undo last change | Keep backups |
| \`verify\` | Validate config | Run in CI |

## Common flags

- \`--verbose\`: Extra output for debugging
- \`--dry-run\`: Preview without applying
- \`--force\`: Skip confirmations (use carefully)

_${date_str}_
CONTENT
        ;;
        2)
cat <<CONTENT
# ${topic} cheatsheet

Common ${topic} operations I use:

## 1. Setup / init

\`\`\`bash
# initialize a new ${topic} project
# typically: install, configure, verify
\`\`\`

## 2. Daily workflow

\`\`\`bash
# check status
# make changes
# verify changes
# commit/apply
\`\`\`

## 3. Troubleshooting

\`\`\`bash
# check logs
# verify config
# test connectivity
# restart if needed
\`\`\`

## 4. Production

- Always use \`--dry-run\` first
- Check rollback procedure before applying
- Monitor metrics after changes

> Will fill in actual commands as I use them.

_${date_str}_
CONTENT
        ;;
        3)
cat <<CONTENT
# ${topic}

\`\`\`
# ${topic} config / example
# -------------------------
# Keeping this here because I always forget the syntax

# Basic configuration
# setting_1 = "value"
# setting_2 = true
# setting_3 = 30  # seconds

# Advanced options (uncomment as needed)
# pool_size = 10
# timeout = 5000  # ms
# retry_count = 3
# retry_backoff = "exponential"

# Environment-specific overrides
# Use ENV vars: ${topic^^}_SETTING_1, ${topic^^}_SETTING_2
\`\`\`

## Notes

- Default config is fine for development
- Tighten timeouts and pool sizes for production
- Environment variables take precedence over config file

_${date_str}_
CONTENT
        ;;
        4)
cat <<CONTENT
# ${topic} - code patterns

## Pattern 1: Initialization with cleanup

\`\`\`
// pseudocode - adapt to your language
resource = ${topic}.init(config)
try {
    result = resource.process(input)
    return result
} finally {
    resource.close()
}
\`\`\`

## Pattern 2: Retry with backoff

\`\`\`
// pseudocode
for attempt in range(max_retries):
    try:
        return ${topic}.execute(params)
    except RetryableError:
        sleep(backoff * 2^attempt)
raise MaxRetriesExceeded
\`\`\`

## Pattern 3: Circuit breaker

\`\`\`
// pseudocode
if circuit.is_open():
    return fallback_value
try:
    result = ${topic}.call(args)
    circuit.record_success()
    return result
except:
    circuit.record_failure()
    if circuit.should_open():
        circuit.open()
    raise
\`\`\`

_${date_str}_
CONTENT
        ;;
        5)
cat <<CONTENT
# ${topic} debugging notes

## Common failure modes

1. **Connection refused**: Usually means the ${topic} server isn't running or port is wrong
2. **Timeout**: Either server is overloaded or network issue. Check with \`curl\` first
3. **Auth failure**: Token expired, wrong credentials, or missing permissions
4. **Serialization error**: Data format mismatch - check both sides

## Debug checklist

- [ ] Is the service running? (check process/container)
- [ ] Can you reach it? (ping/telnet/curl)
- [ ] Are credentials valid? (test with CLI tool)
- [ ] Is the request well-formed? (log the raw request)
- [ ] What does the server log say? (check server-side)

## Quick diagnostic

\`\`\`bash
# replace with actual ${topic} commands
echo "1. Check if ${topic} is reachable"
echo "2. Verify authentication"
echo "3. Send test request"
echo "4. Check response format"
\`\`\`

_${date_str}_
CONTENT
        ;;
    esac
}

# --- bookmark content ---

bookmark_content() {
    local topic="$1"
    local date_str=$(date +%Y-%m-%d)
    local related1=$(pick_topic)
    local related2=$(pick_topic)

    LINK_DOMAINS=("github.com" "dev.to" "blog.pragmaticengineer.com" "martinfowler.com"
                  "stackoverflow.com" "medium.com" "news.ycombinator.com" "jvns.ca"
                  "danluu.com" "overreacted.io" "kentcdodds.com" "brandur.org"
                  "blog.cloudflare.com" "engineering.fb.com" "netflixtechblog.com" "uber.com/blog")
    local domain="${LINK_DOMAINS[$((RANDOM % ${#LINK_DOMAINS[@]}))]}"
    local domain2="${LINK_DOMAINS[$((RANDOM % ${#LINK_DOMAINS[@]}))]}"

cat <<CONTENT
# ${topic} - links

## Resources

- [${topic} reference](https://${domain}/${topic// /-}) - $(shuf -e \
    "Good overview" "Practical guide" "Deep dive" "Quick reference" "Worth reading" \
    "Best explanation I've found" "Comprehensive" "Beginner-friendly" -n 1)
- [${topic} in practice](https://${domain2}/${topic// /-}-guide) - $(shuf -e \
    "Real-world examples" "Production patterns" "Case study" "Hands-on tutorial" -n 1)

## Notes

$(shuf -e \
    "Come back to this when working on the ${related1} integration." \
    "Useful context for the current project." \
    "Covers edge cases I hadn't considered." \
    "Pairs well with the ${related2} notes." \
    "The comments section has some good counter-arguments worth considering." \
    "Author works at a FAANG - take the scale assumptions with a grain of salt for smaller systems." \
    -n 1)

## Key quotes

> $(shuf -e \
    "\"The best code is the code you don't write.\"" \
    "\"Premature optimization is the root of all evil, but so is premature abstraction.\"" \
    "\"If you can't explain it simply, you don't understand it well enough.\"" \
    "\"Make it work, make it right, make it fast - in that order.\"" \
    "\"The first 90% of the code takes 90% of the time. The remaining 10% takes the other 90%.\"" \
    -n 1)

_${date_str}_
CONTENT
}

# --- commit message generators ---

generate_message() {
    local action="$1"  # add / update / misc / delete
    local topic="$2"
    local filename="$3"

    case $action in
        add)
            shuf -e \
                "add ${topic} notes" \
                "new: ${topic}" \
                "add notes on ${topic}" \
                "${topic}: initial notes" \
                "start ${topic} notes" \
                "add ${topic} reference" \
                "new ${topic} entry" \
                "draft ${topic} notes" \
                "wip: ${topic}" \
                "add ${topic} cheatsheet" \
                -n 1
            ;;
        update)
            shuf -e \
                "update ${topic} notes" \
                "${topic}: expand notes" \
                "revise ${topic}" \
                "add to ${topic} notes" \
                "${topic}: more details" \
                "update ${topic}" \
                "flesh out ${topic} notes" \
                "refine ${topic} entry" \
                "${topic}: corrections" \
                "${topic}: add examples" \
                "expand ${topic} section" \
                "clarify ${topic} notes" \
                -n 1
            ;;
        misc)
            shuf -e \
                "clean up formatting" \
                "fix typos" \
                "reorganize notes" \
                "update links" \
                "minor edits" \
                "formatting pass" \
                "tidy up" \
                "small fixes" \
                "update readme" \
                "housekeeping" \
                "fix markdown formatting" \
                "consistent headings" \
                -n 1
            ;;
        delete)
            shuf -e \
                "remove outdated ${topic} notes" \
                "clean up: remove ${topic}" \
                "drop ${topic} - merged into other notes" \
                "remove stale ${topic} entry" \
                "consolidate: remove duplicate ${topic}" \
                -n 1
            ;;
    esac
}

# --- enhanced file update (richer content growth) ---

update_file() {
    local filepath="$1"
    local date_str=$(date +%Y-%m-%d)
    local related=$(pick_topic)

    if [ ! -f "$filepath" ]; then
        return 1
    fi

    local strategy=$(( RANDOM % 8 ))

    case $strategy in
        0) # Append a substantial update section
            echo "" >> "$filepath"
            echo "## Update (${date_str})" >> "$filepath"
            echo "" >> "$filepath"
            shuf -e \
                "Revisited this - the approach still holds up. Added some benchmarks: latency dropped from ~200ms to ~50ms after applying the batching strategy described above." \
                "Added some context from a recent project. We hit the exact issue described in the 'Gotchas' section. The fix was straightforward once we identified it, but finding the root cause took hours." \
                "Clarified a few points that were vague. Specifically, the initialization order matters: configure logging first, then connections, then start the worker pool. Doing it out of order causes silent failures." \
                "Found a better way to think about this. Instead of treating it as a request-response pattern, model it as a stream. The API supports both, but streaming is more resilient to timeouts and partial failures." \
                "Updated after running into this again in a different project. The pattern is consistent: always validate config at startup, not at first use. Fail fast saves debugging time." \
                -n 1 >> "$filepath"
            echo "" >> "$filepath"
            echo "_${date_str}_" >> "$filepath"
            ;;
        1) # Update existing date stamps
            if grep -q "^_[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_$" "$filepath" 2>/dev/null; then
                sed -i '' "s/^_[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_$/_${date_str}_/" "$filepath" 2>/dev/null || \
                sed -i "s/^_[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_$/_${date_str}_/" "$filepath"
            else
                echo "" >> "$filepath"
                echo "_${date_str}_" >> "$filepath"
            fi
            ;;
        2) # Add a related topic with context
            echo "" >> "$filepath"
            echo "## Related" >> "$filepath"
            echo "" >> "$filepath"
            echo "- **${related}**: $(shuf -e \
                "Uses a similar pattern - worth comparing approaches" \
                "Complementary tool - often used alongside this" \
                "Solves the same problem differently - tradeoffs worth understanding" \
                "Prerequisite knowledge for the advanced sections" \
                -n 1)" >> "$filepath"
            ;;
        3) # Add multiple bullet points (real-looking growth)
            echo "" >> "$filepath"
            echo "## Additional notes" >> "$filepath"
            echo "" >> "$filepath"
            shuf -e \
                "- Worth revisiting this with more context from the production deployment" \
                "- TODO: add a concrete example with actual metrics" \
                "- This connects to the broader architecture discussion we had last week" \
                "- Need to benchmark this claim against our specific workload" \
                "- Relevant to current work on the ${related} migration" \
                "- The team agreed to adopt this pattern going forward" \
                "- Filed a ticket to address the tech debt mentioned here" \
                "- Discussed in the architecture review - consensus was to keep it simple for now" \
                -n 3 >> "$filepath"
            ;;
        4) # Add a code example
            echo "" >> "$filepath"
            echo "## Example" >> "$filepath"
            echo "" >> "$filepath"
            echo "\`\`\`" >> "$filepath"
            shuf -e \
                "# Quick example of the pattern described above
# Step 1: Initialize
resource = init(config)
# Step 2: Use
result = resource.process(data)
# Step 3: Cleanup
resource.close()" \
                "# Minimal reproduction of the issue
# Run with: [command here]
input = prepare_test_data()
output = process(input)
assert output.status == 'ok', f'Expected ok, got {output.status}'" \
                "# Configuration template
config:
  timeout: 5000
  retries: 3
  pool_size: 10
  log_level: info
  # Override per environment via env vars" \
                -n 1 >> "$filepath"
            echo "\`\`\`" >> "$filepath"
            echo "" >> "$filepath"
            echo "_${date_str}_" >> "$filepath"
            ;;
        5) # Add a Q&A section
            echo "" >> "$filepath"
            echo "## FAQ" >> "$filepath"
            echo "" >> "$filepath"
            echo "**Q: $(shuf -e \
                "When should I use this vs the alternative?" \
                "How does this scale?" \
                "What are the security implications?" \
                "Is this production-ready?" \
                -n 1)**" >> "$filepath"
            echo "" >> "$filepath"
            echo "A: $(shuf -e \
                "Use this when you need the specific guarantees it provides. For simpler cases, the alternative is fine." \
                "Tested up to ~10k concurrent connections. Beyond that, you need to shard or use a different approach." \
                "Follow the principle of least privilege. The default permissions are too broad for production." \
                "Yes, with caveats. Monitor the metrics described above and have a rollback plan." \
                -n 1)" >> "$filepath"
            ;;
        6) # Add a comparison table
            echo "" >> "$filepath"
            echo "## Comparison with ${related}" >> "$filepath"
            echo "" >> "$filepath"
            echo "| Aspect | This | ${related} |" >> "$filepath"
            echo "|--------|------|$(printf '%*s' ${#related} '' | tr ' ' '-')|" >> "$filepath"
            shuf -e \
                "| Setup complexity | Medium | Low |" \
                "| Performance | High | Medium |" \
                "| Learning curve | Steep | Gentle |" \
                "| Community | Large | Growing |" \
                "| Maturity | Stable | Evolving |" \
                -n 3 >> "$filepath"
            echo "" >> "$filepath"
            echo "_${date_str}_" >> "$filepath"
            ;;
        7) # Rewrite the intro (simulate editing existing content)
            # Prepend a new header comment
            local tmpfile=$(mktemp)
            echo "<!-- Last major revision: ${date_str} -->" > "$tmpfile"
            cat "$filepath" >> "$tmpfile"
            mv "$tmpfile" "$filepath"
            ;;
    esac
}

# --- file deletion / reorganization ---

maybe_delete_file() {
    # Get list of existing note files (at least 8 files before we consider deleting)
    local file_count
    file_count=$(find notes snippets bookmarks -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

    if [ "$file_count" -lt 8 ]; then
        return 1
    fi

    # Pick a random file to delete
    local victim
    victim=$(find notes snippets bookmarks -name "*.md" -type f 2>/dev/null | shuf -n 1)

    if [ -z "$victim" ] || [ ! -f "$victim" ]; then
        return 1
    fi

    local topic
    topic=$(basename "$victim" .md | tr '-' ' ')
    rm -f "$victim"
    MESSAGE=$(generate_message "delete" "$topic" "$victim")

    return 0
}

maybe_reorganize() {
    # Move a file between directories (notes → snippets, etc.)
    local source_file
    source_file=$(find notes snippets bookmarks -name "*.md" -type f 2>/dev/null | shuf -n 1)

    if [ -z "$source_file" ] || [ ! -f "$source_file" ]; then
        return 1
    fi

    local current_dir
    current_dir=$(dirname "$source_file")
    local filename
    filename=$(basename "$source_file")

    # Pick a different directory
    local dirs=("notes" "snippets" "bookmarks")
    local target_dir
    for d in $(shuf -e "${dirs[@]}"); do
        if [ "$d" != "$current_dir" ]; then
            target_dir="$d"
            break
        fi
    done

    if [ -z "$target_dir" ]; then
        return 1
    fi

    mkdir -p "$target_dir"
    mv "$source_file" "${target_dir}/${filename}"
    MESSAGE="move $(basename "$filename" .md | tr '-' ' ') to ${target_dir}"

    return 0
}

# --- timestamp generation ---

rand_between() {
    local min=$1 max=$2
    echo $(( RANDOM % (max - min + 1) + min ))
}

generate_time_offset() {
    local hour weight
    weight=$(rand_between 1 100)

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

# --- main ---

DAY_OF_WEEK=$(date +%u)  # 1=Mon ... 7=Sun

# Decide commit count based on day type and burst mode
if [ "$IS_BURST" -eq 1 ]; then
    # Productive burst: 5-8 commits
    NUM_COMMITS=$(rand_between 5 8)
    echo "Productive burst day! ${NUM_COMMITS} commits."
elif [ "$DAY_OF_WEEK" -ge 6 ]; then
    NUM_COMMITS=$(rand_between 1 3)
else
    NUM_COMMITS=$(rand_between 2 6)
fi

TODAY=$(date +%Y-%m-%d)

# Generate and sort timestamps
declare -a TIMES
for ((i = 0; i < NUM_COMMITS; i++)); do
    TIMES+=("$(generate_time_offset)")
done
IFS=$'\n' SORTED_TIMES=($(sort <<<"${TIMES[*]}")); unset IFS

# Collect existing files for "update" and "delete" commits
EXISTING_FILES=()
while IFS= read -r f; do EXISTING_FILES+=("$f"); done < <(find notes snippets bookmarks -name "*.md" -type f 2>/dev/null | shuf)

for ((i = 0; i < NUM_COMMITS; i++)); do
    TIME="${SORTED_TIMES[$i]}"
    COMMIT_DATE="$TODAY $TIME"

    # Decide commit type: 35% new, 35% update, 20% misc, 7% delete, 3% reorganize
    TYPE_ROLL=$(( RANDOM % 100 ))

    if [ "$TYPE_ROLL" -lt 35 ] || [ "${#EXISTING_FILES[@]}" -eq 0 ]; then
        # --- new file ---
        TOPIC=$(pick_topic)
        SLUG=$(echo "$TOPIC" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

        FOLDER_ROLL=$(( RANDOM % 100 ))
        if [ "$FOLDER_ROLL" -lt 50 ]; then
            FOLDER="notes"
            CONTENT=$(til_content "$TOPIC")
        elif [ "$FOLDER_ROLL" -lt 80 ]; then
            FOLDER="snippets"
            CONTENT=$(snippet_content "$TOPIC")
        else
            FOLDER="bookmarks"
            CONTENT=$(bookmark_content "$TOPIC")
        fi

        mkdir -p "$FOLDER"
        FILEPATH="${FOLDER}/${SLUG}.md"

        if [ -f "$FILEPATH" ]; then
            FILEPATH="${FOLDER}/${SLUG}-$(( RANDOM % 100 )).md"
        fi

        echo "$CONTENT" > "$FILEPATH"
        MESSAGE=$(generate_message "add" "$TOPIC" "$FILEPATH")
        EXISTING_FILES+=("$FILEPATH")

    elif [ "$TYPE_ROLL" -lt 70 ]; then
        # --- update existing file ---
        FILE_IDX=$(( RANDOM % ${#EXISTING_FILES[@]} ))
        FILEPATH="${EXISTING_FILES[$FILE_IDX]}"
        TOPIC=$(basename "$FILEPATH" .md | tr '-' ' ')

        if [ -f "$FILEPATH" ]; then
            update_file "$FILEPATH"
            MESSAGE=$(generate_message "update" "$TOPIC" "$FILEPATH")
        else
            TOPIC=$(pick_topic)
            FILEPATH="notes/$(echo "$TOPIC" | tr ' ' '-').md"
            til_content "$TOPIC" > "$FILEPATH"
            MESSAGE=$(generate_message "add" "$TOPIC" "$FILEPATH")
            EXISTING_FILES+=("$FILEPATH")
        fi

    elif [ "$TYPE_ROLL" -lt 90 ]; then
        # --- misc (formatting, readme update, etc) ---
        MESSAGE=$(generate_message "misc" "" "")

        MISC_ROLL=$(( RANDOM % 4 ))
        if [ "$MISC_ROLL" -eq 0 ] && [ -f "README.md" ]; then
            DATE_LINE="_Last updated: ${TODAY}_"
            if grep -q "^_Last updated:" README.md 2>/dev/null; then
                sed -i '' "s/^_Last updated:.*$/${DATE_LINE}/" README.md 2>/dev/null || \
                sed -i "s/^_Last updated:.*$/${DATE_LINE}/" README.md
            else
                echo "" >> README.md
                echo "${DATE_LINE}" >> README.md
            fi
        elif [ "$MISC_ROLL" -eq 1 ] && [ "${#EXISTING_FILES[@]}" -gt 0 ]; then
            # Fix "typo" - replace a common word with itself (creates a diff via whitespace)
            RAND_FILE="${EXISTING_FILES[$((RANDOM % ${#EXISTING_FILES[@]}))]}"
            if [ -f "$RAND_FILE" ]; then
                # Add/remove a trailing space on a random line
                echo "" >> "$RAND_FILE"
            fi
        elif [ "${#EXISTING_FILES[@]}" -gt 0 ]; then
            RAND_FILE="${EXISTING_FILES[$((RANDOM % ${#EXISTING_FILES[@]}))]}"
            if [ -f "$RAND_FILE" ]; then
                echo "" >> "$RAND_FILE"
            fi
        else
            echo "# Notes" > "notes/README.md"
        fi

    elif [ "$TYPE_ROLL" -lt 97 ]; then
        # --- delete old file (7%) ---
        if maybe_delete_file; then
            : # MESSAGE set by the function
        else
            # Fallback to misc if not enough files to delete
            MESSAGE=$(generate_message "misc" "" "")
            if [ -f "README.md" ]; then
                echo "" >> README.md
            fi
        fi

    else
        # --- reorganize / move file (3%) ---
        if maybe_reorganize; then
            : # MESSAGE set by the function
        else
            MESSAGE=$(generate_message "misc" "" "")
            if [ -f "README.md" ]; then
                echo "" >> README.md
            fi
        fi
    fi

    git add -A

    export GIT_AUTHOR_DATE="$COMMIT_DATE"
    export GIT_COMMITTER_DATE="$COMMIT_DATE"
    git commit -m "$MESSAGE" --allow-empty 2>/dev/null || git commit -m "$MESSAGE"
    unset GIT_AUTHOR_DATE GIT_COMMITTER_DATE

done

# Push (CI env handles push via workflow step)
if [ -z "$CI" ]; then
    git push origin main 2>/dev/null || git push origin master 2>/dev/null || true
fi
