import 'dart:io';

import 'package:flutter/foundation.dart';

enum TransportType { stdio, sse, streamableHttp }

abstract final class PlatformUtils {
  /// Returns true if [transport] is available on the current platform.
  ///
  /// STDIO is native-desktop only (macOS, Linux, Windows).
  /// SSE and StreamableHTTP are available everywhere.
  static bool supportsTransport(TransportType transport) {
    return switch (transport) {
      TransportType.stdio => _supportsStdio,
      TransportType.sse => true,
      TransportType.streamableHttp => true,
    };
  }

  static bool get _supportsStdio {
    if (kIsWeb) return false;
    return Platform.isMacOS || Platform.isLinux || Platform.isWindows;
  }

  /// True when running on a desktop OS (macOS, Linux, Windows).
  static bool get isDesktop {
    if (kIsWeb) return false;
    return Platform.isMacOS || Platform.isLinux || Platform.isWindows;
  }
}
