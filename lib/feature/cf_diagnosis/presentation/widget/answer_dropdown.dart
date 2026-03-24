import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/question_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/widget/answer_picker.dart';

/// Tappable dropdown that opens [AnswerPicker] as a bottom sheet.
/// Shows the currently selected answer or a placeholder.
class AnswerDropdown extends StatefulWidget {
  final QuestionEntity question;
  final String? selectedLabel;
  final List<Color> palette;
  final ResponsiveHelper r;
  final ValueChanged<String> onChanged;

  const AnswerDropdown({
    super.key,
    required this.question,
    required this.selectedLabel,
    required this.palette,
    required this.r,
    required this.onChanged,
  });

  @override
  State<AnswerDropdown> createState() => _AnswerDropdownState();
}

class _AnswerDropdownState extends State<AnswerDropdown> {
  bool _open = false;

  void _showPicker() {
    setState(() => _open = true);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => AnswerPicker(
        question: widget.question,
        selectedLabel: widget.selectedLabel,
        palette: widget.palette,
        r: widget.r,
        onSelect: (label) {
          widget.onChanged(label);
          Navigator.pop(context);
        },
      ),
    ).whenComplete(() {
      if (mounted) setState(() => _open = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final hasValue = widget.selectedLabel != null;

    return GestureDetector(
      onTap: _showPicker,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: r.isSmall ? 11 : 13,
        ),
        decoration: BoxDecoration(
          color: _open
              ? Colors.white
              : hasValue
              ? widget.palette[0].withOpacity(0.05)
              : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _open
                ? widget.palette[0]
                : hasValue
                ? widget.palette[0].withOpacity(0.30)
                : const Color(0xFFE2E8F0),
            width: _open ? 1.5 : 1,
          ),
          boxShadow: _open
              ? [
                  BoxShadow(
                    color: widget.palette[0].withOpacity(0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              hasValue
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              size: 18,
              color: hasValue ? widget.palette[0] : Colors.grey.shade400,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                hasValue ? widget.selectedLabel! : 'Pilih jawaban',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: hasValue
                      ? const Color(0xFF0F172A)
                      : Colors.grey.shade400,
                  fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
            AnimatedRotation(
              turns: _open ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
                color: _open ? widget.palette[0] : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
