import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/footer.dart';

class DarshanScreen extends StatefulWidget {
  const DarshanScreen({Key? key}) : super(key: key);

  @override
  State<DarshanScreen> createState() => _DarshanScreenState();
}

class _DarshanScreenState extends State<DarshanScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  double _lastScrollOffset = 0;
  final bool _isLive = true;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

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
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 900;

    return Scaffold(
      endDrawer: isMobile ? const CustomDrawer(currentRoute: '/darshan') : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              if (_isLive)
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    margin: const EdgeInsets.only(top: 80),
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: _pulseAnimation,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'LIVE DARSHAN IN PROGRESS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80), // Space for AppBar
                ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    FadeIn(child: _buildLiveStreamSection()),
                    FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: _buildViewerStats()),
                    FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: _buildPoojaSchedule()),
                    FadeInUp(
                        delay: const Duration(milliseconds: 600),
                        child: _buildBookingSection()),
                    const SizedBox(height: 40),
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
                    child: CustomAppBar(currentRoute: '/darshan'),
                  )
                : FadeOutUp(
                    duration: const Duration(milliseconds: 300),
                    child: CustomAppBar(currentRoute: '/darshan'),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveStreamSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.black,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videocam, size: 80, color: Colors.white54),
                  SizedBox(height: 16),
                  Text(
                    'Live Darshan Stream',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewerStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFF6B35).withOpacity(0.1),
            const Color(0xFFFFC107).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text('Viewer Stats'),
    );
  }

  Widget _buildPoojaSchedule() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: const Text('Pooja Schedule'),
    );
  }

  Widget _buildBookingSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child:
          const Text('Booking Section', style: TextStyle(color: Colors.white)),
    );
  }
}
