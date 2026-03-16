import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

import 'package:mobile_flutter/core/widget/confirmation_dialog.dart';
import 'package:mobile_flutter/core/state/auth_user_provider.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/provider/quisioner_provider.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/carousel_section.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/error/error_card.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/header_section.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history_section.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/shimmer/history_loading_shimmer.dart';
import 'package:mobile_flutter/routes/route_path.dart';

/// Main home screen.
///
/// Composed of three distinct sections:
/// - [HeaderSection] — user greeting, stats, logout
/// - [CarouselSection] — health education carousel
/// - [HistorySection] — screening history list
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _carouselController = PageController(viewportFraction: 0.88);
  int _currentCarouselIndex = 0;

  late final AnimationController _headerController;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.invalidate(diagnosisHistoryProvider));
    _setupHeaderAnimation();
  }

  void _setupHeaderAnimation() {
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _headerFade = CurvedAnimation(
      parent: _headerController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );

    _headerSlide =
        Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _headerController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  @override
  void dispose() {
    _carouselController.dispose();
    _headerController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    ref.invalidate(diagnosisHistoryProvider);
  }

  /// Navigates to questionnaire or shows a cooldown dialog.
  void _onSkriningTap(List histories) {
    if (histories.isEmpty) {
      context.push(RoutePath.quisioner);
      return;
    }

    final nextAvailable = histories.first.createdAt.add(
      const Duration(days: 7),
    );

    if (DateTime.now().isBefore(nextAvailable)) {
      final d = nextAvailable;
      final formatted =
          '${d.day.toString().padLeft(2, '0')}-'
          '${d.month.toString().padLeft(2, '0')}-'
          '${d.year}';

      ConfirmationDialog.show(
        context: context,
        title: 'Belum Bisa Skrining',
        message:
            'Anda hanya dapat melakukan skrining 1 kali dalam 7 hari.\n\n'
            'Silakan lakukan skrining kembali pada tanggal $formatted.',
        confirmText: 'Mengerti',
        cancelText: 'Tutup',
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.orange,
      );
      return;
    }

    context.push(RoutePath.quisioner);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authUserProvider);
    final historyAsync = ref.watch(diagnosisHistoryProvider);
    final r = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _headerFade,
                child: SlideTransition(
                  position: _headerSlide,
                  child: HeaderSection(user: user, r: r),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CarouselSection(
                controller: _carouselController,
                currentIndex: _currentCarouselIndex,
                r: r,
                onPageChanged: (i) => setState(() => _currentCarouselIndex = i),
              ),
            ),
            SliverToBoxAdapter(
              child: historyAsync.when(
                loading: () => HistoryLoadingShimmer(r: r),
                error: (e, _) => ErrorCard(message: e.toString(), r: r),
                data: (histories) => HistorySection(
                  histories: histories,
                  r: r,
                  onSkrining: () => _onSkriningTap(histories),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: r.sp(32))),
          ],
        ),
      ),
    );
  }
}
