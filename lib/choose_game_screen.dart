import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'game_card.dart';
import 'quiz_screen.dart';
import 'slide_puzzle_screen.dart';
import 'happy_color_screen.dart';

class ChooseGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000B48),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.choose_a_game,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GameCard(
                title: AppLocalizations.of(context)!.quiz,
                color: Colors.orange,
                imagePath: 'assets/quiz_icon.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizScreen()),
                  );
                },
              ),
              GameCard(
                title: AppLocalizations.of(context)!.slide_puzzle,
                color: Colors.green,
                imagePath: 'assets/puzzle_icon.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SlidePuzzleScreen()),
                  );
                },
              ),
              GameCard(
                title: AppLocalizations.of(context)!.happy_color,
                color: Colors.blue,
                imagePath: 'assets/color_orange_icon.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HappyColorScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
