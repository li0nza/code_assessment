import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  double controllerValue;
  AnimationStatus controllerStatus;
  final List<ui.Image> images;

  CurvePainter({
    required this.controllerValue,
    required this.controllerStatus,
    required this.images,
  });

  @override
  void paint(Canvas canvas, Size size) {
    int imageIndex = 0;
    var paint = Paint();

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;

    var startPoint = Offset(-100, (size.height / 2));
    var controlPoint1 = Offset(size.width / 4, size.height / 4);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 4);
    var endPoint = Offset(size.width + 50, (size.height / 2));

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, endPoint.dx, endPoint.dy);

    ui.PathMetrics pathMetrics = path.computeMetrics();
    for (ui.PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(0.0, pathMetric.length * controllerValue);
      try {
        var metric = extractPath.computeMetrics().first;
        final offset = metric.getTangentForOffset(metric.length)!.position;
        canvas.save();

        canvas.translate(offset.dx, offset.dy);

        // change index to switch between images
        if (controllerStatus == AnimationStatus.reverse) {
          imageIndex = 0;
        } else {
          imageIndex = 1;
        }
        canvas.translate(-offset.dx, -offset.dy);

        paintImage(
          canvas: canvas,
          rect: (Offset(offset.dx, offset.dy) & const Size(38.0, 38.0)),
          image: images[imageIndex],
          fit: BoxFit.scaleDown,
          flipHorizontally: false,
          filterQuality: FilterQuality.high,
        );
        canvas.restore();
      } catch (error, stacktrace) {
        debugPrint('Exception occured: $error stackTrace: $stacktrace');
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
