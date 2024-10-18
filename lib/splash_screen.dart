import 'package:flutter/material.dart';
import 'choose_language_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChooseLanguageScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000B48),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Transform.translate(
              offset: Offset(0, -80), // Move the entire column 30px up
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo_tmb.jpg'),
                  SizedBox(height: 20),

                  // Row for side-by-side images, shifted 50px to the left
                  Transform.translate(
                    offset: Offset(-30, 0), // Move the Row 50px to the left
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/logo_muzeja.png'),
                        ),
                        SizedBox(width: 10), // Space between images
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/grb.png'),
                        ),
                        SizedBox(width: 10), // Space between images
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/itm.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
