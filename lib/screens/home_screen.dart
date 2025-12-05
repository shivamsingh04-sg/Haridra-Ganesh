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
      if (currentOffset > _lastScrollOffset && _showAppBar) {
        setState(() => _showAppBar = false);
      } else if (currentOffset < _lastScrollOffset && !_showAppBar) {
        setState(() => _showAppBar = true);
      }
    } else {
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
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 600;
    final isTablet = size.width > 600 && size.width <= 900;
    final isDesktop = size.width > 900;

    return Scaffold(
      endDrawer: !isDesktop ? const CustomDrawer(currentRoute: '/') : null,
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
                child: _buildWelcomeSection(isMobile, isTablet),
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
                child: _buildTimingsSection(isMobile, isTablet),
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
              child: _buildFloatingActionButton(isMobile),
            )
          : null,
    );
  }

  Widget _buildFloatingActionButton(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 28 : 50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9933).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        icon: const Icon(Icons.arrow_upward, size: 20),
        label: Text(
          'ऊपर',
          style: TextStyle(
            fontSize: isMobile ? 13 : 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'NotoSansDevanagari',
          ),
        ),
        backgroundColor: const Color(0xFFFF9933),
        elevation: 0,
      ),
    );
  }

  Widget _buildWelcomeSection(bool isMobile, bool isTablet) {
    final horizontalPadding = isMobile ? 16.0 : (isTablet ? 32.0 : 48.0);
    final verticalPadding = isMobile ? 40.0 : (isTablet ? 50.0 : 60.0);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFF8F0),
            const Color(0xFFFFF5E6),
            Colors.white,
          ],
        ),
      ),
      child: FadeInDown(
        child: Column(
          children: [
            // Animated Swastik Symbol
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF9933).withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: RotationTransition(
                turns: _controller,
                child: Text(
                  '卐',
                  style: TextStyle(
                    fontSize: isMobile ? 48 : (isTablet ? 56 : 64),
                    color: const Color(0xFFFF9933),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: const Color(0xFFFF9933).withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: isMobile ? 16 : 20),

            // Animated Welcome Text
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'स्वागत है',
                  textStyle: TextStyle(
                    fontSize: isMobile ? 24 : (isTablet ? 28 : 32),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF9933),
                    fontFamily: 'NotoSansDevanagari',
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
            ),
            SizedBox(height: isMobile ? 8 : 10),

            Text(
              'हरिद्रा गणेश मंदिर में आपका स्वागत है',
              style: TextStyle(
                fontSize: isMobile ? 20 : (isTablet ? 24 : 28),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF8B4513),
                letterSpacing: 0.5,
                fontFamily: 'NotoSansDevanagari',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 16 : 20),

            // Description
            Container(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : (isTablet ? 600 : 800),
              ),
              child: Text(
                'इंदौर के सबसे प्रतिष्ठित मंदिरों में से एक, हरिद्रा गणेश मंदिर में भगवान गणेश की दिव्य उपस्थिति का अनुभव करें। '
                'यह मंदिर अपनी अनोखी हल्दी से ढकी मूर्ति और आध्यात्मिक वातावरण के लिए जाना जाता है।',
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: const Color(0xFF6B5B4B),
                  height: 1.8,
                  letterSpacing: 0.3,
                  fontFamily: 'NotoSansDevanagari',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: isMobile ? 24 : 30),

            // Action Buttons
            Wrap(
              alignment: WrapAlignment.center,
              spacing: isMobile ? 12 : 20,
              runSpacing: 12,
              children: [
                _buildActionButton(
                  onPressed: () => Navigator.pushNamed(context, '/darshan'),
                  icon: Icons.video_call,
                  label: 'लाइव दर्शन',
                  isPrimary: true,
                  isMobile: isMobile,
                ),
                _buildActionButton(
                  onPressed: () => Navigator.pushNamed(context, '/about'),
                  icon: Icons.info_outline,
                  label: 'और जानें',
                  isPrimary: false,
                  isMobile: isMobile,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool isPrimary,
    required bool isMobile,
  }) {
    final buttonStyle = isPrimary
        ? ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF9933),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 24,
              vertical: isMobile ? 12 : 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          )
        : OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFFF9933),
            side: const BorderSide(color: Color(0xFFFF9933), width: 2),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 24,
              vertical: isMobile ? 12 : 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: const Color(0xFFFF9933).withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: isPrimary
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: isMobile ? 18 : 20),
              label: Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: buttonStyle,
            )
          : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: isMobile ? 18 : 20),
              label: Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: buttonStyle,
            ),
    );
  }

  Widget _buildTimingsSection(bool isMobile, bool isTablet) {
    final horizontalMargin = isMobile ? 16.0 : (isTablet ? 32.0 : 48.0);
    final verticalMargin = isMobile ? 32.0 : 40.0;
    final containerPadding = isMobile ? 24.0 : (isTablet ? 32.0 : 40.0);

    return FadeInUp(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: verticalMargin,
          horizontal: horizontalMargin,
        ),
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(containerPadding),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF9933),
                  Color(0xFFFFB84D),
                ],
              ),
              borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF9933).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'मंदिर का समय',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : (isTablet ? 28 : 32),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontFamily: 'NotoSansDevanagari',
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 30),

                // Grid or Column layout based on screen size
                isTablet || !isMobile
                    ? _buildTimingsGrid(isMobile, isTablet)
                    : _buildTimingsColumn(isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimingsGrid(bool isMobile, bool isTablet) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _buildTimingCard(
          'प्रातः आरती',
          'सुबह 6:00 - 7:00',
          Icons.wb_sunny,
          isMobile,
          isTablet,
          flexibleWidth: true,
        ),
        _buildTimingCard(
          'दर्शन समय',
          'सुबह 7:00 - दोपहर 12:00',
          Icons.temple_hindu,
          isMobile,
          isTablet,
          flexibleWidth: true,
        ),
        _buildTimingCard(
          'संध्या दर्शन',
          'शाम 4:00 - 8:00',
          Icons.nights_stay,
          isMobile,
          isTablet,
          flexibleWidth: true,
        ),
        _buildTimingCard(
          'संध्या आरती',
          'शाम 7:00 - 8:00',
          Icons.celebration,
          isMobile,
          isTablet,
          flexibleWidth: true,
        ),
      ],
    );
  }

  Widget _buildTimingsColumn(bool isMobile) {
    return Column(
      children: [
        _buildTimingCard(
            'प्रातः आरती', 'सुबह 6:00 - 7:00', Icons.wb_sunny, isMobile, false),
        const SizedBox(height: 12),
        _buildTimingCard('दर्शन समय', 'सुबह 7:00 - दोपहर 12:00',
            Icons.temple_hindu, isMobile, false),
        const SizedBox(height: 12),
        _buildTimingCard('संध्या दर्शन', 'शाम 4:00 - 8:00', Icons.nights_stay,
            isMobile, false),
        const SizedBox(height: 12),
        _buildTimingCard('संध्या आरती', 'शाम 7:00 - 8:00', Icons.celebration,
            isMobile, false),
      ],
    );
  }

  Widget _buildTimingCard(
    String title,
    String time,
    IconData icon,
    bool isMobile,
    bool isTablet, {
    bool flexibleWidth = false,
  }) {
    final cardWidth =
        flexibleWidth ? (isTablet ? 280.0 : 320.0) : double.infinity;

    return Container(
      width: flexibleWidth ? cardWidth : null,
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: flexibleWidth ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5E6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: isMobile ? 24 : 28,
              color: const Color(0xFFFF9933),
            ),
          ),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 17,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF8B4513),
                    letterSpacing: 0.3,
                    fontFamily: 'NotoSansDevanagari',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: const Color(0xFF6B5B4B),
                    letterSpacing: 0.2,
                    fontFamily: 'NotoSansDevanagari',
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
