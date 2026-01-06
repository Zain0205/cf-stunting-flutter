import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/empty/w_home_empty.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/profile_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // simulasi data
  final bool isDataEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileCard(
                name: 'Ibu Siti',
                category: 'Ibu Hamil',
                phone: '0812-3456-7890',
              ),
              const SizedBox(height: 24),
              Expanded(
                child: isDataEmpty
                    ? const WHomeEmpty()
                    : const SizedBox(), // nanti ganti list / chart
              ),
            ],
          ),
        ),
      ),
    );
  }
}
