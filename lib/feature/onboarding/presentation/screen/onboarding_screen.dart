import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widget/onboarding_data.dart';
import '../widget/onboarding_bg_painter.dart';
import '../widget/onboarding_bottom_bar.dart';
import '../widget/onboarding_slide_widget.dart';
import '../widget/onboarding_top_bar.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final _pageController = PageController();
  int _currentPage = 0;

  /// Slow-breathing controller — 6s cycle, organic feel.
  late final AnimationController _breathCtrl;

  /// Entry fade+slide on first load.
  late final AnimationController _entryCtrl;
  late final Animation<double> _entryFade;
  late final Animation<Offset> _entrySlide;

  @override
  void initState() {
    super.initState();

    _breathCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat(reverse: true);

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _entryFade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.0, 0.80, curve: Curves.easeOut),
    );

    _entrySlide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _breathCtrl.dispose();
    _entryCtrl.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < onboardingSlides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    } else {
      context.go('/register');
    }
  }

  @override
  Widget build(BuildContext context) {
    final slide = onboardingSlides[_currentPage];
    final isLast = _currentPage == onboardingSlides.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Stack(
        children: [
          // ── Animated background ──────────────────────────────────────
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _breathCtrl,
              builder: (_, __) => CustomPaint(
                painter: OnboardingBgPainter(
                  progress: _breathCtrl.value,
                  accent: slide.accent,
                ),
              ),
            ),
          ),

          // ── Main content ─────────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: FadeTransition(
              opacity: _entryFade,
              child: SlideTransition(
                position: _entrySlide,
                child: Column(
                  children: [
                    // Top bar
                    OnboardingTopBar(
                      slide: slide,
                      showSkip: !isLast,
                      onSkip: () => context.go('/register'),
                    ),

                    // Page view — takes all available space above bottom bar
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: onboardingSlides.length,
                        onPageChanged: (i) => setState(() => _currentPage = i),
                        itemBuilder: (_, index) => OnboardingSlideWidget(
                          slide: onboardingSlides[index],
                          breathCtrl: _breathCtrl,
                        ),
                      ),
                    ),

                    // Bottom controls — sits on top of the white panel
                    OnboardingBottomBar(
                      currentPage: _currentPage,
                      total: onboardingSlides.length,
                      isLast: isLast,
                      slide: slide,
                      onNext: _nextPage,
                      onLogin: () => context.go('/login'),
                      onSkip: () => context.go('/register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
