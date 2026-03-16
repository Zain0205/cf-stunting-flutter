import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/core/widget/confirmation_dialog.dart';
import 'package:mobile_flutter/core/widget/info_chip.dart';
import 'package:mobile_flutter/core/widget/loading_dialog.dart';
import 'package:mobile_flutter/core/widget/stat_item.dart';
import 'package:mobile_flutter/core/widget/user_avatar.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/auth_shared_provider.dart';
import 'package:mobile_flutter/routes/route_path.dart';

import 'logout_button.dart';

/// Top header section displaying greeting, user info, stats row.
class HeaderSection extends ConsumerWidget {
  final dynamic user;
  final ResponsiveHelper r;

  const HeaderSection({super.key, required this.user, required this.r});

  // ── helpers ──────────────────────────────────────────────

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

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat Pagi';
    if (hour < 15) return 'Selamat Siang';
    if (hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  void _onLogout(BuildContext context, WidgetRef ref) {
    ConfirmationDialog.show(
      context: context,
      title: 'Logout',
      message: 'Apakah kamu yakin ingin keluar?',
      confirmText: 'Ya, keluar',
      cancelText: 'Batal',
      icon: Icons.logout,
      iconColor: AppColors.danger,
      onConfirm: () async {
        final logoutUsecase = ref.read(logoutUsaseProvider);
        LoadingDialog.show(context);
        final result = await logoutUsecase();
        if (!context.mounted) return;
        LoadingDialog.hide(context);
        result.fold(
          (failure) => _showErrorSnackbar(context, failure.message),
          (_) => context.go(RoutePath.splash),
        );
      },
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
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
                message,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.danger,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 6,
      ),
    );
  }

  // ── build ─────────────────────────────────────────────────

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = user?.name ?? 'Pengguna';
    final category = _categoryLabel(user?.category);
    final phone = user?.phone ?? '-';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.headerStart, AppColors.headerEnd],
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
              _TopRow(
                name: name,
                category: category,
                phone: phone,
                greeting: _greeting,
                r: r,
                onLogout: () => _onLogout(context, ref),
              ),
              SizedBox(height: r.sp(20)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _TopRow extends StatelessWidget {
  final String name;
  final String category;
  final String phone;
  final String greeting;
  final ResponsiveHelper r;
  final VoidCallback onLogout;

  const _TopRow({
    required this.name,
    required this.category,
    required this.phone,
    required this.greeting,
    required this.r,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _UserInfo(
            name: name,
            category: category,
            phone: phone,
            greeting: greeting,
            r: r,
          ),
        ),
        SizedBox(width: r.sp(10)),
        Column(
          children: [
            UserAvatar(name: name, r: r),
            SizedBox(height: r.sp(10)),
            LogoutButton(r: r, onTap: onLogout),
          ],
        ),
      ],
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String name;
  final String category;
  final String phone;
  final String greeting;
  final ResponsiveHelper r;

  const _UserInfo({
    required this.name,
    required this.category,
    required this.phone,
    required this.greeting,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _GreetingChip(greeting: greeting, r: r),
        SizedBox(height: r.sp(8)),
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
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            InfoChip(icon: Icons.category_rounded, label: category, r: r),
            InfoChip(icon: Icons.phone_iphone_rounded, label: phone, r: r),
          ],
        ),
      ],
    );
  }
}

class _GreetingChip extends StatelessWidget {
  final String greeting;
  final ResponsiveHelper r;

  const _GreetingChip({required this.greeting, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.35),
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
    );
  }
}
