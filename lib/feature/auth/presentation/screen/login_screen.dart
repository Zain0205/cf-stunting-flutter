import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // 🔥 LISTEN UNTUK SIDE EFFECT (SnackBar / Navigation)
    ref.listen<AsyncValue>(loginStateProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Login berhasil')));

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

    // 👀 WATCH STATE UNTUK UI
    final loginState = ref.watch(loginStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomFormInput(
              controller: _usernameController,
              hintText: "No. Telp",
              isRequired: true,
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
              textButton: loginState.isLoading ? "Loading..." : "Login",
              onTap: loginState.isLoading ? null : _onLogin,
            ),
          ],
        ),
      ),
    );
  }
}
