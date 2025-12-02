import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/footer.dart';
import '../widgets/home/hero_section.dart';
import '../widgets/home/feature_cards.dart';
import '../widgets/home/temple_3d_view.dart';
import '../widgets/animations/flower_fall_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = false;
  bool _showAppBar = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final currentOffset = _scrollController.offset;

    // Show/Hide floating button
    if (currentOffset > 300 && !_showFloatingButton) {
      setState(() => _showFloatingButton = true);
    } else if (currentOffset <= 300 && _showFloatingButton) {
      setState(() => _showFloatingButton = false);
    }

    // Show/Hide AppBar based on scroll direction
    if (currentOffset > 100) {
      // Only hide after scrolling past 100px
      if (currentOffset > _lastScrollOffset && _showAppBar) {
        // Scrolling down - hide app bar
        setState(() => _showAppBar = false);
      } else if (currentOffset < _lastScrollOffset && !_showAppBar) {
        // Scrolling up - show app bar
        setState(() => _showAppBar = true);
      }
    } else {
      // Always show app bar at the top
      if (!_showAppBar) {
        setState(() => _showAppBar = true);
      }
    }

    _lastScrollOffset = currentOffset;
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 900;

    return Scaffold(
      endDrawer: isMobile ? const CustomDrawer(currentRoute: '/') : null,
      body: Stack(
        children: [
          const FlowerFallAnimation(),

          // Main Scrollable Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero Section
              SliverToBoxAdapter(
                child: AnimationConfiguration.synchronized(
                  duration: const Duration(milliseconds: 1000),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: const HeroSection(),
                    ),
                  ),
                ),
              ),

              // Welcome Message
              SliverToBoxAdapter(
                child: _buildWelcomeSection(),
              ),

              // 3D Temple View
              SliverToBoxAdapter(
                child: AnimationConfiguration.synchronized(
                  duration: const Duration(milliseconds: 1200),
                  child: ScaleAnimation(
                    child: const Temple3DView(),
                  ),
                ),
              ),

              // Feature Cards
              SliverToBoxAdapter(
                child: AnimationLimiter(
                  child: const FeatureCards(),
                ),
              ),

              // Temple Timings
              SliverToBoxAdapter(
                child: _buildTimingsSection(),
              ),

              // Footer
              const SliverToBoxAdapter(
                child: TempleFooter(),
              ),
            ],
          ),

          // Animated AppBar - Show/Hide on Scroll
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _showAppBar
                ? FadeInDown(
                    duration: const Duration(milliseconds: 300),
                    child: CustomAppBar(currentRoute: '/'),
                  )
                : FadeOutUp(
                    duration: const Duration(milliseconds: 300),
                    child: CustomAppBar(currentRoute: '/'),
                  ),
          ),
        ],
      ),
      floatingActionButton: _showFloatingButton
          ? FadeInUp(
              child: FloatingActionButton.extended(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(Icons.arrow_upward),
                label: const Text('Top'),
                backgroundColor: const Color(0xFFFF6B35),
              ),
            )
          : null,
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.shade50,
            Colors.white,
          ],
        ),
      ),
      child: FadeInDown(
        child: Column(
          children: [
            // Animated Om Symbol
            RotationTransition(
              turns: _controller,
              child: const Text(
                'ॐ',
                style: TextStyle(
                  fontSize: 60,
                  color: Color(0xFFFF6B35),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Animated Welcome Text
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'स्वागत है',
                  textStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6B35),
                    fontFamily: 'NotoSansDevanagari',
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
            ),
            const SizedBox(height: 10),

            const Text(
              'Welcome to Haridra Ganesh Temple',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                'Experience the divine presence of Lord Ganesh at one of Indore\'s most revered temples. '
                'The Haridra Ganesh Temple is known for its unique turmeric-covered idol and spiritual ambiance.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/darshan');
                  },
                  icon: const Icon(Icons.video_call),
                  label: const Text('Live Darshan'),
                ),
                const SizedBox(width: 20),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Learn More'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFF6B35),
                    side: const BorderSide(color: Color(0xFFFF6B35)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimingsSection() {
    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade400,
              Colors.orange.shade600,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Temple Timings',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            _buildTimingCard(
                'Morning Aarti', '6:00 AM - 7:00 AM', Icons.wb_sunny),
            const SizedBox(height: 15),
            _buildTimingCard(
                'Darshan Hours', '7:00 AM - 12:00 PM', Icons.temple_hindu),
            const SizedBox(height: 15),
            _buildTimingCard(
                'Evening Darshan', '4:00 PM - 8:00 PM', Icons.nights_stay),
            const SizedBox(height: 15),
            _buildTimingCard(
                'Evening Aarti', '7:00 PM - 8:00 PM', Icons.celebration),
          ],
        ),
      ),
    );
  }

  Widget _buildTimingCard(String title, String time, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: const Color(0xFFFF6B35)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
