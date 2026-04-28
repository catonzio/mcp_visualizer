# MCP Visualizer — Project Overview

## Summary

MCP Visualizer is a cross-platform Flutter application designed to help developers **inspect, debug, and interact with MCP (Model Context Protocol) servers** in real time.

Working with MCP servers today requires either reading raw JSON-RPC output in a terminal or writing throwaway scripts every time something needs to be verified. MCP Visualizer solves this by providing a clean, structured UI to connect to any MCP server, browse its exposed primitives (Tools, Resources, Prompts), execute operations interactively, and observe the full event stream — all without leaving the app.

The primary audience is any developer who builds or consumes MCP servers and wants a fast feedback loop during development.

---

## Problem Statement

| Pain Point | Current Workaround | MCP Visualizer Solution |
| --- | --- | --- |
| No visual way to inspect what a server exposes | Read terminal / log files | Browse Tools, Resources, Prompts in a structured list |
| Calling a tool requires writing code | Ad-hoc scripts | In-app form generated from the tool's input schema |
| No live event feed | `console.log` / grep | Real-time event log panel |
| Re-entering server configs every session | Copy-paste from notes | Saved server profiles with one-tap reconnect |
| Unclear whether a server is healthy | Guess from output | Health check screen with connection state badge |

---

## Technology Stack

| Concern | Library | Rationale |
| --- | --- | --- |
| MCP connectivity | [`mcp_client ^1.1.1`](https://pub.dev/packages/mcp_client) | Full MCP 2025-03-26 spec, STDIO / SSE / StreamableHTTP transports |
| State management | [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) + [`riverpod_annotation`](https://pub.dev/packages/riverpod_annotation) | Code-generated providers, clean async/stream support |
| Immutable models | [`freezed`](https://pub.dev/packages/freezed) + [`json_serializable`](https://pub.dev/packages/json_serializable) | Type-safe union types, copy-with, JSON serialization |
| Error handling | [`fpdart`](https://pub.dev/packages/fpdart) | `TaskEither` / `Either` for railway-oriented error pipelines |
| Navigation | [`go_router`](https://pub.dev/packages/go_router) | Declarative routing, deep-link friendly |
| Persistence | [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Cross-platform (including web), lightweight JSON storage for server profiles |
| Secure storage | [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) | Encrypted storage for auth tokens and sensitive transport headers |
| Code generation | [`build_runner`](https://pub.dev/packages/build_runner) | Drives freezed + riverpod_annotation + json_serializable |

> **Note on dio**: `mcp_client` handles all HTTP internally via the `http` package (SSE and StreamableHTTP transports). `dio` is intentionally excluded to avoid duplicating HTTP infrastructure.

---

## Supported Platforms & Transports

| Platform | STDIO | SSE | StreamableHTTP |
| --- | --- | --- | --- |
| macOS | ✅ | ✅ | ✅ |
| Windows | ✅ | ✅ | ✅ |
| Linux | ✅ | ✅ | ✅ |
| iOS | ❌ (OS restriction) | ✅ | ✅ |
| Android | ❌ (OS restriction) | ✅ | ✅ |
| Web | ❌ (native-only) | ✅ | ✅ |

Transport options are shown or hidden in the UI based on the current platform at runtime.

---

## Core Features

### 1. Server Profiles

- Create, edit, and delete named server configurations
- Each profile stores transport type (STDIO / SSE / StreamableHTTP) and its parameters (command + args, URL, headers, auth tokens)
- Non-sensitive profile data persisted via `shared_preferences`; auth tokens and sensitive headers stored in `flutter_secure_storage`
- One-tap connect / disconnect from the profile list

### 2. Connection & Health Dashboard

- Visual connection state badge (disconnected → connecting → connected → error)
- Server identity card: name, version, protocol version
- Health check panel: uptime, registered tool count, active sessions
- Automatic reconnection on transport errors with configurable backoff

### 3. Tools Explorer

- List all tools exposed by the server with name, description, and input schema
- Raw JSON input field for tool arguments (user pastes or types valid JSON; validated before submission)
- Execute a tool and display the result (text, image, or error) in a result panel
- Progress indicator for long-running operations with cancel support

### 4. Resources Explorer

- List all resources (static and template-based)
- Read and display resource content (text rendered in a scrollable viewer, binary shown as metadata)
- Subscribe to resource updates and highlight changed resources in real time

### 5. Prompts Explorer

- List all prompts with name, description, and required arguments
- Raw JSON input field for prompt arguments (validated before submission)
- Display the resulting message sequence (role + content) in a chat-style view

### 6. Event Log

- Real-time stream of all connection events, server notifications, errors, and MCP protocol messages
- Filterable by level (debug / info / warning / error) and category (connection, tools, resources, prompts)
- Copy individual entries or export the full log as plain text

---

## Architecture

The project follows a **feature-first clean architecture** pattern. Each feature is self-contained with its own data, domain, and presentation layers. Cross-feature state (the active MCP client connection) lives in a shared `connection` feature that all other features consume via Riverpod providers.

### Error Handling Strategy

`mcp_client` returns `Result` types from its factory methods. The repository layer wraps these into `fpdart` `TaskEither` chains, which propagate typed errors (`McpFailure`) up to the presentation layer. Providers expose `AsyncValue` to widgets, which use `.when()` for loading / data / error states — no unhandled exceptions in the UI.

```text
mcp_client Result  →  Repository (TaskEither)  →  Riverpod Provider (AsyncValue)  →  Widget (.when)
```

---

## Project Structure

```text
mcp_visualizer/
├── lib/
│   ├── main.dart                          # Entry point, ProviderScope
│   ├── app.dart                           # MaterialApp.router, GoRouter config, theme
│   │
│   ├── core/
│   │   ├── errors/
│   │   │   ├── mcp_failure.dart           # Freezed sealed class for all domain errors
│   │   │   └── mcp_failure.freezed.dart
│   │   ├── extensions/
│   │   │   └── result_x.dart              # Extension to convert mcp_client Result → Either
│   │   ├── theme/
│   │   │   └── app_theme.dart             # Material 3 theme tokens
│   │   └── utils/
│   │       ├── platform_utils.dart        # Runtime platform/transport availability checks
│   │       └── json_input_field.dart      # Widget: validated raw JSON textarea with parse feedback
│   │
│   ├── features/
│   │   │
│   │   ├── servers/                       # Server profile management
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── server_profile_local_datasource.dart   # shared_preferences R/W
│   │   │   │   └── repositories/
│   │   │   │       └── server_profile_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── models/
│   │   │   │   │   ├── server_profile.dart          # Freezed model (id, name, transport config)
│   │   │   │   │   ├── server_profile.freezed.dart
│   │   │   │   │   └── server_profile.g.dart
│   │   │   │   └── repositories/
│   │   │   │       └── server_profile_repository.dart   # Abstract interface
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   └── server_profile_providers.dart   # Riverpod providers
│   │   │       ├── screens/
│   │   │       │   ├── server_list_screen.dart
│   │   │       │   └── server_form_screen.dart
│   │   │       └── widgets/
│   │   │           ├── server_profile_card.dart
│   │   │           └── transport_config_fields.dart    # STDIO / SSE / HTTP sub-forms
│   │   │
│   │   ├── connection/                    # Active MCP client session (shared by all features)
│   │   │   ├── data/
│   │   │   │   └── repositories/
│   │   │   │       └── mcp_connection_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── models/
│   │   │   │   │   ├── connection_state.dart         # Freezed: disconnected | connecting | connected | error
│   │   │   │   │   └── server_info.dart              # Freezed: name, version, protocol
│   │   │   │   └── repositories/
│   │   │   │       └── mcp_connection_repository.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── mcp_client_provider.dart      # StateNotifierProvider holding the Client instance
│   │   │       │   └── connection_state_provider.dart
│   │   │       └── widgets/
│   │   │           ├── connection_status_badge.dart
│   │   │           └── server_info_card.dart
│   │   │
│   │   ├── tools/
│   │   │   ├── domain/models/
│   │   │   │   ├── tool_model.dart                  # Freezed wrapper for mcp_client Tool
│   │   │   │   └── tool_result_model.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   └── tools_providers.dart          # FutureProvider + StateNotifier for execution
│   │   │       ├── screens/
│   │   │       │   ├── tools_screen.dart
│   │   │       │   └── tool_detail_screen.dart       # Form + result panel
│   │   │       └── widgets/
│   │   │           ├── tool_list_tile.dart
│   │   │           └── tool_result_view.dart
│   │   │
│   │   ├── resources/
│   │   │   ├── domain/models/
│   │   │   │   └── resource_model.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   └── resources_providers.dart
│   │   │       ├── screens/
│   │   │       │   ├── resources_screen.dart
│   │   │       │   └── resource_detail_screen.dart
│   │   │       └── widgets/
│   │   │           └── resource_content_viewer.dart
│   │   │
│   │   ├── prompts/
│   │   │   ├── domain/models/
│   │   │   │   └── prompt_model.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   └── prompts_providers.dart
│   │   │       ├── screens/
│   │   │       │   ├── prompts_screen.dart
│   │   │       │   └── prompt_detail_screen.dart
│   │   │       └── widgets/
│   │   │           └── prompt_message_view.dart      # Chat-style message renderer
│   │   │
│   │   └── event_log/
│   │       ├── domain/models/
│   │       │   └── log_entry.dart                   # Freezed: timestamp, level, category, message
│   │       └── presentation/
│   │           ├── providers/
│   │           │   └── event_log_provider.dart       # StreamProvider fed by client.onLogging + onError
│   │           ├── screens/
│   │           │   └── event_log_screen.dart
│   │           └── widgets/
│   │               ├── log_entry_tile.dart
│   │               └── log_filter_bar.dart
│   │
│   └── shared/
│       └── widgets/
│           ├── empty_state.dart
│           ├── error_view.dart
│           └── copy_button.dart
│
├── test/
│   ├── features/
│   │   ├── servers/                       # Unit tests for repository + providers
│   │   ├── connection/
│   │   └── tools/
│   └── core/
│       └── extensions/
│           └── result_x_test.dart
│
├── pubspec.yaml
├── analysis_options.yaml
└── .github/
    └── PROJECT.md                         # This file
```

---

## Implementation Phases

### Phase 1 — Foundation

- Project scaffolding: routing, theming, error types, `result_x` extension
- Server profile CRUD with `shared_preferences` persistence
- Platform utility for transport availability gating

### Phase 2 — Connection Layer

- `McpClient` provider with connect / disconnect lifecycle
- Connection state stream, server info card, health check screen
- Event log stream wired to `onLogging` + `onError` + `onConnect` / `onDisconnect`

### Phase 3 — Primitives

- Tools: list, raw JSON input field, execute, result view, progress + cancel
- Resources: list, read, subscribe, content viewer (text / binary)
- Prompts: list, raw JSON argument input, message sequence view

### Phase 4 — Polish

- Dark / light theme toggle
- Log export (plain text)
- Search / filter across primitives lists
- Error boundary widgets with retry actions
- Onboarding screen with quick-start server presets (e.g. `@modelcontextprotocol/server-filesystem`)

### Phase 5 — Smart Forms

- JSON Schema form builder: dynamically generate typed input widgets (string, number, boolean, enum) from the tool/prompt schema, replacing the raw JSON input
- Inline schema viewer alongside the form

---

## Key Design Decisions

1. **Feature-first over layer-first**: Each feature is independently navigable and testable. Shared infrastructure lives in `core/` and `shared/`.

2. **`fpdart` + `mcp_client` Result bridge**: A single `ResultX` extension converts `mcp_client`'s `Result<T, E>` to `fpdart`'s `Either<McpFailure, T>`, keeping all downstream code in a uniform error-handling style.

3. **Raw JSON input first, smart forms later**: Tools and Prompts initially accept arguments via a validated JSON textarea (`JsonInputField`). This ships fast and handles any schema without special-casing. A dynamic JSON Schema form builder (Phase 5) will progressively enhance the UX once the core loop is proven.

4. **Platform-aware transport picker**: STDIO is conditionally compiled and hidden on web/iOS/Android using `kIsWeb` and `Platform` checks, preventing runtime errors when unsupported options are selected.

5. **Separation of `mcp_client` from UI**: The `Client` instance is never passed directly to a widget. All access goes through Riverpod providers, making it straightforward to mock in tests.
