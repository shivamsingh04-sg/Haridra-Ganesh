import 'package:flutter/material.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _glowController;
  late Animation<double> _floatAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 600;
    final isTablet = size.width > 600 && size.width <= 900;

    // Use min height instead of fixed height for better mobile experience
    final minHeight = isMobile
        ? size.height * 0.85 // 85% on mobile to hint at content below
        : (isTablet ? size.height * 0.9 : size.height);

    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFF9933).withOpacity(0.9),
            const Color(0xFFFFB84D).withOpacity(0.85),
            const Color(0xFFFFC107).withOpacity(0.7),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated Mandala Background
          Positioned.fill(
            child: CustomPaint(
              painter: MandalaPatternPainter(
                animation: _floatController,
              ),
            ),
          ),

          // Main Content - Centered with proper padding
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : (isTablet ? 32 : 48),
                vertical: isMobile ? 40 : (isTablet ? 60 : 80),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Floating Swastik Symbol
                  AnimatedBuilder(
                    animation: _floatAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatAnimation.value),
                        child: child,
                      );
                    },
                    child: AnimatedBuilder(
                      animation: _glowAnimation,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white
                                    .withOpacity(_glowAnimation.value * 0.5),
                                blurRadius: 40 * _glowAnimation.value,
                                spreadRadius: 10 * _glowAnimation.value,
                              ),
                            ],
                          ),
                          child: child,
                        );
                      },
                      child: Text(
                        '卐',
                        style: TextStyle(
                          fontSize: isMobile ? 72 : (isTablet ? 96 : 120),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              blurRadius: 20.0,
                              color: Colors.white,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 24 : (isTablet ? 32 : 40)),

                  // Temple Name in Hindi
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: [Colors.white, Colors.yellow],
                      ).createShader(bounds);
                    },
                    child: Text(
                      'हरिद्रा गणेश मंदिर',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : (isTablet ? 40 : 48),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'NotoSansDevanagari',
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: isMobile ? 8 : 12),

                  Text(
                    'HARIDRA GANESH TEMPLE',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : (isTablet ? 24 : 28),
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.95),
                      letterSpacing: 3,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: isMobile ? 16 : 20),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 20,
                      vertical: isMobile ? 8 : 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: isMobile ? 16 : 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'इंदौर, मध्य प्रदेश',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NotoSansDevanagari',
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: isMobile ? 32 : (isTablet ? 40 : 50)),

                  // Call to Action Buttons
                  Wrap(
                    spacing: isMobile ? 12 : 16,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildGlowingButton(
                        'पूजा बुक करें',
                        Icons.event_available,
                        () {},
                        isMobile: isMobile,
                        isTablet: isTablet,
                      ),
                      _buildGlowingButton(
                        'वर्चुअल टूर',
                        Icons.view_in_ar,
                        () {},
                        isPrimary: false,
                        isMobile: isMobile,
                        isTablet: isTablet,
                      ),
                    ],
                  ),

                  SizedBox(height: isMobile ? 40 : (isTablet ? 50 : 60)),

                  // Scroll Down Indicator
                  AnimatedBuilder(
                    animation: _floatAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatAnimation.value.abs()),
                        child: child,
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          'नीचे स्क्रॉल करें',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: isMobile ? 12 : 14,
                            letterSpacing: 1.5,
                            fontFamily: 'NotoSansDevanagari',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white.withOpacity(0.9),
                          size: isMobile ? 28 : 32,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowingButton(
    String text,
    IconData icon,
    VoidCallback onPressed, {
    bool isPrimary = true,
    bool isMobile = false,
    bool isTablet = false,
  }) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color:
                          Colors.white.withOpacity(_glowAnimation.value * 0.5),
                      blurRadius: 20 * _glowAnimation.value,
                      spreadRadius: 5 * _glowAnimation.value,
                    ),
                  ]
                : [],
          ),
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, size: isMobile ? 18 : 20),
            label: Text(
              text,
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                fontFamily: 'NotoSansDevanagari',
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimary ? Colors.white : Colors.transparent,
              foregroundColor:
                  isPrimary ? const Color(0xFFFF9933) : Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : (isTablet ? 28 : 32),
                vertical: isMobile ? 14 : (isTablet ? 16 : 18),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: isPrimary
                    ? BorderSide.none
                    : const BorderSide(color: Colors.white, width: 2),
              ),
              elevation: isPrimary ? 8 : 0,
            ),
          ),
        );
      },
    );
  }
}

class MandalaPatternPainter extends CustomPainter {
  final Animation<double> animation;

  MandalaPatternPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);
    final rotation = animation.value * 2 * math.pi;

    for (int i = 0; i < 12; i++) {
      final angle = (i * math.pi / 6) + rotation;
      final radius = size.width * 0.3;

      for (int j = 1; j <= 5; j++) {
        final r = radius * j / 5;
        canvas.drawCircle(center, r, paint);

        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);

        canvas.drawLine(center, Offset(x, y), paint);
      }
    }

    // Draw petals
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) - rotation;
      final path = Path();

      final startX = center.dx + 80 * math.cos(angle);
      final startY = center.dy + 80 * math.sin(angle);

      path.moveTo(startX, startY);

      final controlX1 = center.dx + 120 * math.cos(angle - 0.3);
      final controlY1 = center.dy + 120 * math.sin(angle - 0.3);

      final controlX2 = center.dx + 120 * math.cos(angle + 0.3);
      final controlY2 = center.dy + 120 * math.sin(angle + 0.3);

      final endX = center.dx + 80 * math.cos(angle);
      final endY = center.dy + 80 * math.sin(angle);

      path.quadraticBezierTo(controlX1, controlY1, endX + 50 * math.cos(angle),
          endY + 50 * math.sin(angle));
      path.quadraticBezierTo(controlX2, controlY2, startX, startY);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(MandalaPatternPainter oldDelegate) => true;
}
