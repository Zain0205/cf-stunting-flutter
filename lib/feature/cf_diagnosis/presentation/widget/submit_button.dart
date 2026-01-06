import 'package:flutter/material.dart';
import '../../../../core/widget/primary_button.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: PrimaryButton(
        textButton: "Proses Hasil",
        onTap: () {
          // TODO: trigger calculate CF
        },
      ),
    );
  }
}
