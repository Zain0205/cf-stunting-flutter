import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/widget/custom_from_input.dart';
import 'package:mobile_flutter/core/widget/primary_button.dart';
import 'package:mobile_flutter/core/widget/loading_dialog.dart';
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
    /// 🔥 LISTEN LOGIN STATE (SIDE EFFECT ONLY)
    ref.listen<AsyncValue>(loginStateProvider, (previous, next) {
      next.when(
        loading: () {
          LoadingDialog.show(context);
        },
        data: (data) {
          LoadingDialog.hide(context);

          if (data != null) {
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

    return Scaffold(
      body: Stack(
        children: [
          /// 🌈 BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1E3A8A), Color(0xFF2563EB), Colors.white],
              ),
            ),
          ),

          /// 🧠 CONTENT
          SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    /// 🧩 HERO
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

                    /// 🪟 FORM
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

                            /// 🔘 LOGIN BUTTON (NO LOADING STATE)
                            PrimaryButton(textButton: "Masuk", onTap: _onLogin),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Belum punya akun?',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
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
                                  ),
                                ),
                              ],
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
