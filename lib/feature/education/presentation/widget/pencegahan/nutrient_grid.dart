import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/pencegahan_header.dart';

/// 2-column grid of key nutrients for stunting prevention.
class NutrientGrid extends StatelessWidget {
  final ResponsiveHelper r;

  const NutrientGrid({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.6,
      ),
      itemCount: PencegahanData.nutrients.length,
      itemBuilder: (_, i) =>
          _NutrientCard(item: PencegahanData.nutrients[i], r: r),
    );
  }
}

class _NutrientCard extends StatelessWidget {
  final NutrientItem item;
  final ResponsiveHelper r;
  const _NutrientCard({required this.item, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: item.color.withOpacity(0.18), width: 1),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(item.emoji, style: TextStyle(fontSize: r.fs(20))),
              const Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12),
                  fontWeight: FontWeight.w700,
                  color: item.color,
                ),
              ),
              Text(
                item.dose,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(9.5),
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                item.sources,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(9),
                  color: Colors.grey.shade400,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
