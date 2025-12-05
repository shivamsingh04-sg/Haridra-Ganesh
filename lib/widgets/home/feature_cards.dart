import 'package:flutter/material.dart';

/// Temple color palette
class TempleColors {
  static const Color saffron = Color(0xFFFF9933);
  static const Color goldenSaffron = Color(0xFFFFB84D);
  static const Color warmGold = Color(0xFFD4A574);
  static const Color softCream = Color(0xFFFFF8F0);
  static const Color lightSaffronTint = Color(0xFFFFF5E6);
  static const Color lightPeach = Color(0xFFFFE5CC);
  static const Color primaryBrown = Color(0xFF8B4513);
  static const Color secondaryBrown = Color(0xFF6B5B4B);
  static const Color white = Colors.white;

  // Feature card colors
  static const Color liveDarshan = Color(0xFFFF6B35);
  static const Color bookPooja = Color(0xFF4CAF50);
  static const Color gallery = Color(0xFF2196F3);
  static const Color donate = Color(0xFFE91E63);
  static const Color events = Color(0xFF9C27B0);
  static const Color visitUs = Color(0xFFFF9800);
}

class FeatureCards extends StatelessWidget {
  const FeatureCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.video_call,
        'title': 'Live Darshan',
        'description': 'Watch live darshan from anywhere in the world',
        'color': TempleColors.liveDarshan,
      },
      {
        'icon': Icons.event_available,
        'title': 'Book Pooja',
        'description': 'Book your pooja online easily and securely',
        'color': TempleColors.bookPooja,
      },
      {
        'icon': Icons.photo_library,
        'title': 'Gallery',
        'description': 'View beautiful temple photos and videos',
        'color': TempleColors.gallery,
      },
      {
        'icon': Icons.volunteer_activism,
        'title': 'Donate',
        'description': 'Contribute to temple activities and seva',
        'color': TempleColors.donate,
      },
      {
        'icon': Icons.calendar_month,
        'title': 'Events',
        'description': 'Stay updated with festivals and ceremonies',
        'color': TempleColors.events,
      },
      {
        'icon': Icons.location_on,
        'title': 'Visit Us',
        'description': 'Get directions, timings, and contact info',
        'color': TempleColors.visitUs,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;

        // Determine grid columns based on screen size
        int crossAxisCount;
        double childAspectRatio;

        if (isMobile) {
          crossAxisCount = 1;
          childAspectRatio = 1.3;
        } else if (isTablet) {
          crossAxisCount = 2;
          childAspectRatio = 1.2;
        } else {
          crossAxisCount = 3;
          childAspectRatio = 1.15;
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                TempleColors.softCream,
                TempleColors.white,
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
            vertical: isMobile ? 40 : 60,
          ),
          child: Column(
            children: [
              // Section header with animation
              _AnimatedSectionHeader(isMobile: isMobile),

              SizedBox(height: isMobile ? 30 : 40),

              // Decorative divider
              _buildDecorativeDivider(),

              SizedBox(height: isMobile ? 30 : 50),

              // Feature cards grid with staggered animation
              _StaggeredFeatureGrid(
                features: features,
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                isMobile: isMobile,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDecorativeDivider() {
    return Container(
      height: 3,
      width: 80,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            TempleColors.saffron,
            TempleColors.goldenSaffron,
          ],
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

/// Animated section header
class _AnimatedSectionHeader extends StatefulWidget {
  final bool isMobile;

  const _AnimatedSectionHeader({required this.isMobile});

  @override
  State<_AnimatedSectionHeader> createState() => _AnimatedSectionHeaderState();
}

class _AnimatedSectionHeaderState extends State<_AnimatedSectionHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: TempleColors.lightPeach,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.temple_hindu,
                    color: TempleColors.saffron,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Temple Services',
              style: TextStyle(
                fontSize: widget.isMobile ? 28 : 36,
                fontWeight: FontWeight.bold,
                color: TempleColors.primaryBrown,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Experience divine blessings through our services',
              style: TextStyle(
                fontSize: widget.isMobile ? 14 : 16,
                color: TempleColors.secondaryBrown,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Staggered animation grid for feature cards
class _StaggeredFeatureGrid extends StatelessWidget {
  final List<Map<String, dynamic>> features;
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isMobile;

  const _StaggeredFeatureGrid({
    required this.features,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: isMobile ? 16 : 20,
        mainAxisSpacing: isMobile ? 16 : 20,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];

        // Staggered animation delay
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 400 + (index * 100)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: _FeatureCard(
            icon: feature['icon'] as IconData,
            title: feature['title'] as String,
            description: feature['description'] as String,
            color: feature['color'] as Color,
            isMobile: isMobile,
          ),
        );
      },
    );
  }
}

/// Individual feature card with hover animation
class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isMobile;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.isMobile,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // Handle card tap
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${widget.title} tapped'),
              duration: const Duration(milliseconds: 1500),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -8.0 : 0.0)
            ..scale(_isHovered ? 1.02 : 1.0),
          child: Container(
            padding: EdgeInsets.all(widget.isMobile ? 20 : 24),
            decoration: BoxDecoration(
              color: TempleColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered
                    ? widget.color.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.1),
                width: _isHovered ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.color.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  blurRadius: _isHovered ? 20 : 10,
                  offset: Offset(0, _isHovered ? 10 : 4),
                  spreadRadius: _isHovered ? 2 : 0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated icon container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(widget.isMobile ? 14 : 16),
                  decoration: BoxDecoration(
                    gradient: _isHovered
                        ? LinearGradient(
                            colors: [
                              widget.color,
                              widget.color.withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: _isHovered ? null : widget.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: widget.color.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    widget.icon,
                    size: widget.isMobile ? 32 : 40,
                    color: _isHovered ? TempleColors.white : widget.color,
                  ),
                ),

                SizedBox(height: widget.isMobile ? 12 : 16),

                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: widget.isMobile ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: TempleColors.primaryBrown,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: widget.isMobile ? 6 : 8),

                // Description
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: widget.isMobile ? 13 : 14,
                    color: TempleColors.secondaryBrown,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                if (_isHovered) ...[
                  SizedBox(height: widget.isMobile ? 12 : 16),

                  // Animated CTA button (appears on hover)
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.color,
                            widget.color.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Learn More',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Example usage widget
class FeatureCardsDemo extends StatelessWidget {
  const FeatureCardsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TempleColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 40),
            FeatureCards(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
