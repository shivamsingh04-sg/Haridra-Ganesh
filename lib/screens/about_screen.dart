import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/footer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeController.forward();
    _slideController.forward();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final currentOffset = _scrollController.offset;

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
    _fadeController.dispose();
    _slideController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 900;

    return Scaffold(
      endDrawer: isMobile ? const CustomDrawer(currentRoute: '/about') : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 80), // Space for AppBar
                    FadeIn(child: _buildHeroSection()),
                    FadeInUp(child: _buildHistorySection()),
                    FadeInUp(child: _buildTimingsSection()),
                    FadeInUp(child: _buildPriestSection()),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: TempleFooter(),
              ),
            ],
          ),

          // Animated AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _showAppBar
                ? FadeInDown(
                    duration: const Duration(milliseconds: 300),
                    child: CustomAppBar(currentRoute: '/about'),
                  )
                : FadeOutUp(
                    duration: const Duration(milliseconds: 300),
                    child: CustomAppBar(currentRoute: '/about'),
                  ),
          ),
        ],
      ),
    );
  }

  // ... (Keep all your existing _buildHeroSection, _buildHistorySection, etc. methods)
  Widget _buildHeroSection() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFF6B35),
            const Color(0xFFFF8C42),
            const Color(0xFFFFC107),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.temple_hindu, size: 80, color: Colors.white),
            const SizedBox(height: 16),
            const Text(
              'Haridra Ganesh Temple',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              'Indore, Madhya Pradesh',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: const Text('History Section - Add your content here'),
    );
  }

  Widget _buildTimingsSection() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: const Text('Timings Section - Add your content here'),
    );
  }

  Widget _buildPriestSection() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: const Text('Priest Section - Add your content here'),
    );
  }
}
