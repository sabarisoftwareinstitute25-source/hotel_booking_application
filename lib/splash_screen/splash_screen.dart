import 'package:flutter/material.dart';
import 'dart:async';

import '../onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 0.8, curve: Curves.fastOutSlowIn),
          ),
        );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF7E00), Color(0xFFFF0D00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.9],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -MediaQuery.of(context).size.width * 0.2,
              right: -MediaQuery.of(context).size.width * 0.1,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: -MediaQuery.of(context).size.width * 0.3,
              left: -MediaQuery.of(context).size.width * 0.2,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.house,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SlideTransition(
                    position: _slideAnimation,
                    child: Text(
                      "Luxury Hotel",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.10,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.0,
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      "Your Comfort, Our Commitment \n         Book Your Stay Today",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        color: Colors.white.withOpacity(0.9),
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}













