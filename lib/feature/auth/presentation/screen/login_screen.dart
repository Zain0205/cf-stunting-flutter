import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_flutter/core/widget/loading_dialog.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/login_provider.dart';
import 'package:mobile_flutter/routes/route_path.dart';

// ─────────────────────────────────────────────
// RESPONSIVE HELPER
// ─────────────────────────────────────────────
class _R {
  final double w;
  final double h;

  _R(BuildContext context)
    : w = MediaQuery.of(context).size.width,
      h = MediaQuery.of(context).size.height;

  /// Scale font — base width 390px (iPhone 14)
  double fs(double size) => (size * w / 390).clamp(size * 0.78, size * 1.18);

  /// Scale spacing — proportional to height, base 844px
  double sp(double size) => (size * h / 844).clamp(size * 0.58, size * 1.22);

  /// Small screen: height < 680 (iPhone SE, small Android)
  bool get isSmall => h < 680;

  /// Tiny screen: height < 600
  bool get isTiny => h < 600;
}

// ─────────────────────────────────────────────
// LOGIN SCREEN
// ─────────────────────────────────────────────
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AnimationController _bgController;
  late final AnimationController _formController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _formController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnim = CurvedAnimation(
      parent: _formController,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOut),
    );

    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _formController, curve: Curves.easeOutCubic),
        );

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) _formController.forward();
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _bgController.dispose();
    _formController.dispose();
    super.dispose();
  }

  void _onLogin() {
    FocusScope.of(context).unfocus();
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnack('Username dan password wajib diisi', isError: true);
      return;
    }
    ref
        .read(loginStateProvider.notifier)
        .login(_usernameController.text.trim(), _passwordController.text);
  }

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError
                  ? Icons.error_outline_rounded
                  : Icons.check_circle_outline,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError
            ? const Color(0xFFEF4444)
            : const Color(0xFF22C55E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 6,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(loginStateProvider, (previous, next) {
      next.when(
        loading: () => LoadingDialog.show(context),
        data: (data) {
          LoadingDialog.hide(context);
          if (data != null) context.go(RoutePath.mainNavigation);
        },
        error: (error, _) {
          LoadingDialog.hide(context);
          _showSnack(error.toString(), isError: true);
        },
      );
    });

    final r = _R(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ── ANIMATED BACKGROUND ──
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bgController,
              builder: (_, __) => CustomPaint(
                painter: _MeshBackgroundPainter(_bgController.value),
              ),
            ),
          ),

          // ── ORB: top-right ──
          Positioned(
            top: -50,
            right: -30,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _bgController,
                builder: (_, __) {
                  final t = _bgController.value;
                  return Transform.translate(
                    offset: Offset(
                      math.sin(t * math.pi * 2) * 10,
                      math.cos(t * math.pi * 2) * 8,
                    ),
                    child: Container(
                      width: r.w * 0.55,
                      height: r.w * 0.55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF3B82F6).withOpacity(0.28),
                            const Color(0xFF1D4ED8).withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ── ORB: mid-left ──
          Positioned(
            top: r.h * 0.22,
            left: -70,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _bgController,
                builder: (_, __) {
                  final t = _bgController.value;
                  return Transform.translate(
                    offset: Offset(
                      math.cos(t * math.pi * 2) * 10,
                      math.sin(t * math.pi * 2) * 12,
                    ),
                    child: Container(
                      width: r.w * 0.44,
                      height: r.w * 0.44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF06B6D4).withOpacity(0.20),
                            const Color(0xFF0891B2).withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ── MAIN CONTENT ──
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Hero section
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  24,
                                  r.isTiny
                                      ? r.sp(14)
                                      : r.sp(r.isSmall ? 20 : 36),
                                  24,
                                  r.isTiny
                                      ? r.sp(10)
                                      : r.sp(r.isSmall ? 14 : 20),
                                ),
                                child: _HeroSection(r: r),
                              ),

                              // Pushes form to bottom
                              const Spacer(),

                              // Form card (never clips)
                              _FormCard(
                                r: r,
                                usernameController: _usernameController,
                                passwordController: _passwordController,
                                onLogin: _onLogin,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HERO SECTION
// ─────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final _R r;
  const _HeroSection({required this.r});

  @override
  Widget build(BuildContext context) {
    final iconSize = r.isTiny
        ? 38.0
        : r.isSmall
        ? 44.0
        : 52.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo mark
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(iconSize * 0.3),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.45),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            Icons.medical_services_rounded,
            color: Colors.white,
            size: iconSize * 0.50,
          ),
        ),

        SizedBox(
          height: r.sp(
            r.isTiny
                ? 12
                : r.isSmall
                ? 16
                : 22,
          ),
        ),

        // Chip tag
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 11,
            vertical: r.isTiny ? 3 : 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6).withOpacity(0.14),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF3B82F6).withOpacity(0.28),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF60A5FA),
                ),
              ),
              const SizedBox(width: 7),
              Text(
                'Platform Kesehatan Digital',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(10.5),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF93C5FD),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: r.sp(
            r.isTiny
                ? 8
                : r.isSmall
                ? 12
                : 16,
          ),
        ),

        // Headline
        Text(
          r.isTiny ? 'Selamat Datang\nKembali' : 'Selamat\nDatang Kembali',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(
              r.isTiny
                  ? 24
                  : r.isSmall
                  ? 28
                  : 34,
            ),
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.18,
            letterSpacing: -0.5,
          ),
        ),

        if (!r.isTiny) ...[
          SizedBox(height: r.sp(8)),
          Text(
            'Akses data kesehatan Anda dengan\naman dan terpercaya.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(13),
              color: Colors.white.withOpacity(0.52),
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
// FORM CARD
// ─────────────────────────────────────────────
class _FormCard extends StatelessWidget {
  final _R r;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const _FormCard({
    required this.r,
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final vPad = r.isTiny
        ? 18.0
        : r.isSmall
        ? 22.0
        : 30.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(22, vPad, 22, vPad + bottomPadding),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.30),
            blurRadius: 40,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Text(
                'Masuk',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(20),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '🔒 Aman & Terenkripsi',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(9.5),
                    color: const Color(0xFF3B82F6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: r.sp(
              r.isTiny
                  ? 14
                  : r.isSmall
                  ? 18
                  : 22,
            ),
          ),

          // Phone input
          _ModernInputField(
            controller: usernameController,
            hintText: 'No. Telepon',
            icon: Icons.phone_iphone_rounded,
            keyboardType: TextInputType.phone,
            r: r,
          ),

          SizedBox(height: r.sp(10)),

          // Password input
          _ModernPasswordField(controller: passwordController, r: r),

          SizedBox(height: r.sp(2)),

          // Forgot password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                minimumSize: const Size(0, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Lupa password?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(11.5),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ),
          ),

          SizedBox(
            height: r.sp(
              r.isTiny
                  ? 12
                  : r.isSmall
                  ? 14
                  : 18,
            ),
          ),

          // Login button
          _GradientButton(label: 'Masuk Sekarang', onTap: onLogin, r: r),

          SizedBox(
            height: r.sp(
              r.isTiny
                  ? 12
                  : r.isSmall
                  ? 14
                  : 18,
            ),
          ),

          // Divider
          Row(
            children: [
              Expanded(
                child: Divider(color: Colors.grey.shade200, thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'atau',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(11.5),
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              Expanded(
                child: Divider(color: Colors.grey.shade200, thickness: 1),
              ),
            ],
          ),

          SizedBox(
            height: r.sp(
              r.isTiny
                  ? 10
                  : r.isSmall
                  ? 12
                  : 16,
            ),
          ),

          // Register row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum punya akun?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => context.go(RoutePath.register),
                child: Text(
                  'Daftar Gratis',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(12.5),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MODERN INPUT FIELD
// ─────────────────────────────────────────────
class _ModernInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final _R r;

  const _ModernInputField({
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.r,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<_ModernInputField> createState() => _ModernInputFieldState();
}

class _ModernInputFieldState extends State<_ModernInputField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    return Focus(
      onFocusChange: (v) => setState(() => _focused = v),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: _focused ? Colors.white : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _focused ? const Color(0xFF3B82F6) : const Color(0xFFE2E8F0),
            width: _focused ? 1.5 : 1,
          ),
          boxShadow: _focused
              ? [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(13.5),
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(13),
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              widget.icon,
              size: r.isSmall ? 18 : 20,
              color: _focused ? const Color(0xFF3B82F6) : Colors.grey.shade400,
            ),
            border: InputBorder.none,
            isDense: r.isSmall,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: r.isTiny
                  ? 11
                  : r.isSmall
                  ? 13
                  : 15,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MODERN PASSWORD FIELD
// ─────────────────────────────────────────────
class _ModernPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final _R r;

  const _ModernPasswordField({required this.controller, required this.r});

  @override
  State<_ModernPasswordField> createState() => _ModernPasswordFieldState();
}

class _ModernPasswordFieldState extends State<_ModernPasswordField> {
  bool _focused = false;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    return Focus(
      onFocusChange: (v) => setState(() => _focused = v),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: _focused ? Colors.white : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _focused ? const Color(0xFF3B82F6) : const Color(0xFFE2E8F0),
            width: _focused ? 1.5 : 1,
          ),
          boxShadow: _focused
              ? [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: TextField(
          controller: widget.controller,
          obscureText: _obscure,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(13.5),
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(13),
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              size: r.isSmall ? 18 : 20,
              color: _focused ? const Color(0xFF3B82F6) : Colors.grey.shade400,
            ),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: Icon(
                _obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: r.isSmall ? 18 : 20,
                color: Colors.grey.shade400,
              ),
            ),
            border: InputBorder.none,
            isDense: r.isSmall,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: r.isTiny
                  ? 11
                  : r.isSmall
                  ? 13
                  : 15,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// GRADIENT BUTTON
// ─────────────────────────────────────────────
class _GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final _R r;

  const _GradientButton({
    required this.label,
    required this.onTap,
    required this.r,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          height: r.isTiny
              ? 46
              : r.isSmall
              ? 50
              : 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.38),
                blurRadius: 16,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(14.5),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ANIMATED MESH BACKGROUND PAINTER
// ─────────────────────────────────────────────
class _MeshBackgroundPainter extends CustomPainter {
  final double t;
  _MeshBackgroundPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0A1628), Color(0xFF0F1E3D), Color(0xFF091525)],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), basePaint);

    final linePaint = Paint()
      ..color = const Color(0xFF1E3A5F).withOpacity(0.35)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const gridSize = 38.0;
    final offsetX = (t * gridSize) % gridSize;
    final offsetY = (t * gridSize * 0.65) % gridSize;

    for (
      double x = -gridSize + offsetX;
      x < size.width + gridSize;
      x += gridSize
    ) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (
      double y = -gridSize + offsetY;
      y < size.height + gridSize;
      y += gridSize
    ) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    final glowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(
            0xFF3B82F6,
          ).withOpacity(0.07 + math.sin(t * math.pi) * 0.04),
          const Color(0xFF3B82F6).withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.55));
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.55),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(_MeshBackgroundPainter old) => old.t != t;
}
