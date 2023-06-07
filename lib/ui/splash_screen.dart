import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.pushReplacementNamed(
        context,
        HomePage.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/logo.png', height: 70, fit: BoxFit.fitHeight,),

              const SizedBox(height: 24),
              Text(
                'Restoeev',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: blackText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
