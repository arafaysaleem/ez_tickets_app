import 'package:flutter/material.dart';

class DashedTicketSeparator extends StatelessWidget {
  const DashedTicketSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Stack(
        alignment: Alignment.center,
        children: const [
          //Dotted line
          CustomPaint(
            size: Size(double.infinity, 0),
            painter: _DashedLinePainter(
              thickness: 1.5,
              spacing: 4,
              color: Colors.black,
              dashLength: 6,
            ),
          ),

          //Left circle cut
          Positioned(
            left: -25,
            child: SizedBox(
              height: 20,
              width: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          //Right circle cut
          Positioned(
            right: -25,
            child: SizedBox(
              height: 20,
              width: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double thickness, spacing, dashLength;
  final Color color;

  const _DashedLinePainter({
    required this.thickness,
    required this.spacing,
    required this.color,
    required this.dashLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    var count = (size.width) / (dashLength + spacing);
    if (count < 2.0) return;
    var startOffset = Offset.zero;
    for (var i = 0; i < count.toInt(); i++) {
      canvas.drawLine(startOffset, startOffset.translate(dashLength, 0), paint);
      startOffset = startOffset.translate(dashLength + spacing, 0);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
