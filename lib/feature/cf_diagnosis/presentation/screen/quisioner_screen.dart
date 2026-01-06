import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import '../provider/quisioner_provider.dart';
import '../widget/domain_section.dart';
import '../widget/submit_button.dart';

class QuisionerScreen extends ConsumerWidget {
  const QuisionerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
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
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (data) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: data.domains.length + 1,
          separatorBuilder: (_, __) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            if (index == data.domains.length) {
              return const SubmitButton();
            }
            return DomainSection(domain: data.domains[index]);
          },
        ),
      ),
    );
  }
}
