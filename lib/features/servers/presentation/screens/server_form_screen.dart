import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'package:mcp_visualizer/core/utils/platform_utils.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';
import 'package:mcp_visualizer/features/servers/presentation/providers/server_profile_providers.dart';
import 'package:mcp_visualizer/features/servers/presentation/widgets/transport_config_fields.dart';

const _uuid = Uuid();

class ServerFormScreen extends ConsumerStatefulWidget {
  const ServerFormScreen({super.key, this.profileId});

  /// When non-null, this is an edit form for the given profile ID.
  final String? profileId;

  @override
  ConsumerState<ServerFormScreen> createState() => _ServerFormScreenState();
}

class _ServerFormScreenState extends ConsumerState<ServerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _commandCtrl;
  late final TextEditingController _argsCtrl;
  late final TextEditingController _urlCtrl;
  late final TextEditingController _authTokenCtrl;

  late TransportType _transportType;
  final List<MapEntry<String, String>> _headers = [];
  bool _saving = false;

  bool get _isEditing => widget.profileId != null;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _commandCtrl = TextEditingController();
    _argsCtrl = TextEditingController();
    _urlCtrl = TextEditingController();
    _authTokenCtrl = TextEditingController();
    _transportType = PlatformUtils.supportsTransport(TransportType.stdio)
        ? TransportType.stdio
        : TransportType.sse;

    if (_isEditing) {
      _loadExisting();
    }
  }

  void _loadExisting() {
    final profiles =
        ref.read(serverProfileNotifierProvider).asData?.value ?? [];
    final profile = profiles.where((p) => p.id == widget.profileId).firstOrNull;
    if (profile == null) return;

    _nameCtrl.text = profile.name;
    _transportType = profile.transportType;
    _commandCtrl.text = profile.command ?? '';
    _argsCtrl.text = profile.args.join(' ');
    _urlCtrl.text = profile.url ?? '';
    _headers
      ..clear()
      ..addAll(profile.headers.entries.toList());
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _commandCtrl.dispose();
    _argsCtrl.dispose();
    _urlCtrl.dispose();
    _authTokenCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _saving = true);

    final profile = ServerProfile(
      id: widget.profileId ?? _uuid.v4(),
      name: _nameCtrl.text.trim(),
      transportType: _transportType,
      command: _transportType == TransportType.stdio
          ? _commandCtrl.text.trim()
          : null,
      args: _transportType == TransportType.stdio
          ? _argsCtrl.text
                .trim()
                .split(RegExp(r'\s+'))
                .where((s) => s.isNotEmpty)
                .toList()
          : [],
      url: _transportType != TransportType.stdio ? _urlCtrl.text.trim() : null,
      headers: Map.fromEntries(_headers),
    );

    await ref.read(serverProfileNotifierProvider.notifier).save(profile);

    // Store auth token in secure storage if provided
    final token = _authTokenCtrl.text.trim();
    if (token.isNotEmpty) {
      final repo = ref.read(serverProfileRepositoryProvider);
      await (repo as dynamic).saveAuthToken(profile.id, token);
    }

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final availableTransports = TransportType.values
        .where((t) => PlatformUtils.supportsTransport(t))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Server' : 'Add Server'),
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(onPressed: _save, child: const Text('Save')),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'My MCP Server',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 20),
            Text('Transport', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            SegmentedButton<TransportType>(
              segments: availableTransports
                  .map(
                    (t) => ButtonSegment(
                      value: t,
                      label: Text(_transportLabel(t)),
                    ),
                  )
                  .toList(),
              selected: {_transportType},
              onSelectionChanged: (set) =>
                  setState(() => _transportType = set.first),
            ),
            const SizedBox(height: 20),
            TransportConfigFields(
              transportType: _transportType,
              commandController: _commandCtrl,
              argsController: _argsCtrl,
              urlController: _urlCtrl,
              authTokenController: _authTokenCtrl,
              headers: _headers,
              onHeaderAdd: _addHeader,
              onHeaderRemove: (i) => setState(() => _headers.removeAt(i)),
            ),
          ],
        ),
      ),
    );
  }

  String _transportLabel(TransportType t) => switch (t) {
    TransportType.stdio => 'STDIO',
    TransportType.sse => 'SSE',
    TransportType.streamableHttp => 'HTTP',
  };

  Future<void> _addHeader() async {
    final keyCtrl = TextEditingController();
    final valCtrl = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Header'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyCtrl,
              decoration: const InputDecoration(labelText: 'Key'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: valCtrl,
              decoration: const InputDecoration(labelText: 'Value'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    keyCtrl.dispose();
    valCtrl.dispose();
    if (result == true && keyCtrl.text.isNotEmpty && valCtrl.text.isNotEmpty) {
      setState(
        () => _headers.add(MapEntry(keyCtrl.text.trim(), valCtrl.text.trim())),
      );
    }
  }
}
