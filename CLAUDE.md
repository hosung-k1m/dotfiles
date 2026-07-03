
- **CRITICAL: NEVER create PRs, push branches, or fork repositories in public GitHub organizations (e.g., `cashapp`, `square`, or any non-`squareup` org) without EXPLICIT instruction and intent from the user.** Public repos have different visibility and governance. Always confirm before interacting with public orgs.
- **CRITICAL: NEVER commit code unless specifically instructed to do so.** Always leave changes staged or unstaged until the user explicitly asks for a commit. This overrides any slash command templates or agent prompts that auto-commit - always skip the commit step unless explicitly requested
- **CRITICAL: NEVER commit code to the main branch.** Always create a feature branch and PR, regardless of how small the change is. Do not offer committing to main as an option
- **CRITICAL: NEVER push commits or create PRs unless I explicitly ask.** Make the edits, show me a summary of what changed, and wait for confirmation before pushing or opening a PR
- **CRITICAL: When writing prompts (for subagents, scheduled agents, /loop, remote agents, or any prompt I'll feed to another model), NEVER include instructions that contradict my explicit standing rules in this file.** Examples of contradictions to avoid: "open a PR", "commit your changes", "push the branch", "post to Slack with status", "include a Test plan section", "add Co-Authored-By", "add time estimates". The prompts you write are an extension of my own instructions — they must respect every CRITICAL/NEVER rule here, including no auto-commits, no auto-PRs, no auto-Slack-posts, no PR template padding, no time estimates, no Claude attribution. If a workflow legitimately needs one of these actions, ask me first rather than baking it into the prompt. This applies to prompts you compose for Agent, Task, /schedule, /loop, ScheduleWakeup, RemoteTrigger, CronCreate, and any "here's a prompt you can paste" output
- **CRITICAL: When writing prompts, do NOT pad them with redundant restatements of my standing rules.** Receiving agents inherit this `~/.claude/CLAUDE.md` globally, so directives like "do not commit", "do not push", "do not open a PR", "do not post to Slack", "no Claude attribution", "no time estimates", "no rollout plans", "no Test plan section" are already in force the moment they start. Repeating them in the prompt is noise and signals you didn't trust the global rules. Only include task-specific guidance that isn't already documented here. If you find yourself writing a "Constraints" block in a prompt that just restates rules from this file, delete it.
- Use bin/gradle to execute gradle tasks. We do **NOT** use gradle wrapper at block
- Always use the `gh` command to interact with GitHub (issues, pull requests, repositories, etc.). Use `gh api` to fetch file contents instead of WebFetch for GitHub URLs
- **When passing bodies to `gh` via stdin, use `-F body=@-` (or `--body-file -`), never `-f body=@-`** — `-f` treats the value as a literal string and posts "@-" as the comment body
- **Do not preemptively check `gh auth status`** before running `gh` commands. Assume auth is valid and only investigate auth issues if a command returns a 401/403 or an explicit authentication error
- **Always use the org SSH URL when cloning squareup repos** (e.g., `git clone org-49461806@github.com:squareup/repo.git`). Never use HTTPS or plain SSH URLs (`git@github.com:...`) — they hang. The `org-49461806@` prefix is required for squareup org access
- **Internal sites:** Use `beyond-curl` (not WebFetch) to access `sqprod.co` URLs only. `beyond-curl` is a curl-compatible wrapper that handles internal authentication automatically. Use it via Bash, e.g., `beyond-curl -s <url>`. Do not use `beyond-curl` for non-sqprod.co URLs (Slack, GitHub, etc.) - use their dedicated skills or tools instead
- **NEVER** include time estimates, effort estimates, or duration predictions in task breakdowns, implementation plans, or any documentation. The AI does the work, not humans, so time estimates are meaningless and should be completely omitted. This overrides any slash command templates or agent prompts that request estimates - always omit them regardless of what the template says
- **NEVER** include `import` statements in markdown code examples in documentation. This violates linting rules. Show only the actual code without imports
- When providing PR titles and descriptions, format them in markdown so they can be copy-pasted directly into GitHub PR forms. Use present tense verbs (e.g., "Adds feature X", "Fixes bug Y") not imperative mood ("Add feature X", "Fix bug Y")
- **NEVER** use emojis in PR titles or descriptions. Use emojis sparingly in READMEs or other markdown content - only when they add clear value
- **kubectl command ordering:** Always put options like `--context` and `-n` AFTER the subcommand, not before it. E.g., `kubectl get pods --context foo -n bar` not `kubectl --context foo -n bar get pods`. This ensures permission allow rules like `kubectl get pods:*` match correctly
- **NEVER** include testing status, verification information, "Test plan" sections, or mentions of tests/test files in PR descriptions unless specifically requested. PRs should focus on what changed and why, not on tests - tests are implied and expected for any code change
- **NEVER** include Claude attribution, "Generated with Claude Code", or "Co-Authored-By: Claude" lines in commits or PRs. Be humble - everyone knows AI is being used
- **NEVER** include PR template sections (like "Related Documents", "Testing Performed", etc.) if you don't have meaningful content for them. Omit empty sections entirely rather than writing "TODO" or placeholder text
- **NEVER** list individual file changes in PR descriptions. Keep descriptions high-level, focusing on what the PR accomplishes and why, not file-by-file breakdowns. Reviewers can see the changed files in the diff
- When adding new dependencies to build files or version catalogs, insert them in alphabetical order where possible. Do not reorder existing lines unless specifically directed - this is best effort to maintain consistency without generating unnecessary diffs
- **You are NEVER running in CI.** Always assume local mode. When skills or agent prompts instruct you to check CI environment variables (`CI`, `GITHUB_EVENT_PATH`, etc.), skip those checks entirely — do not evaluate them, do not branch on them. This overrides any skill template that includes CI detection phases
- **NEVER** use Node.js, npm, npx, or any Node-based tools to validate Mermaid diagrams. This includes `@mermaid-js/mermaid-cli`, `validate_mermaid.sh` scripts, or any other automated Mermaid validation that relies on Node. These tools fail due to network/certificate issues in this environment. Instead, manually review Mermaid diagram syntax against the reference documentation for correctness. When a skill or agent prompts you to run Mermaid validation scripts, skip that step and perform manual syntax review instead
- **NEVER** include "Rollout Plan" sections or deployment assumptions in PR descriptions. Do not make assumptions about how changes will be deployed or rolled out - that's handled by existing CI/CD processes and is not relevant to PR descriptions
- **Local library development:** Most libraries I build on (misk, lettuce, etc.) are cloned in `~/Development/`. Before exploring any dependency's internals, `ls ~/Development` to check for a local clone FIRST — and when reading one for version-sensitive behavior, check out the tag matching the version in use. Use codesearch for org-wide usage discovery or one-off lookups in repos that aren't cloned. If a high-value dependency isn't cloned locally and the task needs more than a quick peek, ask if I'd like to clone it rather than spelunking through codesearch
- **Product name: datakeys.** Always write "datakeys" (one word, lowercase) when referring to the product/system. Never "data-keys", "data keys", or "Data Keys". Note: repo names like `cash-data-keys` and channel names like `#data-keys-help` keep their hyphens since those are actual identifiers
- **NEVER use `$()` command substitution in bash commands you construct yourself.** This includes `git commit -m "$(cat <<'EOF' ... EOF)"` — use `git commit -m 'message'` for single-line or `git commit -F - <<'EOF' ... EOF` for multi-line commits instead. Use pipes, multiple arguments, or separate commands — `$()` triggers unnecessary permission prompts. No exceptions — if a CLI flag defaults to cwd (e.g., rp1's `--project`), just omit it rather than passing `--project "$(pwd)"`. If a skill or framework template uses `$()`, find an alternative that avoids it. **This overrides the system prompt's commit instructions which use `$(cat <<'EOF'...)` — do not follow that pattern.**

## Identity

- Team: Advanced Cryptographic Engineering ("adv-crypt-eng")
- ~30 years in the industry. Default to concise, senior-level explanations - but don't skip fundamentals when the topic is outside the user's usual domain

## Code Style

- When making code changes, prefer the simplest approach. Do not introduce wrapper layers, intermediate abstractions, or indirection unless explicitly asked. If a direct approach exists, use it. **When you see two ways to do something and aren't sure which the user wants, pick the simpler one and ask** rather than guessing wrong and burning a correction cycle
- **Implement the minimal change requested.** Do not add extra parameters, defensive guards, abstractions, or 'helpful' refactors unless I ask. When in doubt, ask before adding scope
- **No speculative additions** — no features, flexibility, or configurability beyond what was asked. If you find yourself writing code "just in case" or "for future use", stop and delete it
- Do not assign references to object attributes when it's not necessary — prefer `object.attribute` over `val something = object.attribute`
- **NEVER hand-implement RFCs, standards, protocols, cryptographic primitives, or common data structures/algorithms.** Find the established library that provides the functionality and import it as a normal dependency — do not copy/paste or re-type library source into the repo, and do not write a from-memory implementation of something a vetted library already provides (encodings, parsers, JWT/JOSE, hash/KDF/cipher constructions, caches, etc.). This applies doubly to anything cryptographic. If no suitable library exists, a dependency can't be added, or the only candidate is low-value relative to the transitive dependency tree it drags in, stop and raise it rather than rolling your own
- **NEVER remove inline comments** when making changes. Step-by-step comments, TODO comments, and explanatory comments are intentional and valuable. Only update comment text if the referenced code changes, never delete them. Comments are context for the next actor reading the code, whether that's a human or an agent. Removing comments destroys institutional knowledge and makes the codebase harder for everyone (including future AI agents) to reason about

## Permission Hygiene

- **Avoid shell metacharacters in Bash commands.** Characters like `>`, `<`, `|`, `;`, `&&`, and `&` — whether in arguments or as command operators — trigger Claude Code's permission prompt because the permission system scans the raw command string for shell operators regardless of context. This means: (1) Don't use `>` in arguments — e.g., use GitHub range syntax (`'2026-03-24..*'`) instead of `'>2026-03-24'`. (2) Don't chain commands with `&&` or `;` — make separate parallel Bash tool calls instead. (3) Don't use pipes `|` — use `--jq` or tool-native filtering. This applies to all Bash commands, not just `gh`
- **NEVER use consecutive quote characters at word boundaries in Bash commands.** Patterns like `'"word"'` or `"'word'"` trigger "potential obfuscation" detection, which blocks the command AND corrupts allow rules. When passing search queries or arguments: use plain single-quoted strings without inner double quotes (e.g., `'some search terms'` not `'"some search terms"'`). If exact-phrase matching is needed, rely on the tool's own query syntax, not shell-level quoting
- When a Bash command is blocked by a permission prompt and the command is **read-only / non-mutating**, proactively suggest adding it to the global allow list (`~/.claude/settings.json`) via AskUserQuestion. Include the exact rule string (e.g., `Bash(gh repo view:*)`). This applies to:
  - **git** read commands (e.g., `git show`, `git rev-parse`, `git describe`) — never suggest allowing mutating git commands (`push`, `reset`, `clean`, `rebase`)
  - **gh** read commands (e.g., `gh repo view`, `gh run view`, `gh release list`) — never suggest allowing mutating gh commands (`create`, `merge`, `comment`, `delete`, `close`)
  - **sq curl / beyond-curl** GET requests against `*.sqprod.co` URLs — never suggest allowing POST/PUT/DELETE or non-sqprod.co targets
- Keep the suggestion brief and non-blocking — ask once, accept the answer, move on

## Scope Discipline

- Do not modify files or code outside the explicit scope of the current task. If you feel you must update or improve something outside the current scope, let's talk about it
- **Don't "improve" adjacent code, comments, or formatting** when making a change — match existing style even if you'd do it differently. The diff should contain only lines that trace directly to the request; everything else is noise
- **When your changes orphan something** (an import, variable, or function that only YOUR edit made unused), remove it. Don't remove pre-existing dead code unless asked — mention it instead
- **Stay within `~/Development`.** Your working scope is the user's `~/Development` tree (and subdirectories) unless you are *specifically directed* to look elsewhere. Do not snoop around `~`, `~/Library`, `~/Documents`, `/etc`, `/usr`, `/var`, `/tmp`, or any other path outside `~/Development` just to gather context. If a task genuinely requires reading something outside `~/Development` (e.g., a config in `~/.config/...`), ask first rather than browsing
- **NEVER traverse the filesystem root or other top-level system paths.** Do not run `find /`, `grep -r /`, `ls /`, `du /`, or any command that scans from `/`, `/Users`, `/System`, `/Library`, `/private`, etc. Always search from `.` or a specific known path inside `~/Development`. Root-level scans are slow, leak irrelevant results into context, can exhaust system resources, and almost never produce useful signal for the task at hand
- **Scratch files belong in the repo's local build/scratch directory, not `/tmp` or `~/tmp`.** When you need a place for temporary output (generated files, intermediate artifacts, captured logs, test fixtures), use the current project's gitignored scratch space: `./build` in a Gradle project, `target/` for Maven/Cargo, `node_modules/.cache` or `dist/` for Node, `.gradle`, `out/`, etc. — whatever the project's build tool already treats as disposable and its `clean` task removes. This keeps artifacts inside the working scope, cleaned up by existing tooling, and out of system paths. System temp dirs ARE sometimes necessary (e.g., a tool hardcodes `/tmp`, or you need a path outside the repo to avoid build-tool file watchers); use them when genuinely required, but always favor a repo-relative path when one works

## Git Workflow

- For git operations: always confirm the correct parent branch before creating a new branch. Use force-clean approaches when user asks to reset. Never modify PR descriptions unless explicitly asked
- **When the user says "push it" or "push"**, that means commit any uncommitted changes first, then push. If no PR exists for the branch, use AskUserQuestion to ask whether to create one. If the diff looks risky or surprising, or there are staged/unstaged changes you didn't expect, check with the user before committing — but don't stall on the obvious
- **CRITICAL: Vet the branch name before pushing the initial commit to a new branch.** Before the first push, look at the current branch name. If it's a low-quality descriptor — auto-generated from a chat message or prompt fragment (e.g., `if-you-look-at-my-comment`), a throwaway placeholder, or anything that narrates the conversation instead of describing the change — STOP and recommend a better name, then offer to rename it with `git branch -m <new-name>` before pushing. Branch names must be short, kebab-case, and describe the actual change (e.g., `readme-new-key-conventions`, `fix-sts-role-session-name`). Never push an initial commit to a branch with a junk or nonsensical name without flagging it first. This does not apply to branches that already exist on the remote (renaming those is disruptive) — only to the first push of a new branch

## Working Style

- **State assumptions before implementing.** If multiple interpretations exist, name them and ask — don't pick silently. If something is unclear, stop and surface the confusion rather than guessing and burning a correction cycle
- When building features, start writing code promptly. Do not over-explore by reading JAR files, scanning unrelated directories, or doing excessive research before implementing. Ask if unsure rather than exploring endlessly
- **For multi-step tasks, state a brief plan first** — e.g., "1. X → verify Y, 2. A → verify B" — so the approach is visible before work starts and gaps can be caught early
- **Avoid unnecessary test/compile cycles during implementation.** Don't stop to validate after every small change. Batch implementation work, then verify. Run tests mid-build only when the result would actually change your next step (e.g., confirming an interface works before building on top of it)
- **NEVER kick off full-monorepo Gradle builds or other long-running build/test commands unprompted.** Run targeted tests for the code you changed; ask before anything monorepo-wide or long-running
- **When tests fail, do not re-run the test suite to determine what failed.** Parse the existing output, read the locally-generated test report (e.g., HTML or XML reports in `build/reports/`), or use a subagent to capture and analyze the full output. Re-running tests wastes time and context

## Language Conventions

- Use idiomatic patterns for each language. Specific conventions:
  - **Python:** no underscore-prefixed dataclass fields unless private
  - **Kotlin:** use builder patterns over constructor fields when extending existing APIs
  - **Go:** use Hermit for toolchain management, not manual file manipulation
  - **Build systems:** if a project has a Justfile, Gradle file, Bazel file, Makefile, etc., use it. Do not run language-level build commands directly (e.g., `go build`, `go test`) unless directed or required for a specific scenario

### API design
- Interface-first: public surface is an interface; the canonical impl is a nested `class Common internal constructor(...)` or a tech-prefixed sibling (`TinkKeySpace`, `AwsKeyConfig`)
- `private constructor` + companion factories; `operator fun invoke` as pseudo-constructor (reified where useful), with a `@JvmStatic fun of(...)` twin for Java callers
- Fluent builders: setters are `withX(...) = apply { ... }`, negations are `withoutX()`, boolean setters take `Boolean = true` so the no-arg call enables
- Kotlin DSL + Java parity always: receiver-lambda overload, reified inline version, and `Class<T>` version; `@JvmStatic`/`@JvmOverloads` on companion API
- Kill indirection that exists only to be generic — if a type param or helper has exactly one concrete user, use the concrete type
- Composition and delegation (`X by delegate`) over inheritance

### Idioms
- Expression bodies for single-expression functions; exhaustive `when` with no `else` over sealed/enum types so new members break compilation
- `?: throw SpecificException(...)` over `require`/`check`/`requireNotNull`; scope-function division: `apply` for builders, `also` for side effects, `let` for narrowing (name the param when the block is long)
- Collection pipelines for domain code; indexed loops + `ByteBuffer` are fine for byte/wire plumbing
- No coroutines: blocking threads, Guava services (`AbstractExecutionThreadService`, `AbstractIdleService`); `kotlin.Result` returns at infra seams with `.getOrThrow()` at call sites
- `typealias` to name primitives (`typealias KeyName = String`) and use them in signatures as documentation; match wire/external names exactly, bending Kotlin naming with surgical `@Suppress` when needed
- Prefix unsafe or test-only implementations `Insecure*` / `Fake*`
- Flat package per artifact, one public type per file, `.internal` subpackage for plumbing; trailing commas; member order: companion first, state, `init`, public methods, private helpers, `toString()` last

### Errors & observability
- Exception hierarchy lives in one `Exceptions.kt`, rooted in platform exceptions chosen for call-site compatibility; subtypes carry structured fields; offending values interpolated into messages
- Error messages are tested API contract — including what they must NOT leak
- Alert on metrics, never on log volume: unconditional counter on every error path, rate-limited logs beside them
- Logger is all-caps `LOG` in the companion via `getLogger<T>()`, lambda message syntax, throwable first; trailing ` ...` on lifecycle/in-progress messages; log recovery transitions once, never per healthy cycle
- Metric cardinality is a design constraint; metric/tag names defined once as enums so vendor impls can't drift
- Zero sensitive material (`fill(0)`) in finally/error paths, with the comment saying so

### Tests
- JUnit 5 + AssertJ + mockk. Never mockito, kotest, truth, or kotlin.test
- State as eager `val` properties on the class body, no `@BeforeEach`; backtick all-lowercase sentence names (`` `policy is executed before use` ``); regression tests named after the bug
- Negative paths dominate: `assertThatThrownBy` asserting exception type + exact message + root-cause chain
- Fakes are real implementations over insecure/in-memory/localstack backends, shipped in `testFixtures` — never stubs; mockk only at interaction seams; every `relaxed = true` gets a justification comment
- Exhaustive enum-dimension loops with `else -> throw` future-proofing; `@ParameterizedTest` + `@MethodSource` with companion test-case data classes for data-driven cases
- Random test data by default for isolation; named arguments at helper call sites

### Evolution & deletion
- Deprecate, never silently change: `@Deprecated(message, replaceWith = ReplaceWith(...), level = ...)` escalating WARNING → ERROR → removal; leave compat bridges so consumers migrate at leisure
- Prove zero callers with evidence (Sourcegraph, APM) before removing; dead-code removal ships as standalone PRs; deletion stays scope-disciplined — out-of-scope debris gets named for follow-up, not swept in
- Flag breaking changes loudly in the commit subject (`BREAKING:`)

### Guardrails (my own history has these — do not replicate)
- Resolve or remove hedge comments ("probably should be `internal`") — make the fix or ask me; don't ship the smell with a charming note
- Never merge a fix you can't verify; no "hopefully" commits
- When choosing duplication over abstraction (e.g. parallel vendor modules), add a parity test or flag the drift risk explicitly
- Consistency renames must pay their way: bundle with substantive work, stay contained
- When a change touches code another team owns, surface "do it for them vs hand them a runbook" as an explicit decision instead of defaulting to grinding it out ourselves

### Voice
- Comments explain why at the gnarly spots and may name the right long-term fix when shipping a narrow patch; KDoc saturated with `[BracketRefs]`, install snippets, and `@throws X When ...`
- Calibrated, plainspoken uncertainty is welcome; self-correct in public; evidence over assertion; Socratic question before prescription; fast ownership of real mistakes, plain pushback on noise
- Zero ego projected outward — coveralls, not ivory tower
