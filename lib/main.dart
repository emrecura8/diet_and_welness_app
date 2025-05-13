import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/pages/login_page.dart';
import 'package:the_diet_and_welness_app/pages/signup_page.dart';
import 'package:the_diet_and_welness_app/pages/home_page.dart';
import 'package:the_diet_and_welness_app/pages/profile_page.dart';
import 'package:the_diet_and_welness_app/pages/diet_plan_page.dart';
import 'package:the_diet_and_welness_app/pages/exercise_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_diet_and_welness_app/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:the_diet_and_welness_app/provider/auth_service.dart';
import 'package:the_diet_and_welness_app/provider/exercise_service.dart';
import 'package:the_diet_and_welness_app/provider/diet_service.dart';
import 'package:the_diet_and_welness_app/provider/user_profile_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ExerciseService()),
        ChangeNotifierProvider(create: (_) => DietService()),
        ChangeNotifierProvider(create: (_) => UserProfileService()),
      ],
      child: MaterialApp(
        title: 'Diet & Wellness App',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green.shade800,
            primary: Colors.green.shade800,
            secondary: Colors.teal.shade400,
            surface: Colors.white,
          ),
          useMaterial3: true,

          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.shade800,
            foregroundColor: Colors.white,
            elevation: 4.0,
            titleTextStyle: TextStyle(
              fontFamily: 'Lato',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

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

          cardTheme: CardTheme(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          ),

          listTileTheme: ListTileThemeData(
            iconColor: Colors.green.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/diet': (context) => const DietPlanPage(),
          '/exercise': (context) => const ExercisePage(),
        },
      ),
    );
  }
}
