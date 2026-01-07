import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/state/auth_user_provider.dart';
import 'package:mobile_flutter/core/widget/loading_dialog.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/provider/quisioner_provider.dart';
import 'package:mobile_flutter/routes/route_path.dart';
import '../../../../core/widget/primary_button.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // LISTEN perubahan state diagnosis (SIDE EFFECT)
    ref.listen<AsyncValue>(diagnosisProvider, (previous, next) {
      next.when(
        loading: () {
          LoadingDialog.show(context);
        },
        data: (data) {
          LoadingDialog.hide(context);

          if (data != null) {
            // 🔥 PAKSA HISTORY REFRESH
            ref.invalidate(diagnosisHistoryProvider);

            // 🔥 NAVIGATE KE HOME
            context.go(RoutePath.mainNavigation);
          }
        },
        error: (error, _) {
          LoadingDialog.hide(context);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: PrimaryButton(
        textButton: "Proses Hasil",
        onTap: () async {
          final answers = ref.read(answerStateProvider.notifier).answers;
          final user = ref.read(authUserProvider);

          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Harap login terlebih dahulu")),
            );
            return;
          }

          if (answers.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Harap isi kuesioner terlebih dahulu"),
              ),
            );
            return;
          }

          // Trigger submit (dialog akan muncul via ref.listen)
          await ref
              .read(diagnosisProvider.notifier)
              .submit(category: user.category, answers: answers);
        },
      ),
    );
  }
}
