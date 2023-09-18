import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class BubbleBackground extends StatelessWidget {
  const BubbleBackground({Key? key, required this.colors, required this.child})
      : super(key: key);

  final List<Color> colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
          colors: colors,
          context: context,
          scrollable: Scrollable.of(context)!),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter(
      {required this.colors, required this.context, required this.scrollable});
  final ScrollableState scrollable;
  final BuildContext context;
  final List<Color> colors;
  @override
  void paint(Canvas canvas, Size size) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final scrollableRect = Offset.zero & scrollableBox.size;
    final bubbleBox = context.findRenderObject() as RenderBox;
    final origin = bubbleBox.localToGlobal(Offset.zero);

    final paint = Paint()
      ..shader = ui.Gradient.linear(
        scrollableRect.topCenter,
        scrollableRect.bottomCenter,
        colors,
        [0.0, 1.0],
        TileMode.clamp,
        Matrix4.translationValues(-origin.dx, -origin.dy, 0.0).storage,
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate.colors != colors ||
        oldDelegate.context != context ||
        oldDelegate.scrollable != scrollable;
  }
}
