import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_answer_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_domain_entity.dart';

class HistoryDetailScreen extends StatelessWidget {
  final DiagnosisHistoryEntity history;

  const HistoryDetailScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        toolbarHeight: 72,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppColors.blueGradient),
        ),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text("Form Quisioner"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _ResultHeader(history: history),
            const SizedBox(height: 24),
            _DomainSection(domains: history.domains),
            const SizedBox(height: 24),
            _AnswerSection(answers: history.answers),
          ],
        ),
      ),
    );
  }
}

/* ================= RESULT HEADER ================= */

class _ResultHeader extends StatelessWidget {
  final DiagnosisHistoryEntity history;

  const _ResultHeader({required this.history});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy • HH:mm').format(history.createdAt);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hasil Skrining',
            style: TextStyle(color: AppColors.lightestBlue, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            history.result,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: AppColors.lightestBlue,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(date, style: const TextStyle(color: AppColors.lightestBlue)),
            ],
          ),
        ],
      ),
    );
  }
}

/* ================= DOMAIN SECTION ================= */

class _DomainSection extends StatelessWidget {
  final List<DiagnosisDomainEntity> domains;

  const _DomainSection({required this.domains});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nilai Certainty Factor',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGray,
          ),
        ),
        const SizedBox(height: 12),
        ...domains.map((e) => _DomainItem(domain: e)),
      ],
    );
  }
}

class _DomainItem extends StatelessWidget {
  final DiagnosisDomainEntity domain;

  const _DomainItem({required this.domain});

  @override
  Widget build(BuildContext context) {
    final value = domain.cfValue.clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                domain.domainCode,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGray,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimaryBase,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value.toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBase,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: AppColors.lightGrey,
              valueColor: const AlwaysStoppedAnimation(AppColors.primaryBase),
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= ANSWER SECTION ================= */

class _AnswerSection extends StatelessWidget {
  final List<DiagnosisAnswerEntity> answers;

  const _AnswerSection({required this.answers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detail Jawaban',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGray,
          ),
        ),
        const SizedBox(height: 12),
        ...answers.map((e) => _AnswerItem(answer: e)),
      ],
    );
  }
}

class _AnswerItem extends StatelessWidget {
  final DiagnosisAnswerEntity answer;

  const _AnswerItem({required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.notificationBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              answer.answerKey,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkest,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  answer.questionCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'CF Item: ${answer.cfItem.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.greyMedium,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
