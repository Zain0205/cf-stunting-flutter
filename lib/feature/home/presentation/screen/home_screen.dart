import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile_flutter/core/widget/confirmation_dialog.dart';
import 'package:mobile_flutter/core/widget/loading_dialog.dart';
import 'package:mobile_flutter/core/state/auth_user_provider.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/auth_shared_provider.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/provider/quisioner_provider.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/empty/w_home_empty.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history_card.dart';
import 'package:mobile_flutter/routes/route_path.dart';

// ─────────────────────────────────────────────
// RESPONSIVE HELPER
// ─────────────────────────────────────────────
class _R {
  final double w;
  final double h;
  _R(BuildContext context)
    : w = MediaQuery.of(context).size.width,
      h = MediaQuery.of(context).size.height;
  double fs(double size) => (size * w / 390).clamp(size * 0.78, size * 1.18);
  double sp(double size) => (size * h / 844).clamp(size * 0.58, size * 1.22);
  bool get isSmall => h < 680;
  bool get isTiny => h < 600;
}

// ─────────────────────────────────────────────
// CAROUSEL DATA MODEL
// ─────────────────────────────────────────────
class _CarouselItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String tag;

  const _CarouselItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.tag,
  });
}

const _carouselItems = [
  _CarouselItem(
    tag: 'Stunting',
    title: 'Cegah Stunting\nSejak Dini',
    subtitle:
        'Pastikan asupan gizi seimbang untuk tumbuh kembang optimal si kecil.',
    icon: Icons.child_care_rounded,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
  ),
  _CarouselItem(
    tag: 'Nutrisi',
    title: 'Penuhi Gizi\n1000 HPK',
    subtitle:
        '1000 Hari Pertama Kehidupan adalah masa emas yang menentukan masa depan.',
    icon: Icons.lunch_dining_rounded,
    gradient: [Color(0xFF059669), Color(0xFF047857)],
  ),
  _CarouselItem(
    tag: 'ASI',
    title: 'Pemberian ASI\nEksklusif',
    subtitle:
        'ASI adalah nutrisi terbaik untuk bayi hingga usia 6 bulan pertama.',
    icon: Icons.favorite_rounded,
    gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
  ),
  _CarouselItem(
    tag: 'Posyandu',
    title: 'Rutin ke\nPosyandu',
    subtitle:
        'Pantau tumbuh kembang anak secara berkala bersama tenaga kesehatan.',
    icon: Icons.local_hospital_rounded,
    gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
  ),
  _CarouselItem(
    tag: 'Sanitasi',
    title: 'Jaga Kebersihan\n& Sanitasi',
    subtitle:
        'Cuci tangan pakai sabun dan jaga sanitasi lingkungan agar anak sehat.',
    icon: Icons.wash_rounded,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
  ),
];

// ─────────────────────────────────────────────
// HOME SCREEN
// ─────────────────────────────────────────────
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

  void _onSkriningTap(List histories) {
    if (histories.isEmpty) {
      context.push(RoutePath.quisioner);
      return;
    }
    final lastDate = histories.first.createdAt;
    final nextAvailable = lastDate.add(const Duration(days: 7));
    final now = DateTime.now();

    if (now.isBefore(nextAvailable)) {
      final d = nextAvailable;
      final formatted =
          "${d.day.toString().padLeft(2, '0')}-"
          "${d.month.toString().padLeft(2, '0')}-"
          "${d.year}";
      ConfirmationDialog.show(
        context: context,
        title: "Belum Bisa Skrining",
        message:
            "Anda hanya dapat melakukan skrining 1 kali dalam 7 hari.\n\n"
            "Silakan lakukan skrining kembali pada tanggal $formatted.",
        confirmText: "Mengerti",
        cancelText: "Tutup",
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
    final r = _R(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: const Color(0xFF3B82F6),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // ── HEADER ──
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _headerFade,
                child: SlideTransition(
                  position: _headerSlide,
                  child: _HeaderSection(user: user, r: r),
                ),
              ),
            ),

            // ── CAROUSEL ──
            SliverToBoxAdapter(
              child: _CarouselSection(
                controller: _carouselController,
                currentIndex: _currentCarouselIndex,
                r: r,
                onPageChanged: (i) => setState(() => _currentCarouselIndex = i),
              ),
            ),

            // ── HISTORY ──
            SliverToBoxAdapter(
              child: historyAsync.when(
                loading: () => _HistoryLoadingShimmer(r: r),
                error: (e, _) => _ErrorCard(message: e.toString(), r: r),
                data: (histories) => _HistorySection(
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

// ─────────────────────────────────────────────
// HEADER SECTION  (with logout button)
// ─────────────────────────────────────────────
class _HeaderSection extends ConsumerWidget {
  final dynamic user;
  final _R r;

  const _HeaderSection({required this.user, required this.r});

  String _categoryLabel(String? raw) {
    switch (raw) {
      case 'PRAKONSEPSI':
        return 'Prakonsepsi';
      case 'PERNAH_MELAHIRKAN':
        return 'Pernah Melahirkan';
      case 'REMAJA_19':
        return 'Remaja ≥19 Tahun';
      default:
        return raw ?? 'Kategori';
    }
  }

  /// ── LOGOUT LOGIC (preserved from original ProfileCard._ActionButton) ──
  void _onLogout(BuildContext context, WidgetRef ref) {
    ConfirmationDialog.show(
      context: context,
      title: 'Logout',
      message: 'Apakah kamu yakin ingin keluar?',
      confirmText: 'Ya, keluar',
      cancelText: 'Batal',
      icon: Icons.logout,
      iconColor: const Color(0xFFEF4444),
      onConfirm: () async {
        final logoutUsecase = ref.read(logoutUsaseProvider);
        LoadingDialog.show(context);
        final result = await logoutUsecase();
        if (!context.mounted) return;
        LoadingDialog.hide(context);
        result.fold((failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      failure.message,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFFEF4444),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              elevation: 6,
            ),
          );
        }, (_) => context.go(RoutePath.splash));
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = user?.name ?? 'Pengguna';
    final category = _categoryLabel(user?.category);
    final phone = user?.phone ?? '-';
    final hour = DateTime.now().hour;
    final greeting = hour < 11
        ? 'Selamat Pagi'
        : hour < 15
        ? 'Selamat Siang'
        : hour < 18
        ? 'Selamat Sore'
        : 'Selamat Malam';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, r.sp(16), 20, r.sp(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── TOP ROW: greeting + LOGOUT BUTTON ──
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: greeting chip + name + chips
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Greeting chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withOpacity(0.20),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF3B82F6).withOpacity(0.35),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('👋', style: TextStyle(fontSize: 11)),
                              const SizedBox(width: 5),
                              Text(
                                greeting,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(10.5),
                                  color: const Color(0xFF93C5FD),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: r.sp(8)),

                        // Name
                        Text(
                          name,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(r.isSmall ? 20 : 23),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.4,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: r.sp(6)),

                        // Category + phone chips
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            _InfoChip(
                              icon: Icons.category_rounded,
                              label: category,
                              r: r,
                            ),
                            _InfoChip(
                              icon: Icons.phone_iphone_rounded,
                              label: phone,
                              r: r,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: r.sp(10)),

                  // Right: Avatar + Logout stacked
                  Column(
                    children: [
                      // Avatar
                      _AvatarWidget(name: name, r: r),
                      SizedBox(height: r.sp(10)),

                      // ── LOGOUT BUTTON ──
                      GestureDetector(
                        onTap: () => _onLogout(context, ref),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: r.sp(10),
                            vertical: r.sp(6),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFEF4444).withOpacity(0.35),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                size: r.isSmall ? 13 : 14,
                                color: const Color(0xFFFCA5A5),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(11),
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFFCA5A5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: r.sp(20)),

              // ── STATS ROW ──
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.sp(16),
                  vertical: r.sp(14),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.10),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    _StatItem(
                      icon: Icons.monitor_heart_rounded,
                      label: 'Skrining',
                      value: 'Aktif',
                      color: const Color(0xFF34D399),
                      r: r,
                    ),
                    _VerticalDivider(),
                    _StatItem(
                      icon: Icons.calendar_today_rounded,
                      label: 'Jadwal',
                      value: '7 Hari',
                      color: const Color(0xFF60A5FA),
                      r: r,
                    ),
                    _VerticalDivider(),
                    _StatItem(
                      icon: Icons.shield_rounded,
                      label: 'Proteksi',
                      value: 'Penuh',
                      color: const Color(0xFFA78BFA),
                      r: r,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SHARED SMALL WIDGETS
// ─────────────────────────────────────────────
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final _R r;

  const _InfoChip({required this.icon, required this.label, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: Colors.white60),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(10),
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  final String name;
  final _R r;

  const _AvatarWidget({required this.name, required this.r});

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().isNotEmpty
        ? name.trim().split(' ').take(2).map((e) => e[0].toUpperCase()).join()
        : 'U';

    return Container(
      width: r.isSmall ? 50 : 58,
      height: r.isSmall ? 50 : 58,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.40),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(r.isSmall ? 15 : 18),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final _R r;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: r.isSmall ? 16 : 18, color: color),
          SizedBox(height: r.sp(4)),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(12),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9.5),
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 36, color: Colors.white.withOpacity(0.12));
}

// ─────────────────────────────────────────────
// CAROUSEL SECTION
// ─────────────────────────────────────────────
class _CarouselSection extends StatelessWidget {
  final PageController controller;
  final int currentIndex;
  final _R r;
  final ValueChanged<int> onPageChanged;

  const _CarouselSection({
    required this.controller,
    required this.currentIndex,
    required this.r,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = r.isTiny
        ? 140.0
        : r.isSmall
        ? 155.0
        : 172.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, r.sp(20), 20, r.sp(12)),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Edukasi Kesehatan',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(15),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: controller,
            itemCount: _carouselItems.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) => _CarouselCard(
              item: _carouselItems[index],
              r: r,
              height: cardHeight,
            ),
          ),
        ),

        SizedBox(height: r.sp(12)),

        // Dot indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_carouselItems.length, (i) {
            final active = i == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: active ? 20 : 7,
              height: 7,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: active
                    ? _carouselItems[currentIndex].gradient[0]
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _CarouselCard extends StatelessWidget {
  final _CarouselItem item;
  final _R r;
  final double height;

  const _CarouselCard({
    required this.item,
    required this.r,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: item.gradient,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: item.gradient[0].withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.10),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            left: -15,
            bottom: -10,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(r.sp(r.isSmall ? 16 : 20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.22),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.tag,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(9.5),
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      SizedBox(height: r.sp(8)),
                      Text(
                        item.title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(r.isSmall ? 15 : 17),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.25,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: r.sp(6)),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(r.isTiny ? 9.5 : 10.5),
                          color: Colors.white.withOpacity(0.80),
                          height: 1.45,
                        ),
                        maxLines: r.isTiny ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: r.sp(12)),

                Container(
                  width: r.isSmall ? 62 : 70,
                  height: r.isSmall ? 62 : 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    item.icon,
                    size: r.isSmall ? 30 : 34,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HISTORY SECTION
// ─────────────────────────────────────────────
class _HistorySection extends StatelessWidget {
  final List histories;
  final _R r;
  final VoidCallback onSkrining;

  const _HistorySection({
    required this.histories,
    required this.r,
    required this.onSkrining,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, r.sp(6), 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header + skrining button
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Riwayat Skrining',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(15),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onSkrining,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.sp(14),
                    vertical: r.sp(8),
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withOpacity(0.30),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.monitor_heart_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Skrining',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(12),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: r.sp(14)),

          // List or empty
          if (histories.isEmpty)
            const WHomeEmpty()
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: histories.length,
              separatorBuilder: (_, __) => SizedBox(height: r.sp(12)),
              itemBuilder: (context, index) => _ModernHistoryWrapper(
                child: HistoryCard(history: histories[index]),
              ),
            ),
        ],
      ),
    );
  }
}

class _ModernHistoryWrapper extends StatelessWidget {
  final Widget child;
  const _ModernHistoryWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────
// LOADING SHIMMER
// ─────────────────────────────────────────────
class _HistoryLoadingShimmer extends StatefulWidget {
  final _R r;
  const _HistoryLoadingShimmer({required this.r});

  @override
  State<_HistoryLoadingShimmer> createState() => _HistoryLoadingShimmerState();
}

class _HistoryLoadingShimmerState extends State<_HistoryLoadingShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, widget.r.sp(16), 20, 0),
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          final opacity = 0.4 + _anim.value * 0.3;
          return Column(
            children: List.generate(
              3,
              (i) => Container(
                margin: EdgeInsets.only(bottom: widget.r.sp(12)),
                height: 82,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(opacity),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ERROR CARD
// ─────────────────────────────────────────────
class _ErrorCard extends StatelessWidget {
  final String message;
  final _R r;
  const _ErrorCard({required this.message, required this.r});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: r.sp(16)),
      child: Container(
        padding: EdgeInsets.all(r.sp(16)),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFECACA), width: 1),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFEF4444),
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: const Color(0xFFB91C1C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
