import 'package:freezed_annotation/freezed_annotation.dart';

part 'tool_result_model.freezed.dart';

/// Typed result from a tool execution.
///
/// - [text] — plain text response
/// - [image] — base64-encoded image with a MIME type (or a URL)
/// - [error] — error message returned by the server
@freezed
sealed class ToolResultModel with _$ToolResultModel {
  const factory ToolResultModel.text({required String value}) = ToolResultText;

  const factory ToolResultModel.image({
    String? data, // base64
    String? url,
    required String mimeType,
  }) = ToolResultImage;

  const factory ToolResultModel.error({required String message}) =
      ToolResultError;
}
