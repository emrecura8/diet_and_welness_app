import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/pages/login_page.dart';
import 'package:the_diet_and_welness_app/pages/signup_page.dart';
import 'package:the_diet_and_welness_app/pages/home_page.dart';
import 'package:the_diet_and_welness_app/pages/profile_page.dart';
import 'package:the_diet_and_welness_app/pages/diet_plan_page.dart';
import 'package:the_diet_and_welness_app/pages/exercise_page.dart';
// Import the detail page if you want to add its route here, though not strictly necessary
// import 'package:the_diet_and_welness_app/pages/diet_plan_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet & Wellness App',
      theme: ThemeData(
        fontFamily: 'Lato', // Set default font family
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade800,
          primary: Colors.green.shade800,
          secondary: Colors.teal.shade400,
          surface: Colors.white,
        ),
        useMaterial3: true,
        // Define consistent AppBar theme
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade800,
          foregroundColor: Colors.white,
          elevation: 4.0,
          titleTextStyle: TextStyle(
            fontFamily: 'Lato', // Ensure AppBar uses the font too
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // Define consistent Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.green.shade800),
        ),
        // Define consistent Input Field theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.green.shade800, width: 2.0),
          ),
          labelStyle: TextStyle(color: Colors.grey.shade700),
          floatingLabelStyle: TextStyle(color: Colors.green.shade800),
          prefixIconColor: Colors.grey.shade600,
        ),
        // Define Card theme
        cardTheme: CardTheme(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        ),
        // Define ListTile theme
        listTileTheme: ListTileThemeData(
          iconColor: Colors.green.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        // Add TextTheme if specific fonts are desired later
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      initialRoute: '/login', // Set initial route to login
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/diet': (context) => const DietPlanPage(),
        '/exercise': (context) => const ExercisePage(),
        // Note: Detail pages often use direct navigation (MaterialPageRoute)
        // instead of named routes if they require complex arguments like objects.
      },
    );
  }
}
