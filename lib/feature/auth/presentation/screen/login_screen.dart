import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/widget/custom_from_input.dart';
import 'package:mobile_flutter/core/widget/primary_button.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/login_provider.dart';
import 'package:mobile_flutter/routes/route_path.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password wajib diisi')),
      );
      return;
    }

    ref
        .read(loginStateProvider.notifier)
        .login(_usernameController.text.trim(), _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(loginStateProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data != null) {
            context.go(RoutePath.mainNavigation);
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    final loginState = ref.watch(loginStateProvider);

    return Scaffold(
      body: Stack(
        children: [
          // 🔥 BACKGROUND LAYER
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1E3A8A), // deep blue
                  Color(0xFF2563EB), // modern primary
                  Colors.white,
                ],
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
                              'Masuk',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Akses data kesehatan Anda dengan aman',
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
                      flex: 3,
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
                              controller: _usernameController,
                              hintText: "No. Telp",
                              isRequired: true,
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
                              textButton: loginState.isLoading
                                  ? "Memproses..."
                                  : "Masuk",
                              onTap: loginState.isLoading ? null : _onLogin,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Belum punya akun? ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                TextButton(
                                  onPressed: () {
                                    context.go(RoutePath.register);
                                  },
                                  child: Text(
                                    'Daftar',
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
                                'Dengan masuk, Anda menyetujui kebijakan kami',
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
