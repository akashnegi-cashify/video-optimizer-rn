# Prompt: Project Documentation for Flutter Applications

## Role

You are a **senior software architect and technical writer** with deep expertise in Flutter, Dart, Provider state management, and enterprise mobile architecture. Your task is to produce comprehensive, accurate, and maintainable documentation for a Flutter application. Write with precision — every claim must be verifiable against the codebase. Mark anything you cannot confirm with `[ASSUMPTION]` or `[UNKNOWN]` and include a justification. Never fabricate file paths, class names, or method signatures.

---

## Overview

This prompt is **reusable across Flutter applications** that share a similar architecture. Use it in any Flutter repo that has: **lib/src/modules/** (feature modules), **lib/src/common/** (shared actions, providers, utilities), **lib/src/interceptors/** (HTTP interceptors), **lib/src/environments/** (environment config), and a **schema-driven or named-route navigation** system.

**Output:** All generated documentation must be written to the **`docs/`** folder at the **project root**.

These apps consume external APIs via an HTTP client with interceptors. State management uses **Provider** and **ChangeNotifier** (or a project-specific base like **CshChangeNotifier**). Documentation should reflect: application overview, feature modules, API services and DTOs, routing, component patterns, state management (Provider), security, data flow, configuration, error handling, performance, testing, and permissions.

---

## Scope Of Documentation

The `docs/` folder will contain **17 files** plus a validation checklist (18 total). Every file listed below **must** be generated:

```
docs/
  Application Overview.md         # App purpose, target users, business goals, feature list
  Architecture.md                 # System architecture, tech stack, dependency boundaries, deployment
  Module Reference.md             # All feature modules with user journeys, key files, data flow
  Api Services.md                 # Service classes, HTTP client, interceptors, DTOs, request/response lifecycle
  Routing.md                      # Named routes, navigation model, navigator observers, guards
  Components.md                   # Shared components, package widgets, app widgets
  State Management.md             # Provider architecture, root vs scoped providers, lifecycle
  Security.md                     # Auth flow, interceptor chain, session expiry, token management
  Data Flow.md                    # End-to-end data lifecycle, DTO serialization, CRUD sequence diagrams
  Configuration.md                # --dart-define env, environments, flavors, build configuration
  Error Handling.md               # Network failures, HTTP errors, session expiry, error tracking, logging
  Performance.md                  # Const constructors, ListView.builder, Provider listen, disposal
  Testing.md                      # flutter_test, mocking, action/provider/widget/service testing
  Permissions.md                  # Backend-enforced permissions, feature flags, access control
  Local Setup.md                  # Dev environment, Flutter SDK, scripts, env vars, common setup issues
  Glossary.md                     # Domain terms, status definitions, external services, acronyms
  Troubleshooting.md              # Common issues: build failures, auth, env mismatch, hot reload
  Documentation Validation.md     # Post-generation validation checklist and verification record
```

---

## Style And Output Requirements

- **Tone:** Professional, precise, and developer-friendly. Write for an audience of mid-to-senior engineers and AI assistants.
- **No assumptions without labels:** If a detail cannot be confirmed from the codebase, mark it with `[ASSUMPTION]` or `[UNKNOWN]` and explain why.
- **Tables for structured data:** Use Markdown tables for technology stacks, environment variables, route listings, service method signatures, provider inventories, and any comparison data.
- **Code examples:** Include real file references from the codebase being documented. Use actual file paths, class names, and method signatures — never generic placeholders without real backing.
- **Mermaid diagrams:** Every architectural, flow, and sequence concept must include a Mermaid diagram where it adds clarity. Follow the Diagram Guidelines section below.
- **Cross-references:** Link between docs using Title Case filenames with `%20` for spaces (e.g. `[State Management](./State%20Management.md)`).
- **Document Information Header:** Every generated file must begin with a metadata header:

```markdown
<!-- Document Information -->
<!-- Generated: {{ISO_DATE}} -->
<!-- Version: {{PUBSPEC_VERSION from pubspec.yaml}} -->
<!-- Commit: {{SHORT_COMMIT_HASH}} -->
```

---

## Context Rule

Use the **entire codebase** as the source of truth. Read every relevant file — do not sample or skip. Document **all** implementations found, not a representative subset. The documentation must be a complete map of the application so that an AI assistant or new engineer can navigate and understand the system without reading the source code first.

---

## Documentation Naming Convention

- **File names:** Use **Title Case with spaces** for doc filenames in `docs/` (e.g. `Api Services.md`, `Module Reference.md`, `State Management.md`). Do **not** use UPPER_SNAKE_CASE or ALL_CAPS.
- **Document title (H1):** Use human-readable **Title Case**.
- **Cross-references:** Use the same Title Case filename with `%20` for spaces in links (e.g. `[Error Handling](./Error%20Handling.md)`).
- **Consistency:** New docs must follow these rules so the docs folder stays consistent.

---

## Project Configuration (Customize per repo)

Before running this prompt in a repo, **discover** these values from the codebase. Use them in titles, cross-references, and examples.

| Variable | Description | How to discover |
|----------|-------------|-----------------|
| **PROJECT_NAME** | Human-readable app name for doc titles | `pubspec.yaml` name or team convention |
| **PACKAGE_NAME** | Dart package name | `pubspec.yaml` name field |
| **SHARED_PACKAGES** | Shared Flutter packages (git or pub deps) | `pubspec.yaml` dependencies — list key shared/internal packages |
| **RULES_PATH** | Cursor rules for this architecture | Look for `.cursor/rules/*.mdc` |
| **SKILLS_PATH** | Cursor skills for project patterns | Look for `.cursor/skills/*/SKILL.md` |
| **ENVIRONMENTS** | Available environments | `lib/src/environments/` or equivalent config |
| **ACTIONS_PATH** | Path to app actions (if the project uses an action pattern) | Look for `lib/src/common/*/actions/` or equivalent |
| **PROVIDERS_ROOT** | Where root providers are declared | `app.dart` MultiProvider or equivalent |

- If **RULES_PATH** or **SKILLS_PATH** do not exist in the repo, skip references to them and document patterns by reading the codebase.
- **Module count**, **action count**, **provider count**, and **route count** must be **discovered by analysis** (do not hardcode; each app has different counts).

---

## Cursor Integration

### Related Cursor Rules (when present)

If the repo contains rules under **RULES_PATH** (e.g. `.cursor/rules/`), read them for architectural conventions:

- Project structure and module patterns
- Coding standards, naming conventions, null safety
- Build commands, environment config, code generation, dependency management
- Localization standards
- Flutter/Dart best practices

If these files are missing, infer patterns from the codebase.

### Related Skills (when present)

If the repo contains **SKILLS_PATH** (e.g. `.cursor/skills/`), read when generating docs. Skills document how to create actions, providers, screens, components, widgets, services, interceptors, tests, etc.

If skills are missing, use the patterns described in this prompt.

### Shared Architecture Assumptions (discover and adapt per project)

Discover the actual project structure. Common patterns across Flutter apps:

- **lib/src/modules/** — Feature modules (screens, widgets, resources/providers per module)
- **lib/src/common/actions/** (or similar) — App actions invoked via an action execution system (e.g. `ActionType.executeAction`); each action is a separate `.dart` file
- **lib/src/common/providers/** — App-wide providers
- **lib/src/interceptors/** — HTTP interceptors (auth, header, logging)
- **lib/src/environments/** — Environment config (stage, beta, prod) selected via `--dart-define=env=...`
- **lib/src/app.dart** — Root widget, MultiProvider, MaterialApp/CupertinoApp, named routes
- **lib/src/app_initializer.dart** (or equivalent) — App initialization (env, auth, HTTP client, action registration)
- **Shared packages** — Shared UI widgets, HTTP client, component builders, localization (discovered from `pubspec.yaml`)
- **State management** — Provider with ChangeNotifier (or project base like CshChangeNotifier)
- **Serialization** — `json_serializable` with `fromJson`/`toJson`, code generated via `build_runner`

Adapt these assumptions to the actual project structure discovered in Phase 1.

---

## Subagent Execution Strategy

**Goal:** Generate documentation **as fast as possible** by running **multiple subagents in parallel**.

### Phase 1 — Project Analysis (PARALLEL, 11 subagents)

Run all eleven analysis tasks **at the same time**. Collate results into a **Project Analysis Manifest** so Phase 2 subagents can reuse it.

| Subagent | Task | Output to share |
|----------|------|-----------------|
| A1 | List all modules in `lib/src/modules/` (or project equivalent): folder names, screens per module, key files | Module list + per-module summary |
| A2 | List all actions (discover the actions directory): file names, action class names, what each action does, navigation targets | Action inventory + per-action summary |
| A3 | List all routes (from `app.dart` routes map or router config): route constant, screen class, module | Route list + screen-to-module mapping |
| A4 | List shared components: app widgets, shared package widgets, component builder patterns | Component list + component directories |
| A5 | Extract config: `pubspec.yaml` deps/version, environment files, app initializer, project config | Config summary, env vars, auth flow, initialization sequence |
| A6 | Inventory all interceptors: discover interceptor directory and HTTP client initialization — list interceptors in execution order | Interceptor chain table (Order, Interceptor, File, Behavior) |
| A7 | Inventory all providers: root-level (from app MultiProvider), module-level (from module `resources/` or `provider/` dirs) — class name, file, purpose, scope | Provider list + per-provider summary |
| A8 | Inventory all DTOs/models: models with `@JsonSerializable` or equivalent, request/response classes — class name, file path, fields | DTO list + per-DTO field summary |
| A9 | Inventory services: all service classes across app and shared packages — class name, methods, HTTP verbs used | Service inventory + per-service method list |
| A10 | Inventory shared package components: list widgets from shared packages, component builders, localization setup | Shared package component inventory |
| A11 | Inventory analytics and error tracking: analytics setup, error tracking integration (e.g. Sentry, Firebase Crashlytics), debugging tools, Logger configuration | Analytics and monitoring inventory |

### Phase 2 — Document Generation (PARALLEL, one doc per subagent)

After Phase 1, spawn **one subagent per document** and run them **all in parallel**.

| Subagent | Single output |
|----------|----------------|
| D1  | `docs/Application Overview.md` |
| D2  | `docs/Architecture.md` |
| D3  | `docs/Module Reference.md` |
| D4  | `docs/Api Services.md` |
| D5  | `docs/Routing.md` |
| D6  | `docs/Components.md` |
| D7  | `docs/State Management.md` |
| D8  | `docs/Security.md` |
| D9  | `docs/Data Flow.md` |
| D10 | `docs/Configuration.md` |
| D11 | `docs/Error Handling.md` |
| D12 | `docs/Performance.md` |
| D13 | `docs/Testing.md` |
| D14 | `docs/Permissions.md` |
| D15 | `docs/Local Setup.md` |
| D16 | `docs/Glossary.md` |
| D17 | `docs/Troubleshooting.md` |
| D18 | `docs/Documentation Validation.md` |

**If the tooling limits concurrent subagents:** Group docs into batches (e.g. 4 at a time).

### Phase 3 — Cross-Reference and Consistency Pass (single agent)

Ensure all cross-references use correct filenames with `%20` encoding. Verify module counts, route counts, provider counts, action counts.

### Phase 4 — Quality Gate (single agent)

Validates all 18 files against the Quality Checklist below. Fixes issues before proceeding.

### Phase 5 — Verification (separate review agent)

Review agent validates against Post-Generation Verification checklist. Fix loop until all pass.

### Summary

- **Phase 1:** 11 subagents → Project Analysis Manifest (modules, actions, providers, interceptors, services, DTOs, routes, components, config)
- **Phase 2:** 18 subagents (or batched) → 18 docs in `docs/`
- **Phase 3:** 1 consistency agent → cross-reference validation
- **Phase 4:** 1 quality agent → quality checklist → fixes
- **Phase 5:** 1 verification agent → detailed audit → fix loop → final sign-off

---

## Prerequisites

Before generating documentation, ensure you have:

- Access to the full codebase (`lib/`, `pubspec.yaml`, shared packages if local, `.cursor/`)
- Understanding of: Flutter widget lifecycle, Provider pattern, the project's action execution system (if any), HTTP client interceptors
- Knowledge of which packages are git dependencies (external to repo but consumed by it) vs pub dependencies

---

## Documentation Output Structure

All generated documentation must be placed in **`docs/`** at the **project root**:

```
docs/
  Application Overview.md         # App purpose, target users, business goals, feature list
  Architecture.md                 # System architecture, tech stack, dependency boundaries, deployment
  Module Reference.md             # All feature modules with user journeys, key files, data flow
  Api Services.md                 # Service classes, HTTP client, interceptors, DTOs, request/response lifecycle
  Routing.md                      # Named routes, navigation model, navigator observers, guards
  Components.md                   # Shared components, package widgets, app widgets
  State Management.md             # Provider architecture, root vs scoped providers, lifecycle
  Security.md                     # Auth flow, interceptor chain, session expiry, token management
  Data Flow.md                    # End-to-end data lifecycle, DTO serialization, CRUD sequence diagrams
  Configuration.md                # --dart-define env, environments, flavors, build configuration
  Error Handling.md               # Network failures, HTTP errors, session expiry, error tracking, logging
  Performance.md                  # Const constructors, ListView.builder, Provider listen, disposal
  Testing.md                      # flutter_test, mocking, action/provider/widget/service testing
  Permissions.md                  # Backend-enforced permissions, feature flags, access control
  Local Setup.md                  # Dev environment, Flutter SDK, scripts, env vars, common setup issues
  Glossary.md                     # Domain terms, status definitions, external services, acronyms
  Troubleshooting.md              # Common issues: build failures, auth, env mismatch, hot reload
  Documentation Validation.md     # Post-generation validation checklist and verification record
```

---

## Step 1: Analyze Project Structure

### 1.1 Identify Key Directories

Discover the actual directory structure. Common directories to look for:

| Directory (discover actual path) | Purpose |
|----------------------------------|---------|
| `lib/src/modules/` | Feature modules — screens, widgets, resources (providers, services) per module |
| `lib/src/common/` | Shared code — actions, providers, utilities, helpers |
| `lib/src/common/*/actions/` | App actions — each action is a `.dart` file invoked via the action execution system |
| `lib/src/common/providers/` | App-wide providers |
| `lib/src/interceptors/` | HTTP interceptors (auth, header, logging) |
| `lib/src/environments/` | Environment config (e.g. stage, beta, prod) |
| `lib/src/app.dart` | Root widget, MultiProvider, MaterialApp, named routes map |
| `lib/src/app_initializer.dart` | App initialization (env, auth, HTTP client, action registration) |
| `lib/src/theme/` | Theme configuration |
| `lib/src/analytics/` | Analytics integration |
| `lib/src/libraries/` | Third-party integrations (debugging tools, error tracking) |
| `lib/src/localization/` or `lib/src/l10n/` | Localization setup and ARB files |
| `lib/src/utils/` | Utility functions |
| `lib/src/widget/` | App-level shared widgets |
| Shared packages (from pubspec.yaml) | Shared components, widgets, services |

### 1.2 Extraction Checklist

**From modules:**

- [ ] List all module folder names
- [ ] For each module: screen class(es), widgets, resources (providers, services)
- [ ] User journey flows: preconditions, step-by-step, screens involved, failure scenarios
- [ ] Inter-module dependencies (which actions navigate to which screens)
- [ ] Module-to-action mapping (which actions relate to which modules)

**From actions:**

- [ ] Discover the actions directory (e.g. `lib/src/common/*/actions/`)
- [ ] List all action files
- [ ] For each action: class name, purpose, parameters, navigation target
- [ ] Action registration mechanism (how actions are registered and invoked)
- [ ] Action execution flow (e.g. `ActionType.executeAction(context, params)`)
- [ ] Action categories (group by domain: auth, navigation, data operations, etc.)

**From providers:**

- [ ] Root-level providers (from `app.dart` MultiProvider or equivalent)
- [ ] Module-level providers (in module `resources/` or `provider/` directories)
- [ ] Providers in shared packages
- [ ] For each provider: class name, base class (ChangeNotifier or project base), purpose, scope (root/screen), key state fields
- [ ] Provider lifecycle: dispose patterns, notifyListeners guards
- [ ] Provider access pattern: static `of(context)` method, Consumer, Selector

**From services/resources:**

- [ ] List all service classes
- [ ] For each: methods, HTTP verbs, endpoint patterns
- [ ] Request and response DTO classes (with `@JsonSerializable` or equivalent)
- [ ] Service-to-module mapping (which modules consume which services)

**From interceptors:**

- [ ] All interceptors in the interceptors directory
- [ ] How interceptors are registered (helper class, initializer, etc.)
- [ ] For each: key, class name, file, behavior, conditions

**From app.dart (or root widget):**

- [ ] All named routes or router configuration
- [ ] Navigator observers
- [ ] Root-level providers (MultiProvider)
- [ ] Session expiry or auth callback setup
- [ ] Connectivity monitoring

**From environments:**

- [ ] All environments defined (e.g. stage, beta, prod)
- [ ] Environment properties (API URLs, CDN, auth URIs, feature flags, etc.)
- [ ] How the environment is selected at build time (`--dart-define` or equivalent)
- [ ] Remote config overlay (if any)

**From config/init:**

- [ ] App initialization sequence
- [ ] Project configuration (branding, feature flags, client IDs, etc.)
- [ ] Build commands and required flags

**From components:**

- [ ] Shared widgets from packages
- [ ] App-level widgets
- [ ] Component builder patterns (if any)

---

## Step 2: Template — docs/Application Overview.md

```markdown
<!-- Document Information -->
<!-- Generated: {{ISO_DATE}} -->
<!-- Version: {{PUBSPEC_VERSION}} -->
<!-- Commit: {{SHORT_COMMIT_HASH}} -->

# {{PROJECT_NAME}} Application Overview

## Table of Contents
- [Purpose](#purpose)
- [Target Users](#target-users)
- [Business Goals](#business-goals)
- [Key Assumptions](#key-assumptions)
- [Version Information](#version-information)
- [Feature Summary](#feature-summary)

## Purpose

[One to two paragraphs describing the application's purpose. Derive from the codebase — module names, screen titles, and service integrations tell the story.]

## Target Users

[Who uses this application. Infer from module names, screen flows, and domain terminology.]

## Business Goals

[What business outcomes the app supports. Derive from module functionality.]

## Key Assumptions

- This is a **Flutter** application targeting [discover platforms: iOS, Android, Web].
- Data comes from **external backend APIs** via HTTP client with interceptors.
- **Authentication** is handled via tokens managed by the auth layer and injected by interceptors.
- **State** is managed with **Provider** and **ChangeNotifier** (or project-specific base class).
- **Actions** [describe the action execution pattern if the project uses one, or note that navigation is direct].
- **Localization** uses ARB files and generated localizations.
- [Add any project-specific assumptions discovered from the codebase]

## Version Information

| Field | Value |
|-------|-------|
| Package name | [From `pubspec.yaml` name] |
| Version | [From `pubspec.yaml` version] |
| SDK constraint | [From `pubspec.yaml` environment.sdk] |
| Key dependencies | [List key shared packages discovered from pubspec.yaml] |

## Feature Summary

[Table listing every feature module discovered. Include module name, description, and key screens.]

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| [module-name] | [Purpose derived from screen names and code analysis] | [Screen classes] |

## Related Documents

- [Architecture](./Architecture.md) — System architecture and tech stack
- [Module Reference](./Module%20Reference.md) — Detailed module documentation
- [Local Setup](./Local%20Setup.md) — Development environment setup
```

---

## Step 3: Template — docs/Architecture.md

```markdown
<!-- Document Information -->
<!-- Generated: {{ISO_DATE}} -->
<!-- Version: {{PUBSPEC_VERSION}} -->
<!-- Commit: {{SHORT_COMMIT_HASH}} -->

# {{PROJECT_NAME}} System Architecture

## Technology Stack

[Discover from pubspec.yaml and codebase. Table with Layer, Technology, Purpose.]

| Layer | Technology | Purpose |
|-------|------------|---------|
| Framework | Flutter | UI, routing, platform abstraction |
| State | Provider, ChangeNotifier (or project base) | State management |
| HTTP | [Discover HTTP client used] | API calls with interceptors |
| Navigation | [Named routes / GoRouter / builder_project / etc.] | Screen navigation |
| UI components | [Discover shared widget packages] | Shared widgets |
| Localization | ARB, intl | User-facing strings |
| [Other layers] | [Discover] | [Purpose] |

## High-Level Architecture

[Mermaid flowchart: Client → Flutter App → Navigation → Screens/Actions/Services/Interceptors → Backend]

## Dependency Boundaries

[Table showing which layers can import from which. Discover from actual import patterns.]

## Request and Data Flow

[Mermaid sequence: Screen → Action/Provider → Service → HttpClient → Interceptors → Backend → Response → fromJson → Provider → notifyListeners → UI]

## Route Structure

[Describe routing model: named routes, GoRouter, or schema-driven. Discover from app.dart or router config.]

## Shared Package Dependency Tree

[Mermaid showing app → shared packages discovered from pubspec.yaml]

## Deployment Flow

[Mermaid: Developer → Git Push → CI → flutter build (dart-define + flavor + obfuscate) → Artifacts → Deploy]

## Related Documents

- [Data Flow](./Data%20Flow.md) — Detailed data lifecycle
- [Configuration](./Configuration.md) — Build and environment config
- [Module Reference](./Module%20Reference.md) — Module details
```

---

## Step 4: Template — docs/Module Reference.md

Discover the **actual module count** from the project. Repeat the module template for **every** feature module. Each module section must include: Overview, Key files, Architecture mermaid, Workflows, User journey.

Additionally, if the project uses an **action system**, document the **Action Inventory** — all actions with action-to-module mapping.

```markdown
<!-- Document Information -->
<!-- Generated: {{ISO_DATE}} -->
<!-- Version: {{PUBSPEC_VERSION}} -->
<!-- Commit: {{SHORT_COMMIT_HASH}} -->

# Module Reference

## Overview
| Modules | Description |
|---------|-------------|
| [N — discover by counting module subfolders] | Feature modules — each with screens, optional providers/services, and widgets |

## Module Index

[Table listing ALL modules with Path, Description, Key Screens, Related Actions]

## Action Inventory (if the project uses an action pattern)

[Table listing ALL actions with: Action Class, File, Purpose, Target Screen/Module, Parameters]

---

## Module Template (repeat per module)

### [module-name]

#### Overview

| Property | Value |
|----------|-------|
| Path | [module path] |
| Screens | [Screen classes and their route constants] |
| Related Actions | [Actions that navigate to or interact with this module] |

**Purpose:** [One to two sentences.]

**Key files:**
- Screen: `[name]_screen.dart` — [brief purpose]
- Widgets: `widgets/[name].dart` (if any)
- Resources/Provider: `resources/[name]_provider.dart` (if any)

#### Architecture

[Mermaid flowchart showing Screen → Widget → Provider → Service → Backend]

#### Workflows

| # | Workflow | Trigger | Description |
|---|---------|---------|-------------|
| 1 | [e.g. Screen Load] | [Trigger] | [One line] |

#### User Journey

| Step | Action | Screen | Expected Result | Failure Scenario |
|------|--------|--------|-----------------|------------------|
| Precondition | [User logged in] | — | — | Redirect to login |
| 1 | [Navigate to module] | [Screen] | [What loads] | [Error handling] |

## Related Documents

- [Routing](./Routing.md) — Screen-to-route mapping
- [Api Services](./Api%20Services.md) — API usage by module
```

---

## Step 5: Template — docs/Api Services.md

```markdown
<!-- Document Information -->
<!-- Generated: {{ISO_DATE}} -->
<!-- Version: {{PUBSPEC_VERSION}} -->
<!-- Commit: {{SHORT_COMMIT_HASH}} -->

# Api Services Reference

## Overview
[Describe the HTTP client and service pattern used. Discover from codebase.]

## HTTP Client Initialization

[Document how the HTTP client is initialized: base URL, API URL, token URL, interceptors.]

## Interceptor Chain

[Table: Order, Interceptor, File, Condition, Behavior — discover from interceptor helper/initializer]

## Request/Response Lifecycle

[Mermaid sequence: Screen/Action → Service → HttpClient → Interceptors → Backend → JSON → fromJson(DTO) → Provider → UI]

## DTO Serialization

[Describe serialization pattern: json_serializable, manual fromJson/toJson, freezed, etc.]

## Error Codes

[Table: HTTP code, Meaning, Handling — discover from interceptor and error handling code]

## Service Locations

[Table: Service Class, File Path, Module(s) that consume it, Methods]

## Environment Configuration Per Service

[Table: Environment, API URL, CDN, Auth URI — discover from environments file]

## Related Documents

- [Data Flow](./Data%20Flow.md) — End-to-end data lifecycle
- [Security](./Security.md) — Auth and interceptor chain
- [Error Handling](./Error%20Handling.md) — Error propagation
```

---

## Step 6: Template — docs/Routing.md

```markdown
<!-- Document Information -->
<!-- Generated: {{ISO_DATE}} -->
<!-- Version: {{PUBSPEC_VERSION}} -->
<!-- Commit: {{SHORT_COMMIT_HASH}} -->

# Routing Reference

## Overview
[Describe the navigation model: named routes, GoRouter, schema-driven, etc. Discover from app.dart or router config.]

## Navigation Model

| Concept | Description |
|---------|-------------|
| [Routing approach] | [Discover from codebase] |
| Screen registration | [How screens are registered] |
| Navigation trigger | [How navigation is triggered: actions, direct push, etc.] |
| Initial route | [Discover initial route] |
| Unknown route | [Discover fallback route] |

## Navigator Observers

[Table: Observer class, file, purpose — discover from app.dart navigatorObservers]

## Route Guard Flow

[Mermaid: Request → Authenticated? → Show screen or redirect]

## Navigation State Transitions

[Mermaid stateDiagram: discover from actual app flow]

## Redirect Scenarios

[Table: Scenario, Trigger, Result — discover from auth handling, logout, error flows]

## Complete Routes Listing

[Table with ALL routes: Route Constant, Screen Class, Module, Purpose]

## Related Documents

- [Architecture](./Architecture.md) — Navigation architecture
- [Security](./Security.md) — Session expiry and auth
- [Module Reference](./Module%20Reference.md) — Screen-to-module mapping
```

---

## Step 7: Template — docs/Components.md

Document all component sources discovered from the codebase: shared package widgets, app-level widgets, and any component builder patterns.

```markdown
<!-- Document Information -->

# Components and Patterns

## Component Sources

[Table: Source, Package/Path, Description — discover from pubspec.yaml and lib/]

## Component Category Index

[Table: Category, Components, Source, Description — categorize discovered components]

## Shared Package Component Directories

[List component directories from shared packages]

## Component Dependency Graph

[Mermaid showing relationships between component layers]

## Component Builder (if applicable)

[Document any component builder pattern used in the project]

## Widget Guidelines

[From .cursor/rules or codebase conventions: const constructors, extraction, keys, disposal]

## Related Documents

- [Module Reference](./Module%20Reference.md) — Where components are used
- [Architecture](./Architecture.md) — Package boundaries
```

---

## Step 8: Template — docs/State Management.md

**Provider-based architecture.** Document all providers with their scope, lifecycle, and access patterns.

```markdown
<!-- Document Information -->

# State Management

## Overview
[Describe the state management approach. Discover from codebase: Provider, ChangeNotifier, project-specific base class, etc.]

## Provider Architecture

[Mermaid: Root MultiProvider → [root providers]; Screen-scoped → module providers]

## Root-Level Providers

[Table: Provider Class, Purpose, Lazy — from root widget MultiProvider]

## Module-Level Providers

[Table: Provider Class, Module, File, Purpose — from module directories]

## Provider Pattern

[Dart code example showing the project's provider pattern: base class, static of(), notifyListeners(), dispose()]

## Global vs Local State

| State type | Technology | When to use | Example |
|------------|------------|-------------|---------|
| App-wide | Provider (root) | Session, locale, global flags | [discover] |
| Screen-scoped | Provider (screen-level) | Screen-specific data | [discover] |
| Form state | Local state / controllers | Single screen forms | TextEditingController |
| Navigation | [Discover pattern] | Current route | [discover] |

## Provider Lifecycle

[Mermaid sequence: Widget initState → Provider.of → loadData → service.call → notifyListeners → build]

## State Persistence

[Describe what persists and what is scoped. Discover from codebase.]

## Async and Lifecycle Rules

- Check `mounted` before `notifyListeners()` after async work
- Override `dispose()` to cancel timers, subscriptions, observers
- Call `super.dispose()` last
- Use `listen: false` when only calling methods (not subscribing)

## Related Documents

- [Data Flow](./Data%20Flow.md) — How data flows through state
- [Architecture](./Architecture.md) — Provider layout
```

---

## Step 9: Template — docs/Security.md

Include the **full interceptor chain** with per-interceptor detail, **session expiry flow**, **token management**, and **auth flow**.

```markdown
<!-- Document Information -->

# Security

## Interceptor Pipeline

### Interceptor Chain
[Table: Order, Interceptor, File, Condition, Behavior — discover from codebase]

### Per-Interceptor Detail
[For each interceptor: Purpose, File, Trigger, Behavior, Error handling]

### Pipeline Diagram
[Mermaid: Request → [interceptors in order] → Backend → Response]

## Session Expiry Flow
[Mermaid sequence showing what happens on session expiry / auth failure]

## Token Storage and Management
[Describe how auth tokens are stored, injected, and refreshed]

## Authentication Flow
[Mermaid sequence: User → Login → Auth service → Backend → Token → Stored → Navigate to home]

## Related Documents

- [Configuration](./Configuration.md) — Environment and auth config
- [Error Handling](./Error%20Handling.md) — Session expiry handling
```

---

## Step 10: Template — docs/Data Flow.md

Include **CRUD sequence diagrams**, **action-based data flow**, **interceptor pipeline in data context**, and **error propagation path**.

---

## Step 11: Template — docs/Configuration.md

Document **`--dart-define`**, **environment files** (all environments with properties), **build commands** (debug/release per environment), **project configuration** (branding, feature flags), **code generation**, and **logging configuration**.

---

## Step 12: Template — docs/Error Handling.md

Document **network failures**, **HTTP error codes**, **session expiry**, **error tracking integration** (e.g. Sentry), **connectivity handling**, **alert handlers**, and **Logger usage**.

---

## Step 13: Template — docs/Performance.md

Document **const constructors**, **ListView.builder**, **Provider listen: false**, **resource disposal**, **image caching**, **build optimization flags**, and **debugging tools** (non-prod only).

---

## Step 14: Template — docs/Testing.md

Document **test framework** (flutter_test), **mocking library** (mocktail or mockito), testing patterns for **actions**, **providers**, **widgets**, **services**, **critical paths**, **mutation testing** (if used), and **pre-commit hooks**.

---

## Step 15: Template — docs/Permissions.md

Document how permissions are enforced: **backend-enforced** (API returns 403), **feature flags** (project config or `--dart-define`), **role-based access** (if any), and **session-based access control**.

---

## Step 16: Template — docs/Local Setup.md

Document **Flutter SDK requirements**, **dependency installation** (`flutter pub get`), **all build/run commands** per environment, **code generation** (build_runner, schema generators), **pre-commit hooks**, **common setup issues**, and **dependency pinning** guidelines.

---

## Step 17: Template — docs/Glossary.md

Include **project-specific terms** (discover domain terminology from modules, DTOs, and screens), **status definitions**, **external services** (discover from environment config and service files), and **acronyms** (discover from codebase).

---

## Step 18: Template — docs/Troubleshooting.md

Document **build failures** (analysis errors, missing deps, env not set, code generation, schema), **CORS** (web), **auth/token** (401, session loops, wrong auth URL), **environment mismatch**, **development** (hot reload, local package changes, platform-specific errors), and **clearing/rebuilding** commands.

---

## Step 19: Template — docs/Documentation Validation.md

Per-document status table, validation checklist (completeness, accuracy, detail depth, no placeholders, Mermaid syntax, cross-references, code paths, naming), verification record.

---

## Diagram Guidelines (Mermaid)

### Flowchart
- Use `flowchart TB` or `flowchart LR`; node IDs: camelCase or PascalCase (no spaces).
- Labels with special characters: use quotes.
- Do not use reserved IDs: `end`, `subgraph`, `graph`, `flowchart`.

### Sequence Diagram
- Participants: Screen, Action, Provider, Service, HttpClient, Interceptor, Backend (or as appropriate).
- Use `->>` for async; `-->>` for return.

### State Diagram
- Use `stateDiagram-v2` for state transitions.
- State names: PascalCase, no spaces.

### Subgraphs
- Use explicit IDs: `subgraph id [Label]`.

---

## Quality Checklist

- [ ] All 18 documentation files exist under **docs/** at project root.
- [ ] Every file has a **Document Information Header** with generated date, version, and commit hash.
- [ ] **Module count** is **discovered** from the codebase and documented accurately.
- [ ] **Action count** is discovered and documented (if the project uses an action pattern).
- [ ] **Provider inventory** is complete — root-level and module-level providers.
- [ ] **Route listing** matches actual route definitions.
- [ ] **Interceptor chain** matches actual interceptor registration and initialization.
- [ ] Service and DTO patterns reference **real files from this project**.
- [ ] All Mermaid diagrams use valid syntax (no spaces in node IDs, no reserved keywords).
- [ ] Cross-references between documents are consistent (Title Case filenames, %20 for spaces).
- [ ] Local Setup reflects **this project's** `pubspec.yaml`, build commands, and Flutter SDK requirements.
- [ ] Every module has a user journey table with preconditions, steps, and failure scenarios.
- [ ] Every module has at least one **workflow step table** and an **architecture Mermaid diagram**.
- [ ] **Security.md** has the full **interceptor chain table** and **per-interceptor detail**.
- [ ] **State Management.md** has **provider inventory** (root + module-level), **provider pattern** code example, and **lifecycle rules**.
- [ ] **Data Flow.md** has at least one CRUD sequence diagram and error propagation path.
- [ ] **Configuration.md** has all environments with properties and build commands.
- [ ] No unjustified placeholders (`[TODO]`, `[TBD]`, `[PLACEHOLDER]`, `[UNKNOWN]` without justification).
- [ ] No references to React, Next.js, Redux, CASL, RxJS, Yup, Vitest, RTL, Tailwind, TypeScript, or other non-Flutter technologies.
- [ ] All project-specific patterns are discovered from the codebase, not assumed from another project.

---

## Post-Generation Verification

After all documentation files are generated, a **mandatory verification phase** must be executed.

### Verification Process

1. **Completeness check** — Confirm all 18 files exist in `docs/`.

2. **Accuracy audit per file** — Cross-reference against the actual codebase:
   - Module counts match actual module directories.
   - Action counts match actual action files (if applicable).
   - Route listings match actual route definitions.
   - Provider inventory matches root MultiProvider and module-level providers.
   - Interceptor chain matches actual registration and initialization.
   - Environment properties match actual environment files.
   - Build commands match project rules or conventions.
   - DTO classes match actual model files.
   - Service classes and methods match actual service files.

3. **Detail depth check**:
   - Every module has: purpose, key files, workflow, user journey.
   - Api Services has: interceptor chain, HTTP client init, error codes, environment URLs.
   - Security has: full interceptor chain, per-interceptor detail, session expiry flow, auth flow.
   - State Management has: provider inventory (root + module), provider pattern, lifecycle rules.
   - Data Flow has: CRUD sequence diagrams, error propagation.
   - Configuration has: all environments with properties and build commands.

4. **No placeholders** — No unjustified `[TODO]`, `[TBD]`, `[PLACEHOLDER]`.

5. **Mermaid syntax validation** — Valid syntax in all blocks.

6. **Cross-reference integrity** — All links point to existing files.

7. **Code path verification** — All cited file paths exist in the actual repo.

### Final Sign-Off

Once all documents pass: **"All 18 documents verified. Documentation is complete and accurate."**

---

## Update Documentation (When Features Change)

### Adding a New Module
1. Update **docs/Module Reference.md**: add section with all required fields.
2. Update **docs/Routing.md**: add the new route.
3. Update **docs/Application Overview.md**: add to feature summary table.

### Adding a New Action
1. Update **docs/Module Reference.md**: add action to Action Inventory and relevant module.
2. If it introduces new navigation: update **docs/Routing.md**.

### Adding a New Provider
1. Update **docs/State Management.md**: add to root-level or module-level provider table.
2. If root-level: update provider architecture diagram.
3. Update relevant module section in **docs/Module Reference.md**.

### Adding a New API Service
1. Update **docs/Api Services.md**: add service class, methods, DTOs.
2. If consumed by a module: update that module's section in **docs/Module Reference.md**.
3. Update **docs/Data Flow.md** if new data flow pattern.

### Adding a New Interceptor
1. Update **docs/Security.md**: add to interceptor chain table and per-interceptor detail.
2. Update **docs/Api Services.md**: interceptor chain section.

### Adding or Changing Routes
1. Update **docs/Routing.md**: add or modify route entry.
2. Update **docs/Architecture.md** if route structure changes.

### Changing State Management
1. Update **docs/State Management.md** with new providers, patterns, or lifecycle changes.

### Changing Security Patterns
1. Update **docs/Security.md** with auth flow changes, new interceptors, or session handling.

### After Any Update
1. Run the **Post-Generation Verification** checklist on modified documents.
2. Update **docs/Documentation Validation.md** with the new verification date and status.

---

## Quick Reference — Key File Patterns

Paths **vary by project**. Use this as a pattern checklist; discover actual paths in each repo.

| Pattern | Common locations (discover actual paths) |
|---------|------------------------------------------|
| Module screens | `lib/src/modules/[module]/[name]_screen.dart` |
| Module widgets | `lib/src/modules/[module]/widgets/[name].dart` |
| Module providers | `lib/src/modules/[module]/resources/[name]_provider.dart` or `provider/` |
| Module services | `lib/src/modules/[module]/resources/[name]_service.dart` |
| Actions | `lib/src/common/*/actions/[name]_action.dart` (discover actual path) |
| Action registry | `lib/src/common/*/app_action_type.dart` (discover actual path) |
| Root providers | Root widget file (e.g. `app.dart`) — MultiProvider |
| Named routes | Root widget file (e.g. `app.dart`) — MaterialApp routes or router config |
| Interceptors | `lib/src/interceptors/[name]_interceptor.dart` |
| Interceptor helper | `lib/src/interceptors/interceptors_helper.dart` (or equivalent) |
| Environments | `lib/src/environments/environments.dart` |
| Environment init | `lib/src/environments/environment_config.dart` |
| App initializer | `lib/src/app_initializer.dart` |
| Theme | `lib/src/theme/` |
| Analytics | `lib/src/analytics/` |
| Localization ARB | `lib/src/l10n/` or `lib/src/localization/` |
| Shared components | Shared package `lib/components/` (discover from pubspec.yaml) |
| Shared widgets | Shared widget package (discover from pubspec.yaml) |

---

## Using This Prompt in Another Flutter Repo

This prompt is **reusable across Flutter applications** that follow a modular architecture.

1. **Copy this prompt** into the other repo.
2. **Discover Project Configuration**: PROJECT_NAME, PACKAGE_NAME, SHARED_PACKAGES, RULES_PATH, SKILLS_PATH, ENVIRONMENTS, ACTIONS_PATH, PROVIDERS_ROOT.
3. **Run Phase 1 analysis**: discover modules, actions, providers, routes, interceptors, services, components, config. Do **not** copy counts or paths from another app.
4. **Generate docs** into `docs/` using the templates.
5. **Verify**: Post-Generation Verification must use **that project's** actual counts and file paths.

Same **output structure** (18 files — Title Case with spaces) applies. Adapt **architecture assumptions** to the actual project structure discovered in Phase 1.

---

## Additional Resources

- [Mermaid Documentation](https://mermaid.js.org/)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [build_runner](https://pub.dev/packages/build_runner)
- [Sentry Flutter](https://pub.dev/packages/sentry_flutter)
- Project rules: **RULES_PATH** (e.g. `.cursor/rules/*.mdc`) when present
- Project skills: **SKILLS_PATH** (e.g. `.cursor/skills/*/SKILL.md`) when present

---

**Note:** All generated documentation must be written to the **docs/** folder at the **root** of the **current** Flutter project. Always discover module names, action names, provider names, routes, and file paths from the repo being documented; do not reuse content from another project.
