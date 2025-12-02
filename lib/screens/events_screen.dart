import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haridra_ganesh_temple/widgets/common/custom_app_bar.dart';
import 'package:haridra_ganesh_temple/widgets/common/footer.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  double _lastScrollOffset = 0;

  final List<Map<String, dynamic>> upcomingEvents = [
    {
      'title': 'Ganesh Chaturthi',
      'date': 'September 19, 2025',
      'time': '6:00 AM - 10:00 PM',
      'description':
          'Grand celebration of Lord Ganesh\'s birthday with special abhishek and aarti',
      'icon': Icons.celebration,
      'color': const Color(0xFFFF6B35),
    },
    {
      'title': 'Sankashti Chaturthi',
      'date': 'November 25, 2025',
      'time': '5:00 PM - 9:00 PM',
      'description': 'Monthly fasting and prayer dedicated to Lord Ganesh',
      'icon': Icons.nightlight,
      'color': const Color(0xFFFFC107),
    },
    {
      'title': 'Diwali Lakshmi Pooja',
      'date': 'October 20, 2025',
      'time': '6:00 PM - 10:00 PM',
      'description': 'Festival of lights with special Lakshmi and Ganesh pooja',
      'icon': Icons.light_mode,
      'color': const Color(0xFFFF6B35),
    },
    {
      'title': 'Makar Sankranti',
      'date': 'January 14, 2026',
      'time': '7:00 AM - 12:00 PM',
      'description': 'Harvest festival celebration with special prayers',
      'icon': Icons.wb_sunny,
      'color': const Color(0xFFFFC107),
    },
  ];

  final List<Map<String, dynamic>> pastEvents = [
    {
      'title': 'Maha Shivaratri',
      'date': 'March 8, 2025',
      'attendees': '5000+',
      'description': 'Night-long vigil with special abhishek',
    },
    {
      'title': 'Holi Celebration',
      'date': 'March 25, 2025',
      'attendees': '3000+',
      'description': 'Festival of colors with music and dance',
    },
    {
      'title': 'Ram Navami',
      'date': 'April 6, 2025',
      'attendees': '4000+',
      'description': 'Celebration of Lord Rama\'s birth',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_handleScroll);
    _tabController.addListener(() {
      setState(() {});
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

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 900;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      endDrawer: isMobile ? const CustomDrawer(currentRoute: '/events') : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Space for floating AppBar
              SliverToBoxAdapter(
                child: const SizedBox(height: 80),
              ),

              // Hero Section
              SliverToBoxAdapter(
                child: FadeIn(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 20),
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
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B35).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.event_note,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Events & Festivals',
                          style: GoogleFonts.poppins(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Celebrate Divine Occasions with Us',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Tab Bar
              SliverToBoxAdapter(
                child: FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Container(
                    margin: const EdgeInsets.all(20),
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
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey[600],
                      labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      unselectedLabelStyle: GoogleFonts.poppins(fontSize: 16),
                      padding: const EdgeInsets.all(4),
                      tabs: const [
                        Tab(text: 'Upcoming'),
                        Tab(text: 'Past Events'),
                      ],
                    ),
                  ),
                ),
              ),

              // Tab View Content
              SliverToBoxAdapter(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _tabController.index == 0
                      ? _buildUpcomingTab()
                      : _buildPastEventsTab(),
                ),
              ),
            ],
          ),

          // Floating AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _showAppBar
                ? FadeInDown(
                    duration: const Duration(milliseconds: 300),
                    child: CustomAppBar(currentRoute: '/events'),
                  )
                : FadeOutUp(
                    duration: const Duration(milliseconds: 300),
                    child: CustomAppBar(currentRoute: '/events'),
                  ),
          ),
        ],
      ),
      floatingActionButton: FadeInUp(
        delay: const Duration(milliseconds: 600),
        child: FloatingActionButton.extended(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Notification preferences updated!',
                  style: GoogleFonts.poppins(),
                ),
                backgroundColor: const Color(0xFFFF6B35),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          backgroundColor: const Color(0xFFFF6B35),
          elevation: 8,
          icon: const Icon(Icons.notifications_active),
          label: Text('Get Notified',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget _buildUpcomingTab() {
    return Column(
      key: const ValueKey('upcoming'),
      children: [
        _buildFeaturedEvent(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFFC107)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Upcoming Events',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C3E50),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...upcomingEvents.asMap().entries.map((entry) {
                return FadeInUp(
                  key: ValueKey('upcoming_event_${entry.key}'),
                  delay: Duration(milliseconds: 100 + (entry.key * 50)),
                  child: _buildEventCard(entry.value),
                );
              }).toList(),
            ],
          ),
        ),
        FadeInUp(
          delay: const Duration(milliseconds: 300),
          child: _buildMonthlyCalendar(),
        ),
        const SizedBox(height: 20),
        const TempleFooter(),
      ],
    );
  }

  Widget _buildFeaturedEvent() {
    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFF6B35),
              const Color(0xFFFF8C42),
              const Color(0xFFFFC107),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF6B35).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFF6B35),
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'FEATURED EVENT',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFF6B35),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Ganesh Chaturthi',
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        '2025',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      _buildFeaturedInfo(
                        Icons.calendar_today,
                        'September 19, 2025',
                      ),
                      const SizedBox(height: 12),
                      _buildFeaturedInfo(
                        Icons.access_time,
                        '6:00 AM onwards',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedInfo(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: event['color'].withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    event['color'],
                    event['color'].withOpacity(0.7),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    event['icon'],
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      event['date'].split(' ')[1].replaceAll(',', ''),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 6),
                        Text(
                          event['date'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 6),
                        Text(
                          event['time'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      event['description'],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: event['color'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFFFC107)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'This Month\'s Special Days',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildCalendarItem('Sankashti Chaturthi', 'Nov 25', Icons.nightlight),
          _buildCalendarItem('Ekadashi', 'Nov 28', Icons.self_improvement),
          _buildCalendarItem('Purnima', 'Nov 30', Icons.brightness_3),
        ],
      ),
    );
  }

  Widget _buildCalendarItem(String title, String date, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B35).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFF6B35).withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C3E50),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              date,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastEventsTab() {
    return Padding(
      key: const ValueKey('past'),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFFFC107)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Past Events Gallery',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...pastEvents.asMap().entries.map((entry) {
            return FadeInUp(
              key: ValueKey('past_event_${entry.key}'),
              delay: Duration(milliseconds: 100 + (entry.key * 50)),
              child: _buildPastEventCard(entry.value),
            );
          }).toList(),
          const SizedBox(height: 20),
          const TempleFooter(),
        ],
      ),
    );
  }

  Widget _buildPastEventCard(Map<String, dynamic> event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFFF6B35).withOpacity(0.3),
                    const Color(0xFFFFC107).withOpacity(0.3),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 60,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  event['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 14, color: const Color(0xFFFF6B35)),
                          const SizedBox(width: 6),
                          Text(
                            event['date'],
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFF6B35),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.people,
                              size: 14, color: const Color(0xFFFFC107)),
                          const SizedBox(width: 6),
                          Text(
                            event['attendees'],
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFFC107),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
