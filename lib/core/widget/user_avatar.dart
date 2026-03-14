import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Circular avatar displaying the user's initials (up to 2 letters).
class UserAvatar extends StatelessWidget {
  final String name;
  final ResponsiveHelper r;

  const UserAvatar({super.key, required this.name, required this.r});

  String get _initials {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'U';
    return trimmed.split(' ').take(2).map((e) => e[0].toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    final size = r.isSmall ? 50.0 : 58.0;
    return Container(
      width: size,
      height: size,
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
          _initials,
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
