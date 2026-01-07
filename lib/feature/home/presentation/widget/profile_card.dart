import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String category;
  final String phone;

  const ProfileCard({
    super.key,
    required this.name,
    required this.category,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: .12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _Header(name: name, category: category),
          _Body(phone: phone),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String name;
  final String category;

  const _Header({required this.name, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          const _AvatarLarge(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                _CategoryBadge(category),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarLarge extends StatelessWidget {
  const _AvatarLarge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: .2),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: AppColors.white, size: 30),
    );
  }
}

class _Body extends StatelessWidget {
  final String phone;

  const _Body({required this.phone});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Row(
              children: [
                const Icon(Icons.phone, color: AppColors.primaryBase),
                const SizedBox(width: 8),
                Text(
                  phone,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            _ActionButton(),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightPrimaryBase,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          Icon(Icons.logout, size: 16, color: AppColors.primaryBase),
          SizedBox(width: 4),
          Text(
            "Logout",
            style: TextStyle(
              color: AppColors.primaryBase,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String category;

  const _CategoryBadge(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lightPrimaryBase,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.primaryBase,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
