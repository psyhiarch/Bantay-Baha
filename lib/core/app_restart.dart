import 'package:flutter/material.dart';

class AppRestart extends StatefulWidget {
  const AppRestart({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    final state = context.findAncestorStateOfType<_AppRestartState>();
    if (state == null) {
      throw StateError(
        'AppRestart must be an ancestor of the calling context.',
      );
    }
    state.restartApp();
  }

  @override
  State<AppRestart> createState() => _AppRestartState();
}

class _AppRestartState extends State<AppRestart> {
  int _restartKey = 0;

  void restartApp() {
    setState(() => _restartKey++);
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: ValueKey(_restartKey), child: widget.child);
  }
}
