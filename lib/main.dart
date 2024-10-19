import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainTrio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: _locale,
      home: SplashScreen(setLocale: setLocale),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final Function(Locale) setLocale;

  SplashScreen({required this.setLocale});

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
        MaterialPageRoute(builder: (context) => ChooseLanguageScreen(setLocale: widget.setLocale)),
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

class ChooseLanguageScreen extends StatefulWidget {
  final Function(Locale) setLocale;

  ChooseLanguageScreen({required this.setLocale});

  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  final List<String> languages = L10n.all.map((locale) => L10n.getLanguageName(locale.toString())).toList();
  String? selectedLanguage; 
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  _loadLanguage() async {
    prefs = await SharedPreferences.getInstance();
    String? storedLanguageCode = prefs.getString('selectedLanguage');

  if (storedLanguageCode != null) {
    // Find the language name from the stored language code
    String languageName;
    switch (storedLanguageCode) {
      case 'en':
        languageName = 'English - US';
        break;
      case 'sr':
        languageName = 'Serbian - Latinica';
        break;
      case 'sr_Cyrl':
        languageName = 'Serbian - Ćirilica';
        break;
      default:
        languageName = 'English - US'; // Default to English
    }

    selectedLanguage = languageName;
    Locale storedLocale = L10n.getLocaleFromLanguage(languageName);
    widget.setLocale(storedLocale);
  } else {
    selectedLanguage = 'English - US'; // Default to English if no stored preference
    widget.setLocale(const Locale('en')); // Set default locale to English
  }
  setState(() {});
  }


  _saveLanguage(String lang) async {
   prefs = await SharedPreferences.getInstance();
   Locale localeToSave = L10n.getLocaleFromLanguage(lang);
   String languageCode = localeToSave.toString(); // This will be 'en','sr', or 'sr_Cyrl'
  if (localeToSave.scriptCode != null) {
    languageCode = '${localeToSave.languageCode}_${localeToSave.scriptCode}'; // Handle 'sr_Cyrl'
  }
   prefs.setString('selectedLanguage', languageCode);
   widget.setLocale(localeToSave);
   setState(() {
    selectedLanguage = lang;
  });
}


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
              Text(
                context.loc.choose_language,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedLanguage, 
                items: languages.map((language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(language, style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue!= null) {
                    _saveLanguage(newValue); 
                  }
                },
                dropdownColor: Color(0xFF000B48),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroductionGameScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF10C88),
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 50),
                ),
                child: Text(context.loc.continueButton), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroductionGameScreen extends StatelessWidget {
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
              Text(
                context.loc.secrets_of_museum_treasures,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
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
                      context.loc.welcome_text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
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
                child: Text(context.loc.choose_a_game),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroSliderScreen extends StatefulWidget {
  @override
  _IntroSliderScreenState createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

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
              buildSlide(Color(0xFFFF5733), 'assets/puzzle_icon.png', context.loc.puzzle_title, context.loc.puzzle_description),
              buildSlide(Color(0xFF3366FF), 'assets/quiz_icon.png', context.loc.quiz_title, context.loc.quiz_description),
              buildSlide(Color(0xFF33FF57), 'assets/color_icon.png', context.loc.color_title, context.loc.color_description),
              buildSlide(Color(0xFF9933FF), 'assets/ic_reward.png', context.loc.game_title, context.loc.game_description),
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
                      child: Text(context.loc.previous),
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
                      child: Text(_currentPage < 3 ? context.loc.next : context.loc.get_started),
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
}

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
                context.loc.choose_a_game,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GameCard(
                title: context.loc.quiz,
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
                title: context.loc.slide_puzzle,
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
                title: context.loc.happy_color,
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

class GameCard extends StatefulWidget {
  final String title;
  final Color color;
  final String imagePath;
  final Function onTap;

  GameCard({required this.title, required this.color, required this.imagePath, required this.onTap});

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: _isHovered ? widget.color.withOpacity(0.8) : widget.color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: _isHovered
                ? [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                Image.asset(widget.imagePath, width: 50, height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Center(child: Text("Quiz Screen")),
    );
  }
}

class SlidePuzzleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Slide Puzzle")),
      body: Center(child: Text("Slide Puzzle Screen")),
    );
  }
}

class HappyColorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Happy Color")),
      body: Center(child: Text("Happy Color Screen")),
    );
  }
}