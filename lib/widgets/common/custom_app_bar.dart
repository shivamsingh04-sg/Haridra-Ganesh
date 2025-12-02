import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String currentRoute;

  const CustomAppBar({
    Key? key,
    required this.currentRoute,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isScrolled = false;

  bool get isDesktop => MediaQuery.of(context).size.width > 900;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : 20,
            vertical: 16,
          ),
          child: Row(
            children: [
              // Logo Section
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, '/'),
                child: _buildLogo(context),
              ),

              const Spacer(),

              // Desktop Navigation Menu
              if (isDesktop)
                Row(
                  children: [
                    _NavButton(
                      title: 'Home',
                      route: '/',
                      isActive: widget.currentRoute == '/',
                    ),
                    _NavButton(
                      title: 'About',
                      route: '/about',
                      isActive: widget.currentRoute == '/about',
                    ),
                    _NavButton(
                      title: 'Darshan',
                      route: '/darshan',
                      isActive: widget.currentRoute == '/darshan',
                    ),
                    _NavButton(
                      title: 'Events',
                      route: '/events',
                      isActive: widget.currentRoute == '/events',
                    ),
                    _NavButton(
                      title: 'Gallery',
                      route: '/gallery',
                      isActive: widget.currentRoute == '/gallery',
                    ),
                    _NavButton(
                      title: 'Contact',
                      route: '/contact',
                      isActive: widget.currentRoute == '/contact',
                    ),
                  ],
                )
              else
                Builder(
                  builder: (context) => _buildMenuButton(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Om Symbol Logo
          Container(
            width: isDesktop ? 50 : 45,
            height: isDesktop ? 50 : 45,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '🕉',
                style: TextStyle(
                  fontSize: isDesktop ? 26 : 24,
                ),
              ),
            ),
          ),

          // Temple Name (Desktop Only)
          if (isDesktop) ...[
            const SizedBox(width: 14),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Haridra Ganesh Temple',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.3,
                    height: 1.2,
                  ),
                ),
                Text(
                  'Blessed Sanctuary',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return _AnimatedButton(
      onPressed: () => Scaffold.of(context).openEndDrawer(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: const Icon(
          Icons.menu_rounded,
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ============================================================================
// NAVIGATION BUTTON - Desktop Menu Item
// ============================================================================

class _NavButton extends StatefulWidget {
  final String title;
  final String route;
  final bool isActive;

  const _NavButton({
    required this.title,
    required this.route,
    required this.isActive,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (!widget.isActive) {
            Navigator.pushReplacementNamed(context, widget.route);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? Colors.white.withOpacity(0.25)
                : (isHovered
                    ? Colors.white.withOpacity(0.15)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isActive
                  ? Colors.white.withOpacity(0.4)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// ANIMATED BUTTON - Press Effect
// ============================================================================

class _AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const _AnimatedButton({
    required this.child,
    required this.onPressed,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedScale(
        scale: isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}

// ============================================================================
// MOBILE DRAWER - Side Navigation
// ============================================================================

class CustomDrawer extends StatelessWidget {
  final String currentRoute;

  const CustomDrawer({
    Key? key,
    required this.currentRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,
      child: SafeArea(
        child: Column(
          children: [
            _buildDrawerHeader(context),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  _DrawerNavItem(
                    title: 'Home',
                    icon: Icons.home_rounded,
                    route: '/',
                    isActive: currentRoute == '/',
                  ),
                  _DrawerNavItem(
                    title: 'About Temple',
                    icon: Icons.temple_hindu_rounded,
                    route: '/about',
                    isActive: currentRoute == '/about',
                  ),
                  _DrawerNavItem(
                    title: 'Darshan Timings',
                    icon: Icons.access_time_rounded,
                    route: '/darshan',
                    isActive: currentRoute == '/darshan',
                  ),
                  _DrawerNavItem(
                    title: 'Events & Festivals',
                    icon: Icons.celebration_rounded,
                    route: '/events',
                    isActive: currentRoute == '/events',
                  ),
                  _DrawerNavItem(
                    title: 'Photo Gallery',
                    icon: Icons.photo_library_rounded,
                    route: '/gallery',
                    isActive: currentRoute == '/gallery',
                  ),
                  _DrawerNavItem(
                    title: 'Contact Us',
                    icon: Icons.phone_rounded,
                    route: '/contact',
                    isActive: currentRoute == '/contact',
                  ),
                ],
              ),
            ),
            _buildDrawerFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFF5F0), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          // Om Symbol
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6B35).withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '🕉',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Temple Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Haridra Ganesh\nTemple',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'ॐ गं गणपतये नमः',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Close Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.close_rounded, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Column(
        children: [
          // Donate Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/donate');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B35),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Donate to Temple',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Contact Info
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              SizedBox(width: 8),
              Text(
                '+91 98765 43210',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// DRAWER NAVIGATION ITEM
// ============================================================================

class _DrawerNavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final bool isActive;

  const _DrawerNavItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            if (!isActive) {
              Navigator.pushReplacementNamed(context, route);
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: isActive
                  ? const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                    )
                  : null,
              color: isActive ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : const Color(0xFF6B7280),
                  size: 22,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                      color: isActive ? Colors.white : const Color(0xFF374151),
                    ),
                  ),
                ),
                if (isActive)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
