import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_flutter/core/resource/format.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/routes/route_path.dart';

class HistoryCard extends StatefulWidget {
  final DiagnosisHistoryEntity history;

  const HistoryCard({super.key, required this.history});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  // ── SEVERITY HELPERS ──────────────────────────────────
  String get _result => widget.history.result.toLowerCase();

  bool get _isCritical => _result.contains('sangat tinggi');

  bool get _isHigh => !_isCritical && _result.contains('tinggi');

  bool get _isMedium =>
      _result.contains('sedang') || _result.contains('waspada');

  _Severity get _severity {
    if (_isCritical) return _Severity.critical;
    if (_isHigh) return _Severity.high;
    if (_isMedium) return _Severity.medium;
    return _Severity.low;
  }

  Color get _accentColor {
    switch (_severity) {
      case _Severity.critical:
        return const Color(0xFFDC2626);
      case _Severity.high:
        return const Color(0xFFEF4444);
      case _Severity.medium:
        return const Color(0xFFF59E0B);
      case _Severity.low:
        return const Color(0xFF059669);
    }
  }

  List<Color> get _badgeGradient {
    switch (_severity) {
      case _Severity.critical:
        return [const Color(0xFFDC2626), const Color(0xFF991B1B)];
      case _Severity.high:
        return [const Color(0xFFEF4444), const Color(0xFFB91C1C)];
      case _Severity.medium:
        return [const Color(0xFFF59E0B), const Color(0xFFD97706)];
      case _Severity.low:
        return [const Color(0xFF059669), const Color(0xFF047857)];
    }
  }

  Color get _bgTint {
    switch (_severity) {
      case _Severity.critical:
      case _Severity.high:
        return const Color(0xFFFFF5F5);
      case _Severity.medium:
        return const Color(0xFFFFFDF0);
      case _Severity.low:
        return const Color(0xFFF0FDF8);
    }
  }

  IconData get _statusIcon {
    switch (_severity) {
      case _Severity.critical:
        return Icons.error_rounded;
      case _Severity.high:
        return Icons.warning_amber_rounded;
      case _Severity.medium:
        return Icons.info_outline_rounded;
      case _Severity.low:
        return Icons.check_circle_outline_rounded;
    }
  }

  String get _severityLabel {
    switch (_severity) {
      case _Severity.critical:
        return 'Sangat Berisiko';
      case _Severity.high:
        return 'Berisiko Tinggi';
      case _Severity.medium:
        return 'Perlu Perhatian';
      case _Severity.low:
        return 'Aman';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) {
        _pressCtrl.reverse();
        context.push(RoutePath.historyDetail, extra: widget.history);
      },
      onTapCancel: () => _pressCtrl.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _accentColor.withOpacity(0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _accentColor.withOpacity(0.10),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── LEFT ACCENT BAR ──
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: _badgeGradient,
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(20),
                    ),
                  ),
                ),

                // ── CONTENT ──
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── TOP ROW ──
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon badge
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: _bgTint,
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: _accentColor.withOpacity(0.20),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                _statusIcon,
                                color: _accentColor,
                                size: 22,
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Category + date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.history.category,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0F172A),
                                      letterSpacing: -0.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule_rounded,
                                        size: 11,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        formatDate(widget.history.createdAt),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          color: Colors.grey.shade400,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Arrow
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: _accentColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 12,
                                color: _accentColor.withOpacity(0.70),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // ── DIVIDER ──
                        Container(height: 1, color: Colors.grey.shade100),

                        const SizedBox(height: 12),

                        // ── RESULT ROW ──
                        Row(
                          children: [
                            // Result text
                            Expanded(
                              child: Text(
                                widget.history.result,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.5,
                                  color: Colors.grey.shade600,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            const SizedBox(width: 10),

                            // Severity badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: _badgeGradient,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: _accentColor.withOpacity(0.30),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _statusIcon,
                                    size: 11,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _severityLabel,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

// ─────────────────────────────────────────────
// SEVERITY ENUM
// ─────────────────────────────────────────────
enum _Severity { critical, high, medium, low }
