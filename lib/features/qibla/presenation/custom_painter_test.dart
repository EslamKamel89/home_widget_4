import 'package:flutter/material.dart';

class CustomPainterTest extends StatefulWidget {
  const CustomPainterTest({super.key});

  @override
  State<CustomPainterTest> createState() => _CustomPainterTestState();
}

class _CustomPainterTestState extends State<CustomPainterTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.secondaryHeaderColor,
      appBar: AppBar(
        // backgroundColor: Colors.white.withOpacity(0.3),
        title: const Text(
          'Custom painter test',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: CustomPaint(
        painter: TestPainter(),
      ),
    );
  }
}

class TestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double y = size.height;
    final double x = size.width;
    final path = Path()
      ..moveTo(0, y / 4)
      ..lineTo(x, 0)
      ..quadraticBezierTo(259, 500, 500, y / 4)
      ..lineTo(0, 0);
    final paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 3;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
