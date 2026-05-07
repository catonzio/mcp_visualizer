import 'package:flutter/material.dart';
import 'package:mcp_client/mcp_client.dart'
    hide ServerInfo, Disconnected, Connecting, Connected, ConnectionError;

import 'package:mcp_visualizer/shared/widgets/copy_button.dart';

/// Renders a list of MCP [Message] objects in a chat-bubble style.
class PromptMessageView extends StatelessWidget {
  const PromptMessageView({super.key, required this.messages});

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const Center(child: Text('No messages returned.'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: messages.map((m) => _MessageBubble(message: m)).toList(),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.role == 'user';
    final bubbleColor = isUser
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.secondaryContainer;
    final labelColor = isUser
        ? theme.colorScheme.primary
        : theme.colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Role label
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              message.role.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: labelColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
          // Content
          _ContentView(content: message.content, bubbleColor: bubbleColor),
        ],
      ),
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({required this.content, required this.bubbleColor});

  final Content content;
  final Color bubbleColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (content is TextContent) {
      final text = (content as TextContent).text;
      return _Bubble(
        color: bubbleColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SelectableText(text, style: theme.textTheme.bodyMedium),
            ),
            CopyButton(text: text),
          ],
        ),
      );
    }

    if (content is ImageContent) {
      final img = content as ImageContent;
      return _Bubble(
        color: bubbleColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Image (${img.mimeType})',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (img.url != null) ...[
              const SizedBox(height: 8),
              Image.network(img.url!, fit: BoxFit.contain),
            ],
          ],
        ),
      );
    }

    return _Bubble(
      color: bubbleColor,
      child: Text(
        '[unsupported content type]',
        style: theme.textTheme.bodySmall,
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
