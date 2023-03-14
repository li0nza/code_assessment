import 'dart:ui' as ui;

import 'package:code_assesment/presentation/widgets/dotted_curve_animation/curve_painter.dart';
import 'package:flutter/material.dart';

class EndOfDayAnimation extends StatefulWidget {
  final String message;
  final List<ui.Image> images;

  const EndOfDayAnimation({super.key, required this.message, required this.images});

  @override
  _EndOfDayAnimationState createState() => _EndOfDayAnimationState(message: message);
}

class _EndOfDayAnimationState extends State<EndOfDayAnimation> with SingleTickerProviderStateMixin {
  final String message;
  late AnimationController _controller;
  bool forwardAnimation = true;

  _EndOfDayAnimationState({required this.message});

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;

      return Dialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
        child: Container(
          width: maxWidth,
          height: maxHeight,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, snapshot) {
                return Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: CustomPaint(
                      painter: CurvePainter(
                        controllerValue: _controller.value,
                        controllerStatus: _controller.status,
                        images: widget.images,
                      ),
                      child: Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Center(
                            child: Text(
                              message,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
