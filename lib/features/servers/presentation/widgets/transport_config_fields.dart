import 'package:flutter/material.dart';

import 'package:mcp_visualizer/core/utils/platform_utils.dart';

/// Swappable sub-form rendered inside the server form screen.
class TransportConfigFields extends StatelessWidget {
  const TransportConfigFields({
    super.key,
    required this.transportType,
    required this.commandController,
    required this.argsController,
    required this.urlController,
    required this.authTokenController,
    required this.headers,
    required this.onHeaderAdd,
    required this.onHeaderRemove,
  });

  final TransportType transportType;
  final TextEditingController commandController;
  final TextEditingController argsController;
  final TextEditingController urlController;
  final TextEditingController authTokenController;
  final List<MapEntry<String, String>> headers;
  final VoidCallback onHeaderAdd;
  final void Function(int index) onHeaderRemove;

  @override
  Widget build(BuildContext context) {
    return switch (transportType) {
      TransportType.stdio => _StdioFields(
        commandController: commandController,
        argsController: argsController,
      ),
      TransportType.sse => _UrlField(
        controller: urlController,
        label: 'SSE URL',
        hint: 'http://localhost:8080/sse',
      ),
      TransportType.streamableHttp => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UrlField(
            controller: urlController,
            label: 'Base URL',
            hint: 'https://api.example.com',
          ),
          const SizedBox(height: 12),
          _AuthTokenField(controller: authTokenController),
          const SizedBox(height: 12),
          _HeadersList(
            headers: headers,
            onAdd: onHeaderAdd,
            onRemove: onHeaderRemove,
          ),
        ],
      ),
    };
  }
}

class _StdioFields extends StatelessWidget {
  const _StdioFields({
    required this.commandController,
    required this.argsController,
  });

  final TextEditingController commandController;
  final TextEditingController argsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: commandController,
          decoration: const InputDecoration(
            labelText: 'Command',
            hintText: 'npx',
          ),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Command is required' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: argsController,
          decoration: const InputDecoration(
            labelText: 'Arguments (space-separated)',
            hintText: '-y @modelcontextprotocol/server-filesystem /tmp',
          ),
        ),
      ],
    );
  }
}

class _UrlField extends StatelessWidget {
  const _UrlField({
    required this.controller,
    required this.label,
    required this.hint,
  });

  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, hintText: hint),
      keyboardType: TextInputType.url,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? '$label is required' : null,
    );
  }
}

class _AuthTokenField extends StatefulWidget {
  const _AuthTokenField({required this.controller});

  final TextEditingController controller;

  @override
  State<_AuthTokenField> createState() => _AuthTokenFieldState();
}

class _AuthTokenFieldState extends State<_AuthTokenField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscured,
      decoration: InputDecoration(
        labelText: 'Auth Token (optional)',
        hintText: 'Bearer token or API key',
        suffixIcon: IconButton(
          icon: Icon(
            _obscured
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () => setState(() => _obscured = !_obscured),
        ),
      ),
    );
  }
}

class _HeadersList extends StatelessWidget {
  const _HeadersList({
    required this.headers,
    required this.onAdd,
    required this.onRemove,
  });

  final List<MapEntry<String, String>> headers;
  final VoidCallback onAdd;
  final void Function(int) onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Headers', style: Theme.of(context).textTheme.labelLarge),
            const Spacer(),
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        ...headers.asMap().entries.map(
          (entry) => Row(
            children: [
              Expanded(
                child: Text(
                  '${entry.value.key}: ${entry.value.value}',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: () => onRemove(entry.key),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
