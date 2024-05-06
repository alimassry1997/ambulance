import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.child,
    this.width,
    this.onPressed,
    this.height,
  });

  final String? child;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 45,
        decoration: BoxDecoration(
            color: mainRedColor, borderRadius: BorderRadius.circular(23)),
        child: Center(
          child: Text(
            child ?? '',
            style: GoogleFonts.acme(fontSize: 20, color: Colors.white),
            selectionColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
