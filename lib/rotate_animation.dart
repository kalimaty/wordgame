import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RotateTheWidget extends StatefulWidget {
  RotateTheWidget(
      {required this.child, required this.onEnd, required this.needAnimate});
  final Widget child;
  final VoidCallback onEnd;
  bool needAnimate;
  @override
  State<RotateTheWidget> createState() => _RotateTheWidgetState();
}

class _RotateTheWidgetState extends State<RotateTheWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotation;
  late Animation<double> scale;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    rotation = Tween(begin: -pi, end: 0.0).animate(animationController);
    scale =
        CurveTween(curve: Curves.easeInOutCubic).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.needAnimate) {
      animationController.forward().then((value) {
        widget.onEnd();
      });
      // animationController.reverse();
      widget.needAnimate = false;
      setState(() {});
    }
    return AnimatedBuilder(
        animation: Listenable.merge([rotation, scale]),
        child: widget.child,
        builder: (context, child) {
          return ScaleTransition(
              scale: scale,
              child: Transform.rotate(angle: rotation.value, child: child!));
        });
  }
}
