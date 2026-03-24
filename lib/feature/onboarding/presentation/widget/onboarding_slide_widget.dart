import 'dart:math' as math;
import 'package:flutter/material.dart';
import './onboarding_data.dart';

class _R {
  final double w;
  final double h;
  _R(BuildContext ctx)
    : w = MediaQuery.of(ctx).size.width,
      h = MediaQuery.of(ctx).size.height;
  double fs(double s) => (s * w / 390).clamp(s * 0.78, s * 1.18);
  double sp(double s) => (s * h / 844).clamp(s * 0.58, s * 1.22);
  bool get isSmall => h < 680;
  bool get isTiny => h < 600;
}

/// Single onboarding slide. Uses LayoutBuilder so the illustration card
/// shrinks proportionally — no content overflow on small screens.
class OnboardingSlideWidget extends StatelessWidget {
  final OnboardingSlide slide;
  final AnimationController breathCtrl;

  const OnboardingSlideWidget({
    super.key,
    required this.slide,
    required this.breathCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final r = _R(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availH = constraints.maxHeight;
        // Card = 28% of available height, clamped to sane min/max
        final cardH = (availH * 0.28).clamp(100.0, 190.0);

        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: availH),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: r.sp(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: r.sp(r.isTiny ? 6 : 12)),

                  _IllustrationCard(
                    slide: slide,
                    breathCtrl: breathCtrl,
                    r: r,
                    height: cardH,
                  ),

                  SizedBox(height: r.sp(r.isSmall ? 10 : 16)),

                  _TagChip(slide: slide, r: r),

                  SizedBox(height: r.sp(6)),

                  Text(
                    slide.title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(
                        r.isTiny
                            ? 18
                            : r.isSmall
                            ? 22
                            : 25,
                      ),
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.18,
                      letterSpacing: -0.6,
                    ),
                  ),

                  SizedBox(height: r.sp(8)),

                  Text(
                    slide.body,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(r.isSmall ? 11 : 12.5),
                      color: Colors.white.withOpacity(0.55),
                      height: 1.58,
                      letterSpacing: 0.1,
                    ),
                    maxLines: r.isTiny ? 3 : 5,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: r.sp(r.isSmall ? 10 : 14)),

                  if (slide.stats.isNotEmpty) _StatsRow(slide: slide, r: r),

                  SizedBox(height: r.sp(r.isSmall ? 8 : 10)),

                  if (slide.pills.isNotEmpty) _PillsRow(slide: slide, r: r),

                  SizedBox(height: r.sp(10)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Illustration card ─────────────────────────────────────────────────────────

class _IllustrationCard extends StatelessWidget {
  final OnboardingSlide slide;
  final AnimationController breathCtrl;
  final _R r;
  final double height;

  const _IllustrationCard({
    required this.slide,
    required this.breathCtrl,
    required this.r,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: breathCtrl,
      builder: (_, __) {
        final t = breathCtrl.value;
        final dy = math.sin(t * math.pi * 2) * 4;
        final ringOpacity = 0.14 + math.sin(t * math.pi * 2) * 0.06;

        return Transform.translate(
          offset: Offset(0, dy),
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: slide.accent.withOpacity(0.18),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: slide.accent.withOpacity(0.12),
                  blurRadius: 30,
                  spreadRadius: -4,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Soft inner glow
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: RadialGradient(
                        center: const Alignment(0, -0.2),
                        radius: 0.75,
                        colors: [
                          slide.accent.withOpacity(0.09),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Corner dots
                Positioned(
                  top: 16,
                  right: 20,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: slide.accent.withOpacity(0.30),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 18,
                  left: 22,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: slide.accent.withOpacity(0.20),
                    ),
                  ),
                ),

                // Central emoji inside breathing rings
                Center(
                  child: _BreathingEmoji(
                    emoji: slide.emoji,
                    accent: slide.accent,
                    ringOpacity: ringOpacity,
                    r: r,
                    cardHeight: height,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BreathingEmoji extends StatelessWidget {
  final String emoji;
  final Color accent;
  final double ringOpacity;
  final _R r;
  final double cardHeight;

  const _BreathingEmoji({
    required this.emoji,
    required this.accent,
    required this.ringOpacity,
    required this.r,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    // Scale ring/inner sizes proportionally to card height
    final outerSize = (cardHeight * 0.58).clamp(58.0, 90.0);
    final innerSize = (cardHeight * 0.44).clamp(44.0, 68.0);
    final fontSize = (cardHeight * 0.20).clamp(24.0, 36.0);

    return Container(
      width: outerSize,
      height: outerSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: accent.withOpacity(ringOpacity), width: 1),
      ),
      child: Center(
        child: Container(
          width: innerSize,
          height: innerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: accent.withOpacity(0.11),
            border: Border.all(color: accent.withOpacity(0.20), width: 1),
          ),
          child: Center(
            child: Text(emoji, style: TextStyle(fontSize: fontSize)),
          ),
        ),
      ),
    );
  }
}

// ── Tag chip ──────────────────────────────────────────────────────────────────

class _TagChip extends StatelessWidget {
  final OnboardingSlide slide;
  final _R r;
  const _TagChip({required this.slide, required this.r});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(shape: BoxShape.circle, color: slide.accent),
      ),
      const SizedBox(width: 7),
      Text(
        slide.tag.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(9.5),
          fontWeight: FontWeight.w700,
          color: slide.accent,
          letterSpacing: 1.4,
        ),
      ),
    ],
  );
}

// ── Stats row ─────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final OnboardingSlide slide;
  final _R r;
  const _StatsRow({required this.slide, required this.r});

  @override
  Widget build(BuildContext context) => Row(
    children: slide.stats.asMap().entries.map((e) {
      final isFirst = e.key == 0;
      final stat = e.value;
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: isFirst ? 8 : 0),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: r.sp(12),
              vertical: r.sp(11),
            ),
            decoration: BoxDecoration(
              color: slide.accent.withOpacity(0.07),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: slide.accent.withOpacity(0.13),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.value,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(r.isSmall ? 15 : 17),
                    fontWeight: FontWeight.w800,
                    color: slide.accent,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  stat.label,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(9.5),
                    color: Colors.white.withOpacity(0.42),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}

// ── Pills row ─────────────────────────────────────────────────────────────────

class _PillsRow extends StatelessWidget {
  final OnboardingSlide slide;
  final _R r;
  const _PillsRow({required this.slide, required this.r});

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 7,
    runSpacing: 7,
    children: slide.pills
        .map((pill) => _Pill(pill: pill, slide: slide, r: r))
        .toList(),
  );
}

class _Pill extends StatelessWidget {
  final dynamic pill;
  final OnboardingSlide slide;
  final _R r;
  const _Pill({required this.pill, required this.slide, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: r.sp(10), vertical: r.sp(6)),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.09), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(pill.icon, size: 11, color: slide.accent.withOpacity(0.75)),
        const SizedBox(width: 5),
        Text(
          pill.text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10.5),
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.55),
          ),
        ),
      ],
    ),
  );
}
