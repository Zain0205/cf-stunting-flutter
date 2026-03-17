import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Segmented pill tab selector for the 3 condition tabs.
class TabSelector extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;
  final ResponsiveHelper r;

  const TabSelector({
    super.key,
    required this.activeIndex,
    required this.onTap,
    required this.r,
  });

  static const _tabs = [
    ('🔍', 'Umum'),
    ('🤰', 'Ibu Hamil'),
    ('👶', 'Bayi Baru'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          _tabs.length,
          (i) => Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: _TabItem(
                emoji: _tabs[i].$1,
                label: _tabs[i].$2,
                isActive: i == activeIndex,
                r: r,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isActive;
  final ResponsiveHelper r;

  const _TabItem({
    required this.emoji,
    required this.label,
    required this.isActive,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(vertical: r.sp(10)),
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.30),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          Text(emoji, style: TextStyle(fontSize: r.fs(18))),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(10.5),
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? Colors.white : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
