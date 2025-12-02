import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FeatureCards extends StatelessWidget {
  const FeatureCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.video_call,
        'title': 'Live Darshan',
        'description': 'Watch live darshan from anywhere',
        'color': const Color(0xFFFF6B35),
      },
      {
        'icon': Icons.event_available,
        'title': 'Book Pooja',
        'description': 'Book your pooja online easily',
        'color': const Color(0xFF4CAF50),
      },
      {
        'icon': Icons.photo_library,
        'title': 'Gallery',
        'description': 'View temple photos and videos',
        'color': const Color(0xFF2196F3),
      },
      {
        'icon': Icons.volunteer_activism,
        'title': 'Donate',
        'description': 'Contribute to temple activities',
        'color': const Color(0xFFE91E63),
      },
      {
        'icon': Icons.calendar_month,
        'title': 'Events',
        'description': 'Stay updated with festivals',
        'color': const Color(0xFF9C27B0),
      },
      {
        'icon': Icons.location_on,
        'title': 'Visit Us',
        'description': 'Get directions and timings',
        'color': const Color(0xFFFF9800),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Text(
            'Temple Services',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 40),
          AnimationLimiter(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 3,
                  duration: const Duration(milliseconds: 500),
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: _buildFeatureCard(
                        icon: feature['icon'] as IconData,
                        title: feature['title'] as String,
                        description: feature['description'] as String,
                        color: feature['color'] as Color,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return HoverCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class HoverCard extends StatefulWidget {
  final Widget child;

  const HoverCard({Key? key, required this.child}) : super(key: key);

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 4.0, end: 20.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value / 2),
                  ),
                ],
              ),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
