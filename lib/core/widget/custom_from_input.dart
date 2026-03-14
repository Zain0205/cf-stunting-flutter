// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mobile_flutter/core/resource/app_colors.dart';
//
// class CustomFormInput extends StatefulWidget {
//   final TextEditingController controller;
//   final String? label;
//   final String hintText;
//   final IconData? prefixIcon;
//   final String? prefixSvgAsset;
//   final String? prefixPngAsset;
//   final String? Function(String?)? validator;
//   final TextInputType? keyboardType;
//   final bool obscureText;
//   final bool enabled;
//   final bool onlyLetters;
//   final bool isRequired;
//   final void Function(String)? onChanged;
//
//   const CustomFormInput({
//     this.onlyLetters = false,
//     super.key,
//     required this.controller,
//     this.label,
//     required this.hintText,
//     this.prefixIcon,
//     this.prefixSvgAsset,
//     this.prefixPngAsset,
//     this.validator,
//     this.keyboardType,
//     this.obscureText = false,
//     this.enabled = true,
//     this.isRequired = false,
//     this.onChanged,
//   });
//
//   @override
//   State<CustomFormInput> createState() => _CustomFormInputState();
// }
//
// class _CustomFormInputState extends State<CustomFormInput> {
//   bool _isPasswordVisible = false;
//   late final FocusNode _focusNode;
//
//   bool get _isActive =>
//       _focusNode.hasFocus || widget.controller.text.trim().isNotEmpty;
//
//   @override
//   void initState() {
//     super.initState();
//     // Kalau obscureText = true, mulai dengan password hidden (false)
//     // Kalau obscureText = false, tidak perlu state ini (tidak ada toggle)
//     _isPasswordVisible = false;
//     _focusNode = FocusNode()..addListener(_handleFocusChange);
//     widget.controller.addListener(_handleTextChange);
//   }
//
//   void _togglePasswordVisibility() {
//     setState(() {
//       _isPasswordVisible = !_isPasswordVisible;
//     });
//   }
//
//   void _handleFocusChange() {
//     setState(() {});
//   }
//
//   void _handleTextChange() {
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _focusNode
//       ..removeListener(_handleFocusChange)
//       ..dispose();
//     widget.controller.removeListener(_handleTextChange);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final hasLabel = widget.label != null && widget.label!.trim().isNotEmpty;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (hasLabel)
//           Row(
//             children: [
//               Text(
//                 widget.label!,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13,
//                   color: AppColors.primaryDark,
//                 ),
//               ),
//               if (widget.isRequired) ...[
//                 const SizedBox(width: 4),
//                 const Text(
//                   "*Wajib Diisi",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 13,
//                     color: AppColors.danger,
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: widget.controller,
//           focusNode: _focusNode,
//           keyboardType: widget.keyboardType,
//           obscureText: widget.obscureText && !_isPasswordVisible,
//           enabled: widget.enabled,
//           onChanged: widget.onChanged,
//           inputFormatters: widget.onlyLetters
//               ? [
//                   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//                 ] // huruf + spasi
//               : widget.keyboardType == TextInputType.phone ||
//                     widget.keyboardType == TextInputType.number
//               ? [FilteringTextInputFormatter.digitsOnly]
//               : null,
//           decoration: InputDecoration(
//             hintText: widget.hintText,
//             prefixIcon: widget.prefixPngAsset != null
//                 ? Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Image.asset(
//                       widget.prefixPngAsset!,
//                       width: 24,
//                       height: 24,
//                       fit: BoxFit.scaleDown,
//                     ),
//                   )
//                 : widget.prefixSvgAsset != null
//                 ? Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: SvgPicture.asset(
//                       widget.prefixSvgAsset!,
//                       width: 24,
//                       height: 24,
//                       fit: BoxFit.scaleDown,
//                     ),
//                   )
//                 : widget.prefixIcon != null
//                 ? Icon(widget.prefixIcon!)
//                 : null,
//             suffixIcon: widget.obscureText
//                 ? IconButton(
//                     icon: Icon(
//                       _isPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Colors.grey,
//                     ),
//                     onPressed: _togglePasswordVisibility,
//                   )
//                 : null,
//             filled: true,
//             fillColor: _isActive
//                 ? AppColors.lightGrey
//                 : const Color(0xFFEBEBEB).withValues(alpha: .54),
//             contentPadding: const EdgeInsets.symmetric(
//               vertical: 9,
//               horizontal: 20,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: _isActive
//                     ? AppColors.primaryBase
//                     : const Color(0xFF202020).withValues(alpha: .5),
//                 width: 1.0,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: _isActive
//                     ? AppColors.primaryBase
//                     : const Color(0xFF202020).withValues(alpha: .5),
//                 width: 1.0,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(
//                 color: AppColors.primaryBase,
//                 width: 1.0,
//               ),
//             ),
//           ),
//           validator: widget.validator,
//         ),
//       ],
//     );
//   }
// }
