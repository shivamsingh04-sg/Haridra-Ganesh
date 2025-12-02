import 'package:flutter/material.dart';

class TempleFooter extends StatelessWidget {
  const TempleFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF2C3E50),
            const Color(0xFF1A252F),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // About Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Haridra Ganesh Temple',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'A sacred place of worship dedicated to Lord Ganesh, '
                        'known for its unique turmeric-covered idol.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _buildSocialIcon(Icons.facebook),
                          const SizedBox(width: 10),
                          _buildSocialIcon(Icons.camera_alt),
                          const SizedBox(width: 10),
                          _buildSocialIcon(Icons.video_library),
                          const SizedBox(width: 10),
                          _buildSocialIcon(Icons.message),
                        ],
                      ),
                    ],
                  ),
                ),

                // Quick Links
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Links',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFooterLink('About Us'),
                      _buildFooterLink('Pooja Services'),
                      _buildFooterLink('Donations'),
                      _buildFooterLink('Events Calendar'),
                      _buildFooterLink('Gallery'),
                      _buildFooterLink('Contact Us'),
                    ],
                  ),
                ),

                // Timings
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Temple Timings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTimingRow('Morning', '6:00 AM - 12:00 PM'),
                      _buildTimingRow('Evening', '4:00 PM - 8:00 PM'),
                      const SizedBox(height: 20),
                      const Text(
                        'Special Days',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildTimingRow('Tuesday', '5:00 AM - 9:00 PM'),
                      _buildTimingRow('Festivals', 'Extended Hours'),
                    ],
                  ),
                ),

                // Contact Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildContactRow(
                        Icons.location_on,
                        'Haridra Ganesh Mandir,\nIndore, Madhya Pradesh',
                      ),
                      const SizedBox(height: 15),
                      _buildContactRow(
                        Icons.phone,
                        '+91 1234567890',
                      ),
                      const SizedBox(height: 15),
                      _buildContactRow(
                        Icons.email,
                        'info@haridraganesh.org',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Copyright Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey[700]!,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '© 2025 Haridra Ganesh Temple. All rights reserved.',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  '|',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Text(
                  'Made with ',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 16,
                ),
                Text(
                  ' in Indore',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildTimingRow(String label, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
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
        Icon(
          icon,
          color: const Color(0xFFFF6B35),
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
