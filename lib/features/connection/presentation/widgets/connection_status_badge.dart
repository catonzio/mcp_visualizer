import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mcp_visualizer/features/connection/domain/models/connection_state.dart';
import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';

class ConnectionStatusBadge extends ConsumerWidget {
  const ConnectionStatusBadge({super.key, required this.serverId});

  final String serverId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(connectionStateProvider(serverId));

    final (color, label, animate) = switch (connectionState) {
      Disconnected() => (Colors.grey, 'Disconnected', false),
      Connecting() => (Colors.amber, 'Connecting…', true),
      Connected() => (Colors.green, 'Connected', false),
      ConnectionError() => (Colors.red, 'Error', false),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Dot(color: color, animate: animate),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _Dot extends StatefulWidget {
  const _Dot({required this.color, required this.animate});

  final Color color;
  final bool animate;

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacity = Tween<double>(
      begin: 0.3,
      end: 1,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    if (widget.animate) _ctrl.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(_Dot old) {
    super.didUpdateWidget(old);
    if (widget.animate && !_ctrl.isAnimating) {
      _ctrl.repeat(reverse: true);
    } else if (!widget.animate && _ctrl.isAnimating) {
      _ctrl.stop();
      _ctrl.value = 1;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}
