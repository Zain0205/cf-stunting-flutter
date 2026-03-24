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
}

/// Minimal bottom sheet with dot indicator, CTA, and "already have account" link.
class OnboardingBottomBar extends StatelessWidget {
  final int currentPage;
  final int total;
  final bool isLast;
  final OnboardingSlide slide;
  final VoidCallback onNext;
  final VoidCallback onLogin;
  final VoidCallback onSkip;

  const OnboardingBottomBar({
    super.key,
    required this.currentPage,
    required this.total,
    required this.isLast,
    required this.slide,
    required this.onNext,
    required this.onLogin,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final r = _R(context);
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(24, r.sp(14), 24, r.sp(10) + bottomPad),
      decoration: BoxDecoration(
        // Soft off-white — warm, not stark
        color: const Color(0xFFF7F8FA),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 28,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Dot indicator + step label ──
          Row(
            children: [
              Text(
                'Langkah ${currentPage + 1} dari $total',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(11),
                  color: Colors.grey.shade400,
                ),
              ),
              const Spacer(),
              _DotIndicator(
                current: currentPage,
                total: total,
                color: slide.accent,
              ),
            ],
          ),

          SizedBox(height: r.sp(12)),

          // ── CTA button ──
          _CtaButton(slide: slide, isLast: isLast, r: r, onTap: onNext),

          SizedBox(height: r.sp(r.isSmall ? 8 : 12)),

          // ── Divider ──
          Row(
            children: [
              Expanded(
                child: Divider(color: Colors.grey.shade200, thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'atau',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(11.5),
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              Expanded(
                child: Divider(color: Colors.grey.shade200, thickness: 1),
              ),
            ],
          ),

          SizedBox(height: r.sp(r.isSmall ? 8 : 12)),

          // ── Login link ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sudah punya akun?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onLogin,
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(12.5),
                    fontWeight: FontWeight.w700,
                    color: slide.accent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Dot indicator ─────────────────────────────────────────────────────────────

class _DotIndicator extends StatelessWidget {
  final int current;
  final int total;
  final Color color;
  const _DotIndicator({
    required this.current,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: List.generate(total, (i) {
      final active = i == current;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: active ? 20 : 6,
        height: 6,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: active ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(3),
        ),
      );
    }),
  );
}

// ── CTA button ────────────────────────────────────────────────────────────────

class _CtaButton extends StatefulWidget {
  final OnboardingSlide slide;
  final bool isLast;
  final _R r;
  final VoidCallback onTap;
  const _CtaButton({
    required this.slide,
    required this.isLast,
    required this.r,
    required this.onTap,
  });

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: r.isSmall ? 50 : 54,
          decoration: BoxDecoration(
            color: widget.slide.accent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.slide.accent.withOpacity(0.28),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.isLast ? 'Mulai Sekarang' : 'Lanjut',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(14.5),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.isLast
                      ? Icons.rocket_launch_rounded
                      : Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
