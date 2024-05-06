import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField(
      {super.key,
      this.labelText,
      this.hintText,
      this.onChanged,
      this.keyboardType,
      this.textInputAction,
      this.controller,
      this.textCapitalization,
      this.obscureText,
      this.suffixIcon,
      this.prefixIcon,
      this.isReadOnly,
      this.onTap,
      this.maxLines,
      this.minLines,
      this.focusNode,
      this.validator,
      this.initialValue,
      this.customTextStyle,
      this.onFieldSubmitted,
      this.contentInsertionConfiguration,
      this.autovalidateMode});
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final String? labelText;
  final String? hintText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initialValue;
  final bool? isReadOnly;
  final Function()? onTap;
  final int? maxLines;
  final int? minLines;

  final FocusNode? focusNode;
  final TextStyle? customTextStyle;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (labelText?.isNotEmpty ?? false)
          Text(labelText ?? '', style: GoogleFonts.acme(color: mainRedColor)),
        const SizedBox(height: 7),
        TextFormField(
          minLines: minLines ?? 1,
          autovalidateMode: autovalidateMode,
          focusNode: focusNode,
          controller: controller,
          contentInsertionConfiguration: contentInsertionConfiguration,
          keyboardType: keyboardType,
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          textInputAction: textInputAction,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          cursorColor: mainRedColor,
          readOnly: isReadOnly ?? false,
          maxLines: maxLines ?? 1,
          validator: validator,
          // style: ThemeText.medium14,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: customTextStyle,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.2))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.2))),
          ),
        )
      ],
    );
  }
}
