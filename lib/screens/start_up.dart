import 'package:flutter/material.dart';

class StartUp extends StatefulWidget {
  const StartUp({super.key});

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<_OnboardingPage> pages = [
    _OnboardingPage(
      title: "Welcome to QE Learning",
      description:
          "Learn anytime, anywhere. Access expert lessons offline and level up your skills",
      imageAsset: 'assets/images/logo_final.png',
    ),
    _OnboardingPage(
      title: "Learn Smarter",
      description: "Reliable lessons available whenever you need them.",
      imageAsset: 'assets/images/onboarding1.png',
    ),
    _OnboardingPage(
      title: "Track Your Progress",
      description: "Stay motivated as you learn and improve every day.",
      imageAsset: 'assets/images/onboarding2.png',
    ),
  ];

  void _goToDashboard() {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == pages.length - 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0077BE), Color(0xFF9FD3F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16), // Keeps space where skip was
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: index == 0
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          if (index == 0) const SizedBox(height: 60),
                          Image.asset(
                            page.imageAsset,
                            height: index == 0 ? 300 : 220,
                          ),
                          const SizedBox(height: 40),
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              if (isLastPage)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: _goToDashboard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0077BE),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String title;
  final String description;
  final String imageAsset;

  _OnboardingPage({
    required this.title,
    required this.description,
    required this.imageAsset,
  });
}
