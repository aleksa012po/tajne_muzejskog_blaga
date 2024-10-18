import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'choose_game_screen.dart';

class IntroSliderScreen extends StatefulWidget {
  @override
  _IntroSliderScreenState createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              buildSlide(Color(0xFFFF5733), 'assets/puzzle_icon.png', AppLocalizations.of(context)!.puzzle_title, AppLocalizations.of(context)!.puzzle_description),
              buildSlide(Color(0xFF3366FF), 'assets/quiz_icon.png', AppLocalizations.of(context)!.quiz_title, AppLocalizations.of(context)!.quiz_description),
              buildSlide(Color(0xFF33FF57), 'assets/color_icon.png', AppLocalizations.of(context)!.color_title, AppLocalizations.of(context)!.color_description),
              buildSlide(Color(0xFF9933FF), 'assets/ic_reward.png', AppLocalizations.of(context)!.game_title, AppLocalizations.of(context)!.game_description),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? Colors.white : Colors.grey,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _currentPage > 0
                          ? () {
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentPage == 0 ? Color(0xFFCC4400).withOpacity(0.5) : Color(0xFFCC4400),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(AppLocalizations.of(context)!.previous),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage < 3) {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChooseGameScreen()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentPage == 0 ? Color(0xFFCC4400) :
                               _currentPage == 1 ? Color(0xFF2244BB) :
                               _currentPage == 2 ? Color(0xFF22BB44) :
                               Color(0xFF7722BB),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(_currentPage < 3 ? AppLocalizations.of(context)!.next : AppLocalizations.of(context)!.get_started),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlide(Color color, String imagePath, String title, String description) {
    return Container(
      color: color,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
