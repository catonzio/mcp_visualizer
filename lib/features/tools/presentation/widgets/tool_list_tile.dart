import 'package:flutter/material.dart';

import 'package:mcp_visualizer/features/tools/domain/models/tool_model.dart';

class ToolListTile extends StatelessWidget {
  const ToolListTile({super.key, required this.tool, required this.onTap});

  final ToolModel tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
        tool.name,
        style: theme.textTheme.titleSmall?.copyWith(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: tool.description.isNotEmpty
          ? Text(
              tool.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: null,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
