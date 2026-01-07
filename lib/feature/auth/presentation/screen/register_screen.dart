import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/widget/custom_from_input.dart';
import 'package:mobile_flutter/core/widget/custom_select_field.dart';
import 'package:mobile_flutter/core/widget/primary_button.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/register_provider.dart';
import 'package:mobile_flutter/routes/route_path.dart';

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

  final List<SelectOption> categoryOptions = const [
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
          _selectedCategory!.value,
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
          ).showSnackBar(const SnackBar(content: Text('Registrasi berhasil')));
        },
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          // 🔥 BACKGROUND GRADIENT
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1E3A8A), Color(0xFF2563EB), Colors.white],
              ),
            ),
          ),

          // 🧠 CONTENT
          SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    // 🧩 HERO SECTION
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Lengkapi data untuk memulai perjalanan sehat Anda',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 🪟 FORM CARD
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomFormInput(
                              controller: _nameController,
                              hintText: "Nama Lengkap",
                              isRequired: true,
                            ),
                            const SizedBox(height: 16),

                            CustomFormInput(
                              controller: _phoneController,
                              hintText: "No. Telepon",
                              keyboardType: TextInputType.phone,
                              isRequired: true,
                            ),
                            const SizedBox(height: 16),

                            CustomSelectField(
                              label: "Kategori",
                              hint: "Pilih kategori",
                              options: categoryOptions
                                  .map((e) => e.label)
                                  .toList(),
                              value: _selectedCategory?.label,
                              isRequired: true,
                              onChanged: (label) {
                                setState(() {
                                  _selectedCategory = categoryOptions
                                      .firstWhere((e) => e.label == label);
                                });
                              },
                            ),
                            const SizedBox(height: 16),

                            CustomFormInput(
                              controller: _passwordController,
                              hintText: "Password",
                              obscureText: true,
                              isRequired: true,
                            ),

                            const SizedBox(height: 32),

                            PrimaryButton(
                              textButton: registerState.isLoading
                                  ? "Memproses..."
                                  : "Daftar",
                              onTap: registerState.isLoading
                                  ? null
                                  : _onRegister,
                            ),

                            Row(
                              children: [
                                Text(
                                  'Sudah punya akun? ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                TextButton(
                                  onPressed: () {
                                    context.go(RoutePath.login);
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primaryBase,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            Center(
                              child: Text(
                                'Dengan mendaftar, Anda menyetujui kebijakan privasi kami',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
