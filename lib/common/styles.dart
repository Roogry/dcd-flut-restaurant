import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xFFC21C40);
const primaryDarkColor = Color(0xFF760A17);
const primaryLightColor = Color(0xFFFFDBE3);

const blackText = Color(0xFF212843);
const secondaryText = Color(0xFF858792);
const placeholderText = Color(0xFFD4D4D4);

const primaryBackground = Color(0xFFF8F5F6);
const greyBackground = Color(0xFFF1F1F1);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.playfairDisplay(
    fontSize: 92,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: blackText,
  ),
  displayMedium: GoogleFonts.playfairDisplay(
    fontSize: 57,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: blackText,
  ),
  displaySmall: GoogleFonts.playfairDisplay(
    fontSize: 46,
    fontWeight: FontWeight.w400,
    color: blackText,
  ),
  headlineMedium: GoogleFonts.playfairDisplay(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: blackText,
  ),
  headlineSmall: GoogleFonts.playfairDisplay(
    fontSize: 23,
    fontWeight: FontWeight.w400,
    color: blackText,
  ),
  titleLarge: GoogleFonts.playfairDisplay(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: blackText,
  ),
  titleMedium: GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: blackText,
  ),
  titleSmall: GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: blackText,
  ),
  bodyLarge: GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: blackText,
  ),
  bodyMedium: GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: blackText,
  ),
  labelLarge: GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: blackText,
  ),
  bodySmall: GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: blackText,
  ),
  labelSmall: GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    color: blackText,
  ),
);
