import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

import 'package:mobile_flutter/core/state/auth_user_provider.dart';
import 'package:mobile_flutter/core/widget/loading_dialog.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/provider/quisioner_provider.dart';
import 'package:mobile_flutter/routes/route_path.dart';

/// Info card + animated submit button.
/// Handles validation, loading dialog, and navigation on success.
class SubmitButton extends ConsumerStatefulWidget {
  final ResponsiveHelper r;

  const SubmitButton({super.key, required this.r});

  @override
  ConsumerState<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends ConsumerState<SubmitButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _showSnack(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError
                  ? Icons.error_outline_rounded
                  : Icons.check_circle_outline,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                msg,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError
            ? const Color(0xFFEF4444)
            : const Color(0xFF22C55E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 6,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _onSubmit() async {
    _ctrl.reverse();
    final answers = ref.read(answerStateProvider.notifier).answers;
    final user = ref.read(authUserProvider);

    if (user == null) {
      _showSnack('Harap login terlebih dahulu');
      return;
    }
    if (answers.isEmpty) {
      _showSnack('Harap isi kuesioner terlebih dahulu');
      return;
    }

    await ref
        .read(diagnosisProvider.notifier)
        .submit(category: user.category, answers: answers);
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;

    ref.listen<AsyncValue>(diagnosisProvider, (_, next) {
      next.when(
        loading: () => LoadingDialog.show(context),
        data: (data) {
          LoadingDialog.hide(context);
          if (data != null) {
            ref.invalidate(diagnosisHistoryProvider);
            context.go(RoutePath.mainNavigation);
          }
        },
        error: (error, _) {
          LoadingDialog.hide(context);
          _showSnack(error.toString());
        },
      );
    });

    return Padding(
      padding: EdgeInsets.only(top: r.sp(8)),
      child: Column(
        children: [
          _InfoCard(r: r),
          SizedBox(height: r.sp(14)),
          _SubmitBtn(r: r, ctrl: _ctrl, scale: _scale, onTap: _onSubmit),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final ResponsiveHelper r;
  const _InfoCard({required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(r.sp(14)),
    decoration: BoxDecoration(
      color: const Color(0xFFEFF6FF),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFBFDBFE), width: 1),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.lightbulb_outline_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Pastikan semua pertanyaan telah dijawab sebelum memproses hasil skrining.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(11.5),
              color: const Color(0xFF1E40AF),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SubmitBtn extends StatelessWidget {
  final ResponsiveHelper r;
  final AnimationController ctrl;
  final Animation<double> scale;
  final VoidCallback onTap;

  const _SubmitBtn({
    required this.r,
    required this.ctrl,
    required this.scale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTapDown: (_) => ctrl.forward(),
    onTapUp: (_) => onTap(),
    onTapCancel: () => ctrl.reverse(),
    child: ScaleTransition(
      scale: scale,
      child: Container(
        height: r.isSmall ? 52 : 58,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.40),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.analytics_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              'Proses Hasil Skrining',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(15),
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
