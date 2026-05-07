import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mcp_visualizer/shared/widgets/copy_button.dart';

class ResourceContentViewer extends StatelessWidget {
  const ResourceContentViewer({
    super.key,
    required this.uri,
    this.mimeType,
    this.text,
    this.blob,
  });

  final String uri;
  final String? mimeType;
  final String? text;
  final String? blob; // base64

  @override
  Widget build(BuildContext context) {
    if (text != null) {
      return _TextViewer(text: text!, mimeType: mimeType);
    }
    if (blob != null) {
      return _BinaryViewer(uri: uri, mimeType: mimeType, blob: blob!);
    }
    return const _EmptyViewer();
  }
}

class _TextViewer extends StatelessWidget {
  const _TextViewer({required this.text, this.mimeType});

  final String text;
  final String? mimeType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (mimeType != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Chip(
              label: Text(mimeType!, style: theme.textTheme.labelSmall),
              avatar: const Icon(Icons.description_outlined, size: 14),
              visualDensity: VisualDensity.compact,
            ),
          ),
        Card(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: double.infinity,
                  child: SelectableText(
                    text,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              Positioned(top: 4, right: 4, child: CopyButton(text: text)),
            ],
          ),
        ),
      ],
    );
  }
}

class _BinaryViewer extends StatelessWidget {
  const _BinaryViewer({required this.uri, this.mimeType, required this.blob});

  final String uri;
  final String? mimeType;
  final String blob;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sizeBytes = (blob.length * 3 / 4).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.insert_drive_file_outlined,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(uri, style: theme.textTheme.bodySmall)),
              ],
            ),
            const SizedBox(height: 12),
            _InfoRow(
              label: 'MIME Type',
              value: mimeType ?? 'application/octet-stream',
            ),
            const SizedBox(height: 4),
            _InfoRow(label: 'Size', value: '~$sizeBytes bytes (base64)'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.copy),
              label: const Text('Copy base64'),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: blob));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied base64 to clipboard')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            '$label:',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Text(value, style: theme.textTheme.bodySmall)),
      ],
    );
  }
}

class _EmptyViewer extends StatelessWidget {
  const _EmptyViewer();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No content available.'));
  }
}
