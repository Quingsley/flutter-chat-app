import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xff2e6b47).withOpacity(.4),
        hintText: 'Enter your username',
        contentPadding: const EdgeInsets.all(16),
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFDC100),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFFFDC100).withOpacity(.5),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFDC100),
          ),
        ),
      ),
    );
  }
}
