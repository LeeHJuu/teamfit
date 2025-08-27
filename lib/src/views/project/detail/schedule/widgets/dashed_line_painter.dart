import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey[400]!
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    const dashHeight = 12; // 점선 길이
    const dashSpace = 8; // 점선 간격
    double startY = 0;

    // 전체 높이에 걸쳐 점선 그리기
    while (startY < size.height) {
      double endY = (startY + dashHeight).clamp(0, size.height);
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, endY),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
