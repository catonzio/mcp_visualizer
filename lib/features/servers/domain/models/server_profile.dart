import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mcp_visualizer/core/utils/platform_utils.dart';

part 'server_profile.freezed.dart';
part 'server_profile.g.dart';

@freezed
abstract class ServerProfile with _$ServerProfile {
  const factory ServerProfile({
    required String id,
    required String name,
    required TransportType transportType,
    // STDIO fields
    String? command,
    @Default([]) List<String> args,
    // SSE / StreamableHTTP fields
    String? url,
    // HTTP extra headers (non-sensitive keys only; values stored in secure storage)
    @Default({}) Map<String, String> headers,
    // Key used to retrieve the auth token from flutter_secure_storage
    String? authTokenKey,
    // Metadata
    DateTime? lastConnectedAt,
  }) = _ServerProfile;

  factory ServerProfile.fromJson(Map<String, dynamic> json) =>
      _$ServerProfileFromJson(json);
}
