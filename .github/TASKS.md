# MCP Visualizer — Task Tracker

> Status legend: `[ ]` not started · `[~]` in progress · `[x]` done

---

## Phase 1 — Foundation

### 1.1 Project Scaffolding

- [x] Add all dependencies to `pubspec.yaml` (`flutter_riverpod`, `riverpod_annotation`, `freezed`, `json_serializable`, `fpdart`, `go_router`, `shared_preferences`, `flutter_secure_storage`, `build_runner`, `mcp_client`) using `flutter pub add` and `flutter pub add --dev`
- [x] Configure `analysis_options.yaml` (lint rules, exclude generated files)
- [x] Create `lib/app.dart` with `MaterialApp.router` wired to GoRouter
- [x] Define initial routes in GoRouter: `/` → server list, `/servers/add`, `/servers/:id/edit`, `/servers/:id/connect`

### 1.2 Theme

- [x] Create `lib/core/theme/app_theme.dart` with Material 3 `ThemeData` (light + dark)
- [x] Add `ColorScheme` tokens suited to a developer tool (neutral palette, monospace text styles)
- [x] Wire theme to `MaterialApp.router` in `app.dart`

### 1.3 Error Types

- [x] Create `lib/core/errors/mcp_failure.dart` as a Freezed sealed class with variants: `network`, `transport`, `protocol`, `serialization`, `unknown`
- [x] Run `build_runner` to generate `mcp_failure.freezed.dart`

### 1.4 `ResultX` Extension

- [x] Create `lib/core/extensions/result_x.dart` with an extension method that converts `mcp_client`'s `Result<T, E>` to `Either<McpFailure, T>`
- [x] Write unit test in `test/core/extensions/result_x_test.dart` covering success, typed failure, and unknown failure cases

### 1.5 Platform Utilities

- [x] Create `lib/core/utils/platform_utils.dart` with a `supportsTransport(TransportType)` function using `kIsWeb` and `Platform` checks
- [x] Cover STDIO (desktop only), SSE (all), StreamableHTTP (all) cases

### 1.6 `JsonInputField` Widget

- [x] Create `lib/core/utils/json_input_field.dart`: a `TextField`/`TextFormField` that validates JSON on-the-fly, shows a parse-error hint, and exposes the parsed `Map<String, dynamic>` via callback

### 1.7 Shared Widgets

- [x] Create `lib/shared/widgets/empty_state.dart` (icon + message + optional CTA button)
- [x] Create `lib/shared/widgets/error_view.dart` (icon + message + retry button)
- [x] Create `lib/shared/widgets/copy_button.dart` (icon button that copies text to clipboard with a toast/snackbar confirmation)

---

## Phase 2 — Connection Layer

### 2.1 Server Profile Models

- [x] Create `lib/features/servers/domain/models/server_profile.dart` as a Freezed model with fields: `id`, `name`, `transportType`, `command` (STDIO), `args` (STDIO), `url` (SSE/HTTP), `headers` (HTTP), `authTokenKey` (reference to secure storage key)
- [x] Add `toJson` / `fromJson` via `json_serializable`
- [x] Run `build_runner` to generate `.freezed.dart` and `.g.dart`

### 2.2 Server Profile Data Layer

- [x] Define abstract `ServerProfileRepository` interface in `lib/features/servers/domain/repositories/server_profile_repository.dart` (CRUD methods returning `TaskEither<McpFailure, T>`)
- [x] Implement `ServerProfileLocalDatasource` in `lib/features/servers/data/datasources/server_profile_local_datasource.dart` using `shared_preferences` (serialize profiles as JSON list)
- [x] Implement `ServerProfileRepositoryImpl` in `lib/features/servers/data/repositories/server_profile_repository_impl.dart`; store auth tokens via `flutter_secure_storage` using `profile.id` as key

### 2.3 Server Profile Providers

- [x] Create `lib/features/servers/presentation/providers/server_profile_providers.dart`:
  - `serverProfileRepositoryProvider` (Provider)
  - `serverProfileListProvider` (FutureProvider, reads all profiles)
  - `serverProfileNotifierProvider` (StateNotifier or AsyncNotifier for CRUD mutations)

### 2.4 Server List Screen

- [x] Create `lib/features/servers/presentation/screens/server_list_screen.dart`:
  - `ListView` of `ServerProfileCard` widgets
  - FAB to navigate to add form
  - Empty state when no profiles saved
  - Swipe-to-delete or long-press context menu (edit / delete)

### 2.5 Server Profile Card Widget

- [x] Create `lib/features/servers/presentation/widgets/server_profile_card.dart`:
  - Display name, transport type badge, last-connected timestamp
  - Connect button that triggers connection flow
  - Edit / delete actions

### 2.6 Server Form Screen

- [x] Create `lib/features/servers/presentation/screens/server_form_screen.dart`:
  - Name field
  - Transport type selector (radio/segmented; hides STDIO on unsupported platforms via `platform_utils`)
  - `TransportConfigFields` sub-widget swapped in based on selected transport
  - Save / cancel actions; form validation before save

### 2.7 Transport Config Fields Widget

- [x] Create `lib/features/servers/presentation/widgets/transport_config_fields.dart`:
  - STDIO sub-form: command field + args list (add/remove chips)
  - SSE sub-form: URL field
  - StreamableHTTP sub-form: URL field + headers key-value pairs + auth token field (obscured)

### 2.8 Connection Domain Layer

- [x] Create `lib/features/connection/domain/models/connection_state.dart` as a Freezed sealed class: `disconnected` | `connecting` | `connected(ServerInfo)` | `error(McpFailure)`
- [x] Create `lib/features/connection/domain/models/server_info.dart` as a Freezed model: `name`, `version`, `protocolVersion`
- [x] Define abstract `McpConnectionRepository` interface

### 2.9 Connection Repository Implementation

- [x] Implement `McpConnectionRepositoryImpl` in `lib/features/connection/data/repositories/`:
  - `connect(ServerProfile)` → builds the appropriate `mcp_client` transport, calls `Client.connect()`, returns `TaskEither<McpFailure, Client>`
  - `disconnect(Client)` → calls `client.disconnect()`, wraps in `TaskEither`

### 2.10 Connection Providers

- [x] Create `lib/features/connection/presentation/providers/mcp_client_provider.dart`:
  - `McpClientNotifier` (StateNotifier or AsyncNotifier) holding the nullable `Client` instance
  - Exposes `connect(ServerProfile)` and `disconnect()` actions
  - `connectionStateProvider` and `mcpClientProvider` convenience providers

### 2.11 Connection Status Badge Widget

- [x] Create `lib/features/connection/presentation/widgets/connection_status_badge.dart`: animated dot + label reflecting the current `McpConnectionState`

### 2.12 Server Info Card Widget

- [x] Create `lib/features/connection/presentation/widgets/server_info_card.dart`: displays server `name`, `version`, `protocolVersion` from `ServerInfo`

### 2.13 Event Log — Core Wiring

- [x] Create `lib/features/event_log/domain/models/log_entry.dart` as a Freezed model: `timestamp`, `level` (enum: debug/info/warning/error), `category` (enum: connection/tools/resources/prompts/raw), `message`
- [x] Create `lib/features/event_log/presentation/providers/event_log_provider.dart`:
  - `NotifierProvider` that accumulates `LogEntry` objects
  - Subscribed to `client.onLogging`, connection state changes from `mcp_client`

---

## Phase 3 — Primitives

### 3.1 Tools — Domain Models

- [x] Create `lib/features/tools/domain/models/tool_model.dart`: Freezed wrapper around `mcp_client`'s `Tool` (name, description, inputSchema)
- [x] Create `lib/features/tools/domain/models/tool_result_model.dart`: Freezed union — `text(String)` | `image(String? data, String? url, String mimeType)` | `error(String)`

### 3.2 Tools — Providers

- [x] Create `lib/features/tools/presentation/providers/tools_providers.dart`:
  - `toolListProvider`: `FutureProvider` that calls `client.listTools()` and maps to `List<ToolModel>`
  - `toolExecutionNotifierProvider`: family `Notifier` with `execute(Map<String, dynamic> args)` action and `cancel()` support; exposes `ToolExecutionState`

### 3.3 Tools — Screens & Widgets

- [x] Create `lib/features/tools/presentation/screens/tools_screen.dart`: searchable `ListView` of `ToolListTile`; empty/error states
- [x] Create `lib/features/tools/presentation/widgets/tool_list_tile.dart`: name, truncated description, chevron
- [x] Create `lib/features/tools/presentation/screens/tool_detail_screen.dart`:
  - Tool name + description header
  - Collapsible raw schema viewer
  - `JsonInputField` for arguments
  - Execute button with `CircularProgressIndicator` while running; cancel support
  - `ToolResultView` below
- [x] Create `lib/features/tools/presentation/widgets/tool_result_view.dart`: renders text, image, or error result; `CopyButton` for text results

### 3.4 Resources — Domain Models

- [x] Create `lib/features/resources/domain/models/resource_model.dart`: Freezed model wrapping `mcp_client`'s `Resource` (uri, name, description, mimeType)

### 3.5 Resources — Providers

- [x] Create `lib/features/resources/presentation/providers/resources_providers.dart`:
  - `resourceListProvider`: `FutureProvider` for `client.listResources()`
  - `resourceContentProvider(String uri)`: `FutureProvider.family` for `client.readResource(uri)`
  - `resourceUpdateProvider`: `NotifierProvider` that accumulates updated URIs via `client.onResourceUpdated`; invalidates content cache on update

### 3.6 Resources — Screens & Widgets

- [x] Create `lib/features/resources/presentation/screens/resources_screen.dart`: list with real-time highlight on updated resources
- [x] Create `lib/features/resources/presentation/screens/resource_detail_screen.dart`: shows URI, mimeType, and content via `ResourceContentViewer`
- [x] Create `lib/features/resources/presentation/widgets/resource_content_viewer.dart`: renders text in a scrollable monospace view; for binary content shows mimeType + size metadata + copy button

### 3.7 Prompts — Domain Models

- [x] Create `lib/features/prompts/domain/models/prompt_model.dart`: Freezed models — `PromptModel` (name, description, arguments) and `PromptArgumentModel` (name, description, required, defaultValue)

### 3.8 Prompts — Providers

- [x] Create `lib/features/prompts/presentation/providers/prompts_providers.dart`:
  - `promptListProvider`: `FutureProvider` for `client.listPrompts()`
  - `promptGetNotifierProvider`: family `Notifier` with `get(Map<String, dynamic> args)` action; exposes `PromptExecutionState` with messages list

### 3.9 Prompts — Screens & Widgets

- [x] Create `lib/features/prompts/presentation/screens/prompts_screen.dart`: searchable list
- [x] Create `lib/features/prompts/presentation/screens/prompt_detail_screen.dart`:
  - Prompt name + description
  - Arguments list with required/optional indicators
  - `JsonInputField` for arguments
  - "Get Prompt" button with loading state
  - `PromptMessageView` rendered below
- [x] Create `lib/features/prompts/presentation/widgets/prompt_message_view.dart`: chat-bubble style renderer alternating `user` / `assistant` roles; supports text and image content types

### 3.10 Event Log — Screens & Widgets

- [x] Create `lib/features/event_log/presentation/screens/event_log_screen.dart`:
  - Auto-scrolling `ListView` of `LogEntryTile` (newest first)
  - Toolbar with filter bar and "Clear" + "Export" (copy to clipboard) actions
- [x] Create `lib/features/event_log/presentation/widgets/log_entry_tile.dart`: timestamp, level chip, category tag, message (expandable for long entries)
- [x] Create `lib/features/event_log/presentation/widgets/log_filter_bar.dart`: multi-select chips for level and category filters

### 3.11 Navigation — Full Route Map

- [x] Add routes for all new screens in GoRouter using `StatefulShellRoute.indexedStack`: tools, tool detail, resources, resource detail, prompts, prompt detail, event log
- [x] Implement adaptive navigation: `NavigationBar` on mobile/web, `NavigationRail` on desktop (macOS/Linux/Windows)

---

## Phase 4 — Navigation UX Refactor

> **Goal:** The home screen shows only saved server cards. Clicking "Connect" on a card triggers a connection flow with a loader; once connected, tapping the card navigates to a dedicated server workspace screen that hosts the left `NavigationRail` / `NavigationBar` with Tools, Resources, Prompts, and Event Log sections. The shared primitives navigation that currently lives at the app root is moved inside this per-server workspace.

### 4.1 Server Workspace Route

- [x] Add a new GoRouter route `/servers/:id` (the "server workspace") that wraps the `StatefulShellRoute.indexedStack` currently used for the primitive tabs (Tools, Resources, Prompts, Event Log)
- [x] The workspace route requires an active connection for the given `id`; if no connection exists, redirect to `/` (server list)
- [x] Remove the top-level `StatefulShellRoute` so the primitive tabs are no longer reachable from the app root

### 4.2 Server Workspace Screen

- [x] Create `lib/features/servers/presentation/screens/server_workspace_screen.dart`:
  - Hosts the adaptive `NavigationRail` (desktop) / `NavigationBar` (mobile/web) with tabs: Tools, Resources, Prompts, Event Log
  - App bar shows the server name, a `ConnectionStatusBadge`, and a "Disconnect" action that navigates back to `/`
  - Renders the currently selected tab's content in the main area

### 4.3 Connect Flow on Server List Screen

- [x] Update `ServerProfileCard` "Connect" button behaviour:
  - Tapping "Connect" calls `McpClientNotifier.connect(profile)` and shows an inline `CircularProgressIndicator` on the card (replacing the button) while `connectionState` is `connecting`
  - On success (`connected`), navigate to `/servers/:id`
  - On error, display an inline error chip/snackbar on the card and restore the "Connect" button
- [x] Remove any previous "connect navigates to a loader page" routing logic

### 4.4 Home Screen Cleanup

- [x] `ServerListScreen` (the home `/` route) must no longer render the `NavigationRail`/`NavigationBar` or any primitive tab
- [x] The home app bar should show only the app title and the FAB for adding a new server profile; remove any connection-state-dependent widgets from the home app bar

### 4.5 Multi-Connection Management

- [x] Replace the single `mcpClientProvider` with a map-based `mcpClientMapProvider` (family keyed by `ServerProfile.id`) so multiple servers can be connected simultaneously
- [x] Each server's workspace route reads from `mcpClientMapProvider(id)`; primitive providers (`toolListProvider`, `resourceListProvider`, `promptListProvider`, `eventLogProvider`) become `.family` providers keyed by `id`
- [x] On the `ServerListScreen`, connected servers show a "Open" button (navigates to workspace) instead of "Connect"; a separate "Disconnect" action is available per-card (e.g. long-press or context menu)
- [x] Explicit disconnect (via the workspace app bar or card action) calls `disconnect()` on that specific client and removes it from the map

---

## Phase 5 — Polish

### 5.1 Theme Toggle

- [ ] Add a `themeModeProvider` (StateProvider) persisted via `shared_preferences`
- [ ] Add toggle button in app bar or settings drawer

### 5.2 Log Export

- [ ] Implement "Export" action in Event Log screen: serialize all current `LogEntry` items to plain text and share via platform share sheet (`Share.share` or file save dialog on desktop)

### 5.3 Search & Filter for Primitives

- [ ] Add a search `TextField` at the top of Tools, Resources, and Prompts list screens
- [ ] Filter provider results client-side by name/description match

### 5.4 Error Boundary Widgets

- [ ] Wrap each screen's body in a top-level `ErrorView` fallback that catches `AsyncError` from providers and shows a retry button
- [ ] Wire retry to re-fetch the relevant provider (using `ref.invalidate`)

### 5.5 Automatic Reconnection

- [ ] Add reconnection logic to `McpClientNotifier`: on transport error, attempt reconnect with exponential backoff (max 3 retries, configurable)
- [ ] Expose reconnect attempt count in `McpConnectionState.error` variant

### 5.6 Onboarding / Quick-Start Presets

- [ ] Create an onboarding screen shown on first launch (detected via `shared_preferences` flag)
- [ ] Offer quick-start preset server profiles (e.g. `@modelcontextprotocol/server-filesystem`, `@modelcontextprotocol/server-everything`) that pre-fill the form

### 5.7 Accessibility & UX

- [ ] Ensure all interactive widgets have semantic labels
- [ ] Test keyboard navigation on desktop (Tab order, Enter to activate)
- [ ] Add tooltip to icon-only buttons

---

## Phase 6 — Smart Forms

### 6.1 JSON Schema Parser

- [ ] Create `lib/core/schema/json_schema_parser.dart` that parses a `Map<String, dynamic>` JSON Schema object into a typed tree of `SchemaNode` (Freezed sealed class: `string`, `number`, `boolean`, `enumeration`, `object`, `array`)

### 6.2 Schema Form Builder

- [ ] Create `lib/core/schema/schema_form_builder.dart`: a widget that takes a `SchemaNode` root and recursively renders typed `FormField` widgets (TextFormField for string/number, Switch for boolean, DropdownButtonFormField for enum, recursive group for object)
- [ ] Wire validation rules from schema (`required`, `minLength`, `minimum`, `maximum`, `pattern`) into form field validators

### 6.3 Inline Schema Viewer

- [ ] Create `lib/core/schema/schema_viewer.dart`: collapsible tree widget that renders the raw JSON Schema with syntax highlighting alongside the smart form

### 6.4 Integration with Tool & Prompt Detail Screens

- [ ] Replace `JsonInputField` in `tool_detail_screen.dart` with `SchemaFormBuilder` when a valid `inputSchema` is available; fall back to `JsonInputField` for unsupported or missing schemas
- [ ] Replace `JsonInputField` in `prompt_detail_screen.dart` similarly for prompt arguments

---

## Cross-Cutting

### Testing

- [ ] Unit tests for `ServerProfileRepositoryImpl` (mock `shared_preferences` + `flutter_secure_storage`)
- [ ] Unit tests for `McpConnectionRepositoryImpl` (mock `mcp_client` transport)
- [ ] Unit tests for `ToolsProviders` (mock `Client.listTools` and `Client.callTool`)
- [ ] Widget tests for `JsonInputField` (valid JSON, invalid JSON, empty)
- [ ] Widget tests for `ServerFormScreen` (validation, save flow)
- [ ] Integration test: connect to a local mock MCP server, list tools, execute one

### CI / CD

- [ ] Add `flutter analyze` step to GitHub Actions workflow
- [ ] Add `flutter test` step
- [ ] Add `dart run build_runner build --delete-conflicting-outputs` step before tests to ensure generated files are up to date
- [ ] (Optional) Add macOS + Linux desktop build artifacts on tag push
