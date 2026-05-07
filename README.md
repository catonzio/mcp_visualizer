# MCP Visualizer

A cross-platform Flutter app for inspecting and debugging [Model Context Protocol (MCP)](https://modelcontextprotocol.io) servers in real time.

## What it does

Connect to any MCP server and:

- **Browse** all exposed Tools, Resources, and Prompts in a structured UI
- **Execute** tools and prompts with a live JSON input form and view the results
- **Read** resources and subscribe to real-time updates
- **Monitor** a live event log of all protocol messages, errors, and notifications — filterable by level and category
- **Manage** saved server profiles (STDIO, SSE, StreamableHTTP) with one-tap connect/disconnect

## Supported transports

| Transport | macOS / Windows / Linux | iOS / Android | Web |
| --- | --- | --- | --- |
| STDIO | ✅ | ❌ | ❌ |
| SSE | ✅ | ✅ | ✅ |
| StreamableHTTP | ✅ | ✅ | ✅ |

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.11.5
- Dart SDK ≥ 3.11.5 (bundled with Flutter)

## Running the app

```bash
# Install dependencies
flutter pub get

# Run on your target platform (macOS desktop recommended for STDIO support)
flutter run -d macos
flutter run -d chrome
flutter run -d ios
flutter run -d android
```

## Running tests

```bash
flutter test
```
