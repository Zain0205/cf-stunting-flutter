import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';

class CustomSelectField extends StatelessWidget {
  final String label;
  final String hint;
  final List<String> options;
  final String? value;
  final Function(String) onChanged;
  final bool isRequired;

  const CustomSelectField({
    super.key,
    required this.label,
    required this.hint,
    required this.options,
    required this.value,
    required this.onChanged,
    this.isRequired = false,
  });

  Future<void> _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final mq = MediaQuery.of(sheetContext);
        final double screenHeight = mq.size.height;
        final double topPadding = mq.padding.top;

        const double headerHeight = 100.0;
        final double reservedHeaderHeight = topPadding + headerHeight;

        double maxChildSize =
            ((screenHeight - reservedHeaderHeight) / screenHeight).clamp(
              0.5,
              0.9,
            );
        double initialChildSize = math.min(0.7, maxChildSize);
        double minChildSize = math.min(0.5, initialChildSize);

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Handle Bar
                  Container(
                    width: 45,
                    height: 5,
                    margin: const EdgeInsets.only(top: 12, bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.greyMedium,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const Divider(height: 24),

                  // Options List
                  Expanded(
                    child: options.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.inbox_outlined,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Tidak ada pilihan tersedia',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final item = options[index];
                              final isSelected = value == item;

                              return InkWell(
                                onTap: () {
                                  onChanged(item);
                                  Navigator.pop(context);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primaryBase.withValues(
                                            alpha: .1,
                                          )
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryBase
                                          : Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Avatar
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.primaryBase
                                              : Colors.blue.shade100,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            item.isNotEmpty
                                                ? item[0].toUpperCase()
                                                : '?',
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : AppColors.primaryBase,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Text
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                            color: isSelected
                                                ? AppColors.primaryBase
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                      // Selected Indicator
                                      if (isSelected)
                                        Icon(
                                          Icons.check_circle,
                                          color: AppColors.primaryBase,
                                          size: 24,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

                  // Bottom Padding
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = value != null && value!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              const Text(
                "*Wajib Diisi",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.primaryRed,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: AbsorbPointer(
            child: TextFormField(
              validator: (val) => (value == null || value!.isEmpty)
                  ? "Pilih $label terlebih dahulu"
                  : null,
              decoration: InputDecoration(
                hintText: value ?? hint,
                suffixIcon: const Icon(Icons.keyboard_arrow_down),
                filled: true,
                fillColor: isActive
                    ? AppColors.lightGrey
                    : const Color(0xFFEBEBEB).withValues(alpha: .54),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isActive
                        ? AppColors.primaryBase
                        : const Color(0xFF202020).withValues(alpha: .5),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isActive
                        ? AppColors.primaryBase
                        : const Color(0xFF202020).withValues(alpha: .5),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primaryBase,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
