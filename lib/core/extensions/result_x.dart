import 'package:fpdart/fpdart.dart';
import 'package:mcp_client/mcp_client.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';

/// Converts an [mcp_client] [Result] to an [fpdart] [Either].
///
/// Success maps to [Right], failures map to [Left<McpFailure>].
extension Success<T, E extends Object> on Result<T, E> {
  Either<McpFailure, T> toEither() {
    return fold((value) => right(value), (error) {
      if (error is McpError) {
        return left(
          McpFailure.protocol(
            message: error.message,
            code: error.code,
            cause: error,
          ),
        );
      }
      return left(McpFailure.unknown(message: error.toString(), cause: error));
    });
  }
}
