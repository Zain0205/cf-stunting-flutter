import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/widget/custom_from_input.dart';
import 'package:mobile_flutter/core/widget/custom_select_field.dart';
import 'package:mobile_flutter/core/widget/primary_button.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/register_provider.dart';

class SelectOption {
  final String label;
  final String value;

  const SelectOption({required this.label, required this.value});
}

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final List<SelectOption> categoryOptions = [
    SelectOption(label: 'Prakonsepsi', value: 'PRAKONSEPSI'),
    SelectOption(label: 'Pernah Melahirkan', value: 'PERNAH_MELAHIRKAN'),
    SelectOption(label: 'Remaja minimal 19 tahun', value: 'REMAJA_19'),
  ];

  SelectOption? _selectedCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih kategori terlebih dahulu')),
      );
      return;
    }

    ref
        .read(registerStateProvider.notifier)
        .register(
          _nameController.text.trim(),
          _phoneController.text.trim(),
          _selectedCategory!.value, // 🔥 VALUE API
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerStateProvider);

    ref.listen(registerStateProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Register berhasil')));
        },
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomFormInput(
              controller: _nameController,
              hintText: "Nama Lengkap",
              isRequired: true,
            ),
            const SizedBox(height: 12),
            CustomFormInput(
              controller: _phoneController,
              hintText: "No. Telepon",
              keyboardType: TextInputType.phone,
              isRequired: true,
            ),
            const SizedBox(height: 12),
            CustomSelectField(
              label: "Kategori",
              hint: "Pilih kategori",
              options: categoryOptions.map((e) => e.label).toList(),
              value: _selectedCategory?.label,
              isRequired: true,
              onChanged: (label) {
                setState(() {
                  _selectedCategory = categoryOptions.firstWhere(
                    (e) => e.label == label,
                  );
                });
              },
            ),
            const SizedBox(height: 12),
            CustomFormInput(
              controller: _passwordController,
              hintText: "Password",
              obscureText: true,
              isRequired: true,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              textButton: registerState.isLoading ? "Loading..." : "Register",
              onTap: registerState.isLoading ? null : _onRegister,
            ),
          ],
        ),
      ),
    );
  }
}
