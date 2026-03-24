import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/question_entity.dart';

/// Bottom sheet presenting all answer options for a question.
/// Uses a gradient badge per option and highlights the selected one.
class AnswerPicker extends StatelessWidget {
  final QuestionEntity question;
  final String? selectedLabel;
  final List<Color> palette;
  final ResponsiveHelper r;
  final ValueChanged<String> onSelect;

  const AnswerPicker({
    super.key,
    required this.question,
    required this.selectedLabel,
    required this.palette,
    required this.r,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SheetHandle(),
          _SheetHeader(question: question, r: r),
          Divider(height: 1, color: Colors.grey.shade100),
          ...question.options.map((option) {
            final isSelected = option.label.trim() == selectedLabel;
            return _OptionRow(
              option: option,
              isSelected: isSelected,
              palette: palette,
              r: r,
              onTap: () => onSelect(option.label),
            );
          }),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 12),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: 12),
    width: 36,
    height: 4,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}

class _SheetHeader extends StatelessWidget {
  final QuestionEntity question;
  final ResponsiveHelper r;

  const _SheetHeader({required this.question, required this.r});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pilih Jawaban',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(15),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                question.text,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(11.5),
                  color: Colors.grey.shade500,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close_rounded,
              size: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ],
    ),
  );
}

class _OptionRow extends StatelessWidget {
  final dynamic option;
  final bool isSelected;
  final List<Color> palette;
  final ResponsiveHelper r;
  final VoidCallback onTap;

  const _OptionRow({
    required this.option,
    required this.isSelected,
    required this.palette,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: r.isSmall ? 13 : 15,
      ),
      child: Row(
        children: [
          // Answer key badge
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: palette,
                    )
                  : null,
              color: isSelected ? null : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                option.answerKey,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(13),
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : Colors.grey.shade500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Label
          Expanded(
            child: Text(
              option.label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(13),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? palette[0] : const Color(0xFF0F172A),
              ),
            ),
          ),

          // Check indicator
          if (isSelected)
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: palette,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 13,
              ),
            ),
        ],
      ),
    ),
  );
}
