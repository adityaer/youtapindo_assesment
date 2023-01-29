import 'package:flutter/material.dart';

import '../homepage/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  void startSplashScreen() {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.pushNamed(
          context,
          HomePage.routeName,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.stars_rounded,
              color: Colors.white,
              size: 90,
            ),
            const SizedBox(
              height: 10,
            ),
            Text('MOVIE&TV APP',
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 24))
          ],
        ),
      ),
    );
  }
}
