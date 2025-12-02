import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/footer.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController(viewportFraction: 0.8);
  bool _showAppBar = true;
  double _lastScrollOffset = 0;
  String selectedCategory = 'All';
  int _currentPage = 0;
  double _currentPageValue = 0.0;

  final List<String> categories = [
    'All',
    'Temple',
    'Festivals',
    'Aarti',
    'Architecture',
    'Devotees',
  ];

  final List<GalleryImage> galleryImages = [
    GalleryImage(
      id: 1,
      title: 'Main Temple Sanctum',
      category: 'Temple',
      description:
          'The magnificent main sanctum adorned with intricate carvings and golden embellishments, representing centuries of devotion and architectural excellence.',
      photographer: 'Rajesh Kumar',
      date: 'January 15, 2024',
      location: 'Main Temple Complex',
    ),
    GalleryImage(
      id: 2,
      title: 'Evening Aarti Ceremony',
      category: 'Aarti',
      description:
          'The divine evening aarti ceremony with priests performing rituals amidst the glow of countless oil lamps, creating an atmosphere of spiritual serenity.',
      photographer: 'Priya Sharma',
      date: 'February 20, 2024',
      location: 'Main Prayer Hall',
    ),
    GalleryImage(
      id: 3,
      title: 'Diwali Celebrations',
      category: 'Festivals',
      description:
          'The temple illuminated with thousands of diyas during the grand Diwali celebration, showcasing the triumph of light over darkness.',
      photographer: 'Amit Patel',
      date: 'November 12, 2023',
      location: 'Temple Courtyard',
    ),
    GalleryImage(
      id: 4,
      title: 'Temple Architecture',
      category: 'Architecture',
      description:
          'Stunning architectural details featuring traditional Indian temple design elements, including ornate pillars and detailed stone work.',
      photographer: 'Suresh Reddy',
      date: 'March 5, 2024',
      location: 'East Wing',
    ),
    GalleryImage(
      id: 5,
      title: 'Devotees in Prayer',
      category: 'Devotees',
      description:
          'Devotees immersed in deep prayer and meditation, showcasing the temple as a sanctuary of faith and spiritual connection.',
      photographer: 'Meera Singh',
      date: 'January 28, 2024',
      location: 'Prayer Courtyard',
    ),
    GalleryImage(
      id: 6,
      title: 'Navratri Festival',
      category: 'Festivals',
      description:
          'Vibrant Navratri celebrations with traditional dance performances and elaborate decorations honoring the Divine Mother.',
      photographer: 'Vikram Desai',
      date: 'October 18, 2023',
      location: 'Festival Grounds',
    ),
    GalleryImage(
      id: 7,
      title: 'Sacred Bell Tower',
      category: 'Architecture',
      description:
          'The historic bell tower standing tall against the sky, its bells rung during daily rituals to invoke divine blessings.',
      photographer: 'Anjali Nair',
      date: 'December 10, 2023',
      location: 'North Entrance',
    ),
    GalleryImage(
      id: 8,
      title: 'Morning Aarti',
      category: 'Aarti',
      description:
          'The peaceful morning aarti ceremony at sunrise, welcoming the new day with sacred chants and offering prayers.',
      photographer: 'Karthik Iyer',
      date: 'February 14, 2024',
      location: 'Main Sanctum',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page ?? 0.0;
      });
    });
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

  List<GalleryImage> get filteredImages {
    if (selectedCategory == 'All') return galleryImages;
    return galleryImages
        .where((img) => img.category == selectedCategory)
        .toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 900;

    return Scaffold(
      endDrawer: isMobile ? const CustomDrawer(currentRoute: '/gallery') : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: const SizedBox(height: 80),
              ),
              SliverToBoxAdapter(
                child: FadeIn(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFFF6B35).withOpacity(0.1),
                          const Color(0xFFFFC107).withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.photo_library,
                            size: 60, color: Color(0xFFFF6B35)),
                        SizedBox(height: 16),
                        Text(
                          'Photo Gallery',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Capturing Divine Moments',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FadeInUp(child: _buildCategoryFilter()),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 500,
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _buildCarousel(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: const SizedBox(height: 30),
              ),
              SliverToBoxAdapter(
                child: FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: _buildImageInfo(),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 60),
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
                    child: CustomAppBar(currentRoute: '/gallery'),
                  )
                : FadeOutUp(
                    duration: const Duration(milliseconds: 300),
                    child: CustomAppBar(currentRoute: '/gallery'),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    final filtered = filteredImages;

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return _buildCarouselItem(filtered[index], index);
            },
          ),
        ),
        const SizedBox(height: 20),
        _buildPageIndicator(filtered.length),
      ],
    );
  }

  Widget _buildCarouselItem(GalleryImage image, int index) {
    double scale = 1.0;
    double opacity = 0.7;

    if (_currentPageValue >= index - 1 && _currentPageValue <= index + 1) {
      scale = math.max(0.8, 1 - (_currentPageValue - index).abs() * 0.2);
      opacity = math.max(0.5, 1 - (_currentPageValue - index).abs() * 0.5);
    }

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0.8, end: scale),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: opacity,
            child: GestureDetector(
              onTap: () => _showImageDetail(image),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                child: Hero(
                  tag: 'image_${image.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFF6B35).withOpacity(0.3),
                                Color(0xFFFFC107).withOpacity(0.3),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              _getCategoryIcon(image.category),
                              size: 80,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  image.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  image.category,
                                  style: TextStyle(
                                    color: Colors.orange[300],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageIndicator(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color(0xFFFF6B35)
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildImageInfo() {
    if (filteredImages.isEmpty) return const SizedBox.shrink();

    final currentImage = filteredImages[_currentPage % filteredImages.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFFFF6B35)),
              const SizedBox(width: 8),
              const Text(
                'Image Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.calendar_today, 'Date', currentImage.date),
          _buildInfoRow(Icons.location_on, 'Location', currentImage.location),
          _buildInfoRow(
              Icons.person, 'Photographer', currentImage.photographer),
          const SizedBox(height: 12),
          Text(
            currentImage.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImageDetail(GalleryImage image) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Image Detail',
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                constraints:
                    const BoxConstraints(maxWidth: 600, maxHeight: 700),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Hero(
                        tag: 'image_${image.id}',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                          child: Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFFF6B35).withOpacity(0.4),
                                  Color(0xFFFFC107).withOpacity(0.4),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                _getCategoryIcon(image.category),
                                size: 100,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    image.title,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C3E50),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.close),
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFF6B35).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                image.category,
                                style: const TextStyle(
                                  color: Color(0xFFFF6B35),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildDetailRow(Icons.calendar_today, image.date),
                            _buildDetailRow(Icons.location_on, image.location),
                            _buildDetailRow(Icons.person, image.photographer),
                            const SizedBox(height: 20),
                            Text(
                              image.description,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Color(0xFFFF6B35)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
                _currentPage = 0;
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                      )
                    : null,
                color: isSelected ? null : Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Color(0xFFFF6B35).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Temple':
        return Icons.temple_hindu;
      case 'Festivals':
        return Icons.celebration;
      case 'Aarti':
        return Icons.light_mode;
      case 'Architecture':
        return Icons.architecture;
      case 'Devotees':
        return Icons.people;
      default:
        return Icons.photo;
    }
  }
}

class GalleryImage {
  final int id;
  final String title;
  final String category;
  final String description;
  final String photographer;
  final String date;
  final String location;

  GalleryImage({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.photographer,
    required this.date,
    required this.location,
  });
}
