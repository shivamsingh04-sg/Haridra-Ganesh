import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlowerFallAnimation extends StatefulWidget {
  const FlowerFallAnimation({Key? key}) : super(key: key);

  @override
  State<FlowerFallAnimation> createState() => _FlowerFallAnimationState();
}

class _FlowerFallAnimationState extends State<FlowerFallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Flower> _flowers;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _flowers = List.generate(30, (index) => Flower());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: FlowerPainter(
                flowers: _flowers,
                animation: _controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class Flower {
  late double x;
  late double speed;
  late double amplitude;
  late double frequency;
  late Color color;
  late double size;
  late double rotation;
  late double rotationSpeed;

  Flower() {
    final random = math.Random();
    x = random.nextDouble();
    speed = 0.3 + random.nextDouble() * 0.4;
    amplitude = 30 + random.nextDouble() * 50;
    frequency = 1 + random.nextDouble() * 2;
    size = 8 + random.nextDouble() * 12;
    rotation = random.nextDouble() * 2 * math.pi;
    rotationSpeed = (random.nextDouble() - 0.5) * 4;

    final colors = [
      const Color(0xFFFF6B9D),
      const Color(0xFFFFC107),
      const Color(0xFFFF6B35),
      const Color(0xFFE91E63),
      const Color(0xFFFFEB3B),
    ];
    color = colors[random.nextInt(colors.length)];
  }

  Offset getPosition(double progress, Size size) {
    final y = progress * size.height;
    final xOffset = amplitude * math.sin(frequency * y / 100);
    final actualX = x * size.width + xOffset;
    return Offset(actualX, y);
  }

  double getRotation(double progress) {
    return rotation + rotationSpeed * progress * 10;
  }
}

class FlowerPainter extends CustomPainter {
  final List<Flower> flowers;
  final double animation;

  FlowerPainter({required this.flowers, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    for (final flower in flowers) {
      final progress = (animation * flower.speed) % 1.0;
      final position = flower.getPosition(progress, size);
      final rotation = flower.getRotation(progress);

      canvas.save();
      canvas.translate(position.dx, position.dy);
      canvas.rotate(rotation);

      _drawFlower(canvas, flower);

      canvas.restore();
    }
  }

  void _drawFlower(Canvas canvas, Flower flower) {
    final paint = Paint()
      ..color = flower.color.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    // Draw petals
    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * math.pi / 5);

      canvas.save();
      canvas.rotate(angle);

      // Petal path
      final path = Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(
        flower.size * 0.3,
        -flower.size * 0.5,
        0,
        -flower.size,
      );
      path.quadraticBezierTo(
        -flower.size * 0.3,
        -flower.size * 0.5,
        0,
        0,
      );

      canvas.drawPath(path, paint);
      canvas.restore();
    }

    // Draw center
    final centerPaint = Paint()
      ..color = const Color(0xFFFFC107)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset.zero,
      flower.size * 0.25,
      centerPaint,
    );
  }

  @override
  bool shouldRepaint(FlowerPainter oldDelegate) => true;
}
