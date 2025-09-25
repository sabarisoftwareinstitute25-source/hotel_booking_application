import 'package:flutter/material.dart';

import '../signup_screen/signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding1.jpg",
      "title": "Your Perfect Stay \n Starts Here",
      "desc":
          "Step into a world of unforgettable stays. Discover comfort, luxury, and adventure like never before—your journey begins here.",
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Effortless Booking for Exceptional Stays",
      "desc": "From budget to luxury, discover stays tailored to your needs.",
    },
    {
      "image": "assets/images/onboarding4.png",
      "title": "More Than a Stay, It’s an Experience",
      "desc": "Fast, secure, and hassle-free booking experience awaits you.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 3),
        curve: Curves.easeInOut,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                            height: h * 0.32,
                            width: h * 0.32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white24,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                onboardingData[index]["image"]!,
                                fit: BoxFit.cover,
                                width: h * 0.32,
                                height: h * 0.32,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 600),
                            child: Text(
                              onboardingData[index]["title"]!,
                              key: ValueKey(index),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: w * 0.065,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 600),
                            opacity: currentIndex == index ? 1 : 0,
                            child: Text(
                              onboardingData[index]["desc"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: w * 0.045,
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: const EdgeInsets.all(6),
                    height: 12,
                    width: currentIndex == index ? 30 : 12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: currentIndex == index
                            ? [Colors.white, Colors.white]
                            : [Colors.white, Colors.white],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: currentIndex == index
                          ? [
                              const BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    minimumSize: Size(double.infinity, h * 0.07),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (currentIndex == onboardingData.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    currentIndex == onboardingData.length - 1
                        ? "Start Exploring"
                        : "Next",
                    style: TextStyle(fontSize: w * 0.05),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}




