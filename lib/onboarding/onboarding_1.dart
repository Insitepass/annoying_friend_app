import 'package:flutter/material.dart';

import '../Settings.dart';

class OnboardingPageModel {
  final String title;
  final String description;
  final String image;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
        required this.description,
        required this.image,
        this.bgColor = Colors.white,
        this.textColor = Colors.black87});
}

class OnboardingPage extends StatefulWidget {
  final List<OnboardingPageModel> pages;

  const OnboardingPage({Key? key, required this.pages}) : super(key: key);

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  // Store the currently visible page
  int _currentPage = 0;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Page view to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    // Change current page when page view changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(
                              item.image,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: item.textColor,
                                    )),
                              ),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                      color: item.textColor,
                                    )),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _currentPage == widget.pages.indexOf(item)
                      ? 20
                      : 4,
                  height: 4,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          //TODO Handle Skipping onboarding page
                          Navigator.push(context, MaterialPageRoute(builder:(context) => const Settings()));
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: Colors.black87),
                        )),
                    TextButton(
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          // This is the last page
                          Navigator.push(context, MaterialPageRoute(builder:(context) => const Settings()));
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Text(
                        _currentPage == widget.pages.length - 1
                            ? "Finish"
                            : "Next",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

