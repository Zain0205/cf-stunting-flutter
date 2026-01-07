import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/state/auth_user_provider.dart';
import 'package:mobile_flutter/core/widget/primary_button.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/provider/quisioner_provider.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/empty/w_home_empty.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/profile_card.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history_card.dart';
import 'package:mobile_flutter/routes/route_path.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    /// 🔥 paksa fetch ulang setiap HomeScreen dibuka
    Future.microtask(() {
      ref.invalidate(diagnosisHistoryProvider);
    });
  }

  Future<void> _handleRefresh() async {
    ref.invalidate(diagnosisHistoryProvider);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authUserProvider);
    final historyAsync = ref.watch(diagnosisHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// PROFILE
                ProfileCard(
                  name: user?.name ?? "Nama",
                  category: user?.category ?? "Kategori",
                  phone: user?.phone ?? "No. Telp",
                ),

                const SizedBox(height: 50),

                /// HISTORY SECTION
                Expanded(
                  child: historyAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Center(child: Text(error.toString())),
                    data: (histories) {
                      if (histories.isEmpty) {
                        return const WHomeEmpty();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// HEADER HISTORY
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "History",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkestBlue,
                                  ),
                                ),
                                SizedBox(
                                  width: 110,
                                  child: PrimaryButton(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    fontSize: 12,
                                    borderRadius: 12,
                                    btnReverse: true,
                                    onTap: () {
                                      context.push(RoutePath.quisioner);
                                    },
                                    textButton: "Skrining",
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// LIST HISTORY
                          Expanded(
                            child: ListView.separated(
                              itemCount: histories.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 25),
                              itemBuilder: (context, index) {
                                return HistoryCard(history: histories[index]);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
