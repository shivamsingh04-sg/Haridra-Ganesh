import 'package:flutter/material.dart';
import 'dart:math' as math;

class Temple3DView extends StatefulWidget {
  const Temple3DView({Key? key}) : super(key: key);

  @override
  State<Temple3DView> createState() => _Temple3DViewState();
}

class _Temple3DViewState extends State<Temple3DView>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  double _rotationY = 0.0;
  double _rotationX = 0.0;
  bool _isAutoRotating = true;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const Text(
            'Virtual Temple Tour',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Interact with the 3D model - Drag to rotate',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 40),
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade50,
                  Colors.purple.shade50,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _isAutoRotating = false;
                    _rotationY += details.delta.dx * 0.01;
                    _rotationX += details.delta.dy * 0.01;
                    _rotationX = _rotationX.clamp(-math.pi / 4, math.pi / 4);
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    _isAutoRotating = true;
                    _rotationY = 0.0;
                    _rotationX = 0.0;
                  });
                },
                child: AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    final autoRotation = _isAutoRotating
                        ? _rotationController.value * 2 * math.pi
                        : 0.0;

                    return CustomPaint(
                      painter: Temple3DPainter(
                        rotationY: _rotationY + autoRotation,
                        rotationX: _rotationX,
                      ),
                      size: Size.infinite,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildControlButton(
                Icons.refresh,
                'Reset View',
                () {
                  setState(() {
                    _isAutoRotating = true;
                    _rotationY = 0.0;
                    _rotationX = 0.0;
                  });
                },
              ),
              const SizedBox(width: 20),
              _buildControlButton(
                _isAutoRotating ? Icons.pause : Icons.play_arrow,
                _isAutoRotating ? 'Pause' : 'Auto Rotate',
                () {
                  setState(() {
                    _isAutoRotating = !_isAutoRotating;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
      IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF6B35),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    );
  }
}

class Temple3DPainter extends CustomPainter {
  final double rotationY;
  final double rotationX;

  Temple3DPainter({required this.rotationY, required this.rotationX});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw temple structure
    _drawTempleBase(canvas, center);
    _drawTemplePillars(canvas, center);
    _drawTempleDome(canvas, center);
    _drawTempleSpire(canvas, center);
    _drawDecorations(canvas, center);
  }

  void _drawTempleBase(Canvas canvas, Offset center) {
    final paint = Paint()
      ..color = const Color(0xFFD4A574)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    // Base platform with 3D effect
    final baseWidth = 280.0;
    final baseHeight = 40.0;

    // Shadow
    canvas.drawRect(
      Rect.fromCenter(
        center: center + const Offset(5, 185),
        width: baseWidth,
        height: baseHeight,
      ),
      shadowPaint,
    );

    // 3D layers
    for (int i = 3; i >= 0; i--) {
      final layerPaint = Paint()
        ..color = Color.lerp(
          const Color(0xFFD4A574),
          const Color(0xFFA0826D),
          i * 0.2,
        )!;

      canvas.drawRect(
        Rect.fromCenter(
          center: center + Offset(0, 180 - i * 3),
          width: baseWidth - i * 10,
          height: baseHeight,
        ),
        layerPaint,
      );
    }
  }

  void _drawTemplePillars(Canvas canvas, Offset center) {
    final positions = [
      const Offset(-100, 0),
      const Offset(-50, 0),
      const Offset(50, 0),
      const Offset(100, 0),
    ];

    for (final pos in positions) {
      _drawPillar(canvas, center + pos);
    }
  }

  void _drawPillar(Canvas canvas, Offset position) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xFFB8956A),
          const Color(0xFFD4A574),
          const Color(0xFFB8956A),
        ],
      ).createShader(Rect.fromCenter(
        center: position,
        width: 25,
        height: 150,
      ));

    // Pillar body
    final pillarRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: position + const Offset(0, 40),
        width: 25,
        height: 150,
      ),
      const Radius.circular(5),
    );
    canvas.drawRRect(pillarRect, paint);

    // Pillar capital (top)
    final capitalPaint = Paint()..color = const Color(0xFFD4A574);
    canvas.drawRect(
      Rect.fromCenter(
        center: position + const Offset(0, -35),
        width: 35,
        height: 15,
      ),
      capitalPaint,
    );

    // Pillar base
    canvas.drawRect(
      Rect.fromCenter(
        center: position + const Offset(0, 115),
        width: 30,
        height: 10,
      ),
      capitalPaint,
    );
  }

  void _drawTempleDome(Canvas canvas, Offset center) {
    final domePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFF6B35),
          const Color(0xFFFF8C42),
          const Color(0xFFD4A574),
        ],
      ).createShader(Rect.fromCircle(
        center: center + const Offset(0, -80),
        radius: 100,
      ));

    // Main dome
    final domePath = Path();
    domePath.moveTo(center.dx - 120, center.dy - 40);
    domePath.quadraticBezierTo(
      center.dx - 80,
      center.dy - 120,
      center.dx,
      center.dy - 140,
    );
    domePath.quadraticBezierTo(
      center.dx + 80,
      center.dy - 120,
      center.dx + 120,
      center.dy - 40,
    );
    domePath.close();

    canvas.drawPath(domePath, domePaint);

    // Dome details
    final detailPaint = Paint()
      ..color = const Color(0xFFFFC107).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 5; i++) {
      final arcRect = Rect.fromCenter(
        center: center + const Offset(0, -40),
        width: 240 - i * 30,
        height: 200 - i * 30,
      );
      canvas.drawArc(arcRect, -math.pi, math.pi, false, detailPaint);
    }
  }

  void _drawTempleSpire(Canvas canvas, Offset center) {
    final spirePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFFFC107),
          const Color(0xFFFF6B35),
        ],
      ).createShader(Rect.fromCenter(
        center: center + const Offset(0, -170),
        width: 40,
        height: 80,
      ));

    // Spire body
    final spirePath = Path();
    spirePath.moveTo(center.dx, center.dy - 210);
    spirePath.lineTo(center.dx - 20, center.dy - 140);
    spirePath.lineTo(center.dx + 20, center.dy - 140);
    spirePath.close();

    canvas.drawPath(spirePath, spirePaint);

    // Kalash (top ornament)
    final kalashPaint = Paint()..color = const Color(0xFFFFC107);

    canvas.drawCircle(center + const Offset(0, -220), 8, kalashPaint);

    final flagPath = Path();
    flagPath.moveTo(center.dx, center.dy - 220);
    flagPath.lineTo(center.dx, center.dy - 250);
    flagPath.lineTo(center.dx + 15, center.dy - 245);
    flagPath.lineTo(center.dx, center.dy - 240);
    flagPath.close();

    canvas.drawPath(flagPath, Paint()..color = Colors.red);
  }

  void _drawDecorations(Canvas canvas, Offset center) {
    final decorPaint = Paint()
      ..color = const Color(0xFFFFC107)
      ..style = PaintingStyle.fill;

    // Draw Om symbol
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'ॐ',
        style: TextStyle(
          fontSize: 40,
          color: Color(0xFFFF6B35),
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      center + Offset(-textPainter.width / 2, -10),
    );

    // Decorative bells
    for (int i = -1; i <= 1; i++) {
      final bellCenter = center + Offset(i * 80, -40);
      canvas.drawCircle(bellCenter, 6, decorPaint);

      final bellPath = Path();
      bellPath.moveTo(bellCenter.dx - 5, bellCenter.dy);
      bellPath.lineTo(bellCenter.dx - 8, bellCenter.dy + 8);
      bellPath.lineTo(bellCenter.dx + 8, bellCenter.dy + 8);
      bellPath.lineTo(bellCenter.dx + 5, bellCenter.dy);
      bellPath.close();
      canvas.drawPath(bellPath, decorPaint);
    }
  }

  @override
  bool shouldRepaint(Temple3DPainter oldDelegate) {
    return oldDelegate.rotationY != rotationY ||
        oldDelegate.rotationX != rotationX;
  }
}
