import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/format.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/routes/route_path.dart';

class HistoryCard extends StatelessWidget {
  final DiagnosisHistoryEntity history;

  const HistoryCard({super.key, required this.history});

  String get _result => history.result.toLowerCase();

  Color get _cardColor {
    if (_result.contains('sangat tinggi') || _result.contains('tinggi')) {
      return AppColors.cardRed;
    }
    if (_result.contains('sedang') || _result.contains('waspada')) {
      return AppColors.cardYellow;
    }
    return AppColors.cardGreen;
  }

  Color get _accentColor {
    if (_result.contains('sangat tinggi') || _result.contains('tinggi')) {
      return AppColors.primaryRed;
    }
    if (_result.contains('sedang') || _result.contains('waspada')) {
      return AppColors.primaryYellow;
    }
    return AppColors.primaryGreen;
  }

  IconData get _statusIcon {
    if (_result.contains('sangat tinggi')) {
      return Icons.error_rounded;
    }
    if (_result.contains('tinggi')) {
      return Icons.warning_rounded;
    }
    if (_result.contains('sedang') || _result.contains('waspada')) {
      return Icons.info_rounded;
    }
    return Icons.check_circle_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RoutePath.historyDetail, extra: history);
      },
      child: Container(
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: IntrinsicHeight(
          // ✅ PENTING
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// LEFT ACCENT
              Container(
                width: 6,
                decoration: BoxDecoration(
                  color: _accentColor,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(18),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// HEADER
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// ICON
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _accentColor.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _statusIcon,
                              color: _accentColor,
                              size: 20,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  history.category,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkGray,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formatDate(history.createdAt),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: AppColors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      /// RESULT
                      Text(
                        history.result,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mediumGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
