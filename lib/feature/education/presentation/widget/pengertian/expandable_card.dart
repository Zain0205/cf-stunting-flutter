import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Expandable card showing a titled section with a numbered tip list.
/// Used for trimester guides and baby milestone sections.
class ExpandableCard extends StatefulWidget {
  final String title;
  final Color color;
  final List<String> tips;
  final ResponsiveHelper r;

  const ExpandableCard({
    super.key,
    required this.title,
    required this.color,
    required this.tips,
    required this.r,
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.r;

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.color.withOpacity(0.22), width: 1),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header row
            Padding(
              padding: EdgeInsets.all(r.sp(14)),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: widget.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(13),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  _TipsBadge(
                    count: widget.tips.length,
                    color: widget.color,
                    r: r,
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: widget.color,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            // Expanded tips list
            if (_expanded) ...[
              Container(height: 1, color: widget.color.withOpacity(0.12)),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  r.sp(14),
                  r.sp(12),
                  r.sp(14),
                  r.sp(14),
                ),
                child: Column(
                  children: widget.tips.asMap().entries.map((entry) {
                    final isLast = entry.key == widget.tips.length - 1;
                    return Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : r.sp(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _NumberBadge(
                            number: entry.key + 1,
                            color: widget.color,
                            r: r,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(12.5),
                                color: const Color(0xFF374151),
                                height: 1.55,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TipsBadge extends StatelessWidget {
  final int count;
  final Color color;
  final ResponsiveHelper r;

  const _TipsBadge({required this.count, required this.color, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count tips',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(9.5),
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _NumberBadge extends StatelessWidget {
  final int number;
  final Color color;
  final ResponsiveHelper r;

  const _NumberBadge({
    required this.number,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(9),
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ),
    );
  }
}
