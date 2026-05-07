import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:mcp_visualizer/features/tools/domain/models/tool_result_model.dart';
import 'package:mcp_visualizer/shared/widgets/copy_button.dart';

class ToolResultView extends StatelessWidget {
  const ToolResultView({super.key, required this.results});

  final List<ToolResultModel> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: results.map((r) => _ResultItem(result: r)).toList(),
    );
  }
}

class _ResultItem extends StatelessWidget {
  const _ResultItem({required this.result});

  final ToolResultModel result;

  @override
  Widget build(BuildContext context) {
    return switch (result) {
      ToolResultText(:final value) => _TextResult(text: value),
      ToolResultImage(:final data, :final url, :final mimeType) => _ImageResult(
        data: data,
        url: url,
        mimeType: mimeType,
      ),
      ToolResultError(:final message) => _ErrorResult(message: message),
    };
  }
}

class _TextResult extends StatelessWidget {
  const _TextResult({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.text_snippet_outlined,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Text',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                CopyButton(text: text),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              const JsonEncoder.withIndent('  ').convert(jsonDecode(text)),
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageResult extends StatelessWidget {
  const _ImageResult({this.data, this.url, required this.mimeType});

  final String? data;
  final String? url;
  final String mimeType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget imageWidget;
    if (url != null) {
      imageWidget = Image.network(url!, fit: BoxFit.contain);
    } else if (data != null) {
      try {
        imageWidget = Image.memory(base64Decode(data!), fit: BoxFit.contain);
      } catch (_) {
        imageWidget = Text(
          'Could not decode image data.',
          style: theme.textTheme.bodySmall,
        );
      }
    } else {
      imageWidget = Text(
        'No image data available.',
        style: theme.textTheme.bodySmall,
      );
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Image ($mimeType)',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageWidget,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorResult extends StatelessWidget {
  const _ErrorResult({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 16,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(width: 6),
                Text(
                  'Error',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                CopyButton(text: message),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
