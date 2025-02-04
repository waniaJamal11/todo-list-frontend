import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF80C9FF), Color.fromARGB(255, 238, 216, 220)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AnimatedSplashScreen(
          duration: 4000,
          splash: Column(
            children: [
              Center(
                  child:
                      Lottie.asset('assets/animation/splash_Animation.json')),
              SizedBox(height: 20),
              Text(
                'Todo Tracker',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 33, 123, 150),
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          splashIconSize: 500,
          nextScreen: const HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
