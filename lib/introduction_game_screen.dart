import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'intro_slider_screen.dart';

class IntroductionGameScreen extends StatelessWidget {
  final String selectedLanguage;

  IntroductionGameScreen({required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000B48),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Headline
              Text(
                AppLocalizations.of(context)!.secrets_of_museum_treasures,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Square border with text
              Container(
                width: 800,
                height: 600,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Color(0xFFFFD700)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Text(
                      AppLocalizations.of(context)!.welcome_text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen (IntroSliderScreen)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroSliderScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF10C88),
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 50),
                ),
                child: Text(AppLocalizations.of(context)!.choose_a_game),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
