import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
  final Widget child;

  const AnimatedDialog({super.key, required this.child});

  @override
  AnimatedDialogState createState() => AnimatedDialogState();
}

class AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  Future<void> closeDialog() async {
    await _controller.reverse();
    if (mounted) {
      Navigator.pop(getAppContext() ?? context);
    } else {
      Navigator.pop(getAppContext() ?? context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
