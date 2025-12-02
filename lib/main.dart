import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haridra_ganesh_temple/screens/about_screen.dart';
import 'package:haridra_ganesh_temple/screens/contact_screen.dart';
import 'package:haridra_ganesh_temple/screens/darshan_screen.dart';
import 'package:haridra_ganesh_temple/screens/events_screen.dart';
import 'package:haridra_ganesh_temple/screens/gallery_screen.dart';
import 'package:haridra_ganesh_temple/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haridra Ganesh Temple Indore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFF6B35),
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B35),
          secondary: const Color(0xFFFFC107),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B35),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
        '/darshan': (context) => const DarshanScreen(),
        '/events': (context) => const EventsScreen(),
        '/gallery': (context) => const GalleryScreen(),
        '/contact': (context) => const ContactScreen(),
      },
    );
  }
}
