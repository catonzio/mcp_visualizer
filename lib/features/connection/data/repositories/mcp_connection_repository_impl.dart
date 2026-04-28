import 'package:fpdart/fpdart.dart';
import 'package:mcp_client/mcp_client.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/core/utils/platform_utils.dart';
import 'package:mcp_visualizer/features/connection/domain/repositories/mcp_connection_repository.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';

class McpConnectionRepositoryImpl implements McpConnectionRepository {
  @override
  TaskEither<McpFailure, Client> connect(
    ServerProfile profile, {
    String? authToken,
  }) {
    return TaskEither.tryCatch(
      () async {
        final config = McpClient.simpleConfig(
          name: 'MCP Visualizer',
          version: '1.0.0',
          enableDebugLogging: true,
        );

        final transportConfig = _buildTransportConfig(profile, authToken);

        final result = await McpClient.createAndConnect(
          config: config,
          transportConfig: transportConfig,
        );

        return result.fold((client) => client, (error) => throw error);
      },
      (error, _) {
        final msg = error.toString();
        if (msg.toLowerCase().contains('network') ||
            msg.toLowerCase().contains('socket') ||
            msg.toLowerCase().contains('connection refused')) {
          return McpFailure.network(message: msg, cause: error);
        }
        if (error is Exception && msg.toLowerCase().contains('transport')) {
          return McpFailure.transport(message: msg, cause: error);
        }
        return McpFailure.unknown(message: msg, cause: error);
      },
    );
  }

  @override
  TaskEither<McpFailure, Unit> disconnect(Client client) {
    return TaskEither.tryCatch(() async {
      client.disconnect();
      return unit;
    }, (e, _) => McpFailure.unknown(message: e.toString(), cause: e));
  }

  TransportConfig _buildTransportConfig(
    ServerProfile profile,
    String? authToken,
  ) {
    return switch (profile.transportType) {
      TransportType.stdio => TransportConfig.stdio(
        command: profile.command!,
        arguments: profile.args,
      ),
      TransportType.sse => TransportConfig.sse(
        serverUrl: profile.url!,
        headers: profile.headers,
        bearerToken: authToken,
      ),
      TransportType.streamableHttp => TransportConfig.streamableHttp(
        baseUrl: profile.url!,
        headers: {
          ...profile.headers,
          if (authToken != null) 'Authorization': 'Bearer $authToken',
        },
      ),
    };
  }
}
