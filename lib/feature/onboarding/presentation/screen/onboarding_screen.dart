import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_flutter/core/widget/primary_button.dart';
import 'package:mobile_flutter/feature/onboarding/presentation/widget/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int currentPage = 0;

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Eat Healthy',
      description:
          'Maintaining good health should be the primary focus of everyone.',
      image: 'assets/images/img_empty.png',
    ),
    OnboardingItem(
      title: 'Healthy Recipes',
      description:
          'Browse thousands of healthy recipes from all over the world.',
      image: 'assets/images/img_empty.png',
    ),
    OnboardingItem(
      title: 'Healthy Recipes',
      description:
          'Browse thousands of healthy recipes from all over the world.',
      image: 'assets/images/img_empty.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Center(
              child: Text(
                "Stunting Screening",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBase,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: onboardingItems.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (conte, index) =>
                    OnboardingPage(item: onboardingItems[index]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: onboardingItems.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primaryBase,
                      dotColor: AppColors.grey,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: PrimaryButton(
                      textButton: "Get Started",
                      onTap: () {
                        context.push('/register');
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          context.push('/login');
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: AppColors.primaryBase),
                        ),
                      ),
                    ],
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
