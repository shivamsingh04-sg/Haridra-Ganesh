import 'package:flutter/material.dart';

import 'package:haridra_ganesh_temple/confiq/app_colors.dart';

class TempleFooter extends StatelessWidget {
  const TempleFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                TempleColors.softCream,
                TempleColors.lightSaffronTint,
              ],
            ),
          ),
          child: Column(
            children: [
              // Decorative divider
              Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      TempleColors.saffron,
                      TempleColors.goldenSaffron,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Main footer content
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
                  vertical: isMobile ? 40 : 60,
                ),
                child: Column(
                  children: [
                    // Footer sections
                    isMobile
                        ? _buildMobileLayout()
                        : isTablet
                            ? _buildTabletLayout()
                            : _buildDesktopLayout(),

                    SizedBox(height: isMobile ? 40 : 50),

                    // Newsletter section
                    _buildNewsletterSection(isMobile),

                    SizedBox(height: isMobile ? 40 : 50),

                    // Divider
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            TempleColors.warmGoldLight(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: isMobile ? 30 : 40),

                    // Bottom bar
                    _buildBottomBar(isMobile),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAboutSection(),
        const SizedBox(height: 40),
        _buildQuickLinksSection(),
        const SizedBox(height: 40),
        _buildTimingsSection(),
        const SizedBox(height: 40),
        _buildContactSection(),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildAboutSection()),
            const SizedBox(width: 40),
            Expanded(child: _buildQuickLinksSection()),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTimingsSection()),
            const SizedBox(width: 40),
            Expanded(child: _buildContactSection()),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildAboutSection()),
        const SizedBox(width: 50),
        Expanded(child: _buildQuickLinksSection()),
        const SizedBox(width: 50),
        Expanded(child: _buildTimingsSection()),
        const SizedBox(width: 50),
        Expanded(flex: 2, child: _buildContactSection()),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: TempleColors.saffronLight(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.temple_hindu,
                color: TempleColors.saffron,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Haridra Ganesh',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: TempleColors.primaryBrown,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'A sacred sanctuary of devotion and spirituality, home to the divine turmeric-adorned Lord Ganesh. Experience peace, prosperity, and divine blessings.',
          style: TextStyle(
            fontSize: 14,
            color: TempleColors.secondaryBrown,
            height: 1.7,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            _buildSocialIcon(Icons.facebook),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.camera_alt),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.video_library),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.phone),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Quick Links'),
        const SizedBox(height: 20),
        _buildFooterLink('About Temple', Icons.info_outline),
        _buildFooterLink('Pooja Services', Icons.spa),
        _buildFooterLink('Donations', Icons.volunteer_activism),
        _buildFooterLink('Events', Icons.event),
        _buildFooterLink('Gallery', Icons.photo_library),
        _buildFooterLink('Contact', Icons.contact_page),
      ],
    );
  }

  Widget _buildTimingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Temple Timings'),
        const SizedBox(height: 20),
        _buildTimingCard('Morning Aarti', '6:00 AM - 12:00 PM', Icons.wb_sunny),
        const SizedBox(height: 12),
        _buildTimingCard(
            'Evening Aarti', '4:00 PM - 8:00 PM', Icons.brightness_3),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TempleColors.lightPeach,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: TempleColors.saffronLight(0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.star,
                    color: TempleColors.saffron,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Special Days',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: TempleColors.primaryBrown,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Tuesday & Festivals: Extended Hours',
                style: TextStyle(
                  fontSize: 12,
                  color: TempleColors.secondaryBrown,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Get in Touch'),
        const SizedBox(height: 20),
        _buildContactRow(
          Icons.location_on,
          'Haridra Ganesh Mandir\nIndore, Madhya Pradesh',
        ),
        const SizedBox(height: 16),
        _buildContactRow(
          Icons.phone,
          '+91 1234567890',
        ),
        const SizedBox(height: 16),
        _buildContactRow(
          Icons.email,
          'info@haridraganesh.org',
        ),
        const SizedBox(height: 20),
        _AnimatedButton(
          text: 'Get Directions',
          icon: Icons.directions,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildNewsletterSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            TempleColors.lightPeach,
            TempleColors.softBeige,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TempleColors.saffronLight(0.2),
          width: 1,
        ),
      ),
      child: isMobile
          ? Column(
              children: [
                _buildNewsletterContent(),
                const SizedBox(height: 20),
                _buildNewsletterInput(),
              ],
            )
          : Row(
              children: [
                Expanded(child: _buildNewsletterContent()),
                const SizedBox(width: 30),
                Expanded(child: _buildNewsletterInput()),
              ],
            ),
    );
  }

  Widget _buildNewsletterContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(
              Icons.notifications_active,
              color: TempleColors.saffron,
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              'Stay Connected',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: TempleColors.primaryBrown,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Subscribe to receive temple updates, event notifications, and spiritual wisdom.',
          style: TextStyle(
            fontSize: 14,
            color: TempleColors.secondaryBrown,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildNewsletterInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: TempleColors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: TempleColors.saffronLight(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: TempleColors.warmGold,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                TempleColors.saffron,
                TempleColors.goldenSaffron,
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: TempleColors.saffronLight(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: TempleColors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          Text(
            '© 2025 Haridra Ganesh Temple',
            style: TextStyle(
              color: TempleColors.secondaryBrown,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Made with ',
                style: TextStyle(
                  color: TempleColors.secondaryBrown,
                  fontSize: 13,
                ),
              ),
              const Icon(
                Icons.favorite,
                color: TempleColors.accentRed,
                size: 14,
              ),
              Text(
                ' in Indore',
                style: TextStyle(
                  color: TempleColors.secondaryBrown,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '© 2025 Haridra Ganesh Temple. All rights reserved.',
          style: TextStyle(
            color: TempleColors.secondaryBrown,
            fontSize: 13,
          ),
        ),
        Row(
          children: [
            Text(
              'Made with ',
              style: TextStyle(
                color: TempleColors.secondaryBrown,
                fontSize: 13,
              ),
            ),
            const Icon(
              Icons.favorite,
              color: TempleColors.accentRed,
              size: 14,
            ),
            Text(
              ' in Indore',
              style: TextStyle(
                color: TempleColors.secondaryBrown,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: TempleColors.primaryBrown,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return _AnimatedIconButton(
      icon: icon,
      onTap: () {},
    );
  }

  Widget _buildFooterLink(String text, IconData icon) {
    return _AnimatedFooterLink(
      text: text,
      icon: icon,
      onTap: () {},
    );
  }

  Widget _buildTimingCard(String label, String time, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TempleColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: TempleColors.warmGoldLight(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: TempleColors.lightPeach,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: TempleColors.saffron,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: TempleColors.primaryBrown,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: TempleColors.secondaryBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: TempleColors.lightPeach,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: TempleColors.saffron,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: TempleColors.secondaryBrown,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AnimatedIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  State<_AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<_AnimatedIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: _isHovered
              ? const LinearGradient(
                  colors: [TempleColors.saffron, TempleColors.goldenSaffron],
                )
              : null,
          color: _isHovered ? null : TempleColors.lightPeach,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: TempleColors.saffronLight(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Icon(
          widget.icon,
          color: _isHovered ? TempleColors.white : TempleColors.saffron,
          size: 18,
        ),
      ),
    );
  }
}

class _AnimatedFooterLink extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _AnimatedFooterLink({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_AnimatedFooterLink> createState() => _AnimatedFooterLinkState();
}

class _AnimatedFooterLinkState extends State<_AnimatedFooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isHovered ? 20 : 0,
                child: Icon(
                  widget.icon,
                  size: 14,
                  color: TempleColors.saffron,
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 14,
                  color: _isHovered
                      ? TempleColors.saffron
                      : TempleColors.secondaryBrown,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
                  height: 1.5,
                ),
                child: Text(widget.text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _AnimatedButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isHovered
                ? [TempleColors.goldenSaffron, TempleColors.saffron]
                : [TempleColors.saffron, TempleColors.goldenSaffron],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: TempleColors.saffronLight(_isHovered ? 0.4 : 0.2),
              blurRadius: _isHovered ? 16 : 10,
              offset: Offset(0, _isHovered ? 6 : 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    color: TempleColors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: TempleColors.white,
                      fontSize: 14,
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
}
