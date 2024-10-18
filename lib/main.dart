import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainTrio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

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


class ChooseLanguageScreen extends StatefulWidget {
  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  final List<String> languages = ["English - US", "Serbian - Latinica", "Serbian - Ćirilica"];
  String selectedLanguage = "English - US";
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  _loadLanguage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selectedLanguage') ?? "English - US";
    });
  }

  _saveLanguage(String lang) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedLanguage', lang);
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
                'Choose your language',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedLanguage,
                items: languages.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedLanguage = newValue;
                    });
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
                    MaterialPageRoute(builder: (context) => IntroductionGameScreen(selectedLanguage: selectedLanguage)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF10C88),
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 50),
                ),
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                'Secrets of museum treasures',
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
                      'Welcome to the Secrets of Museum Treasures app!\n\n'
                      'Our mission is to inspire and educate people of all ages about the rich cultural heritage of the Republic of Serbia through an interactive experience provided by the "Secrets of Museum Treasures" app. '
                      'Through quizzes, puzzles, and coloring activities, we aim to enable users to explore and develop an appreciation for the treasures held within our country.\n\n'
                      'We strive to provide an educational experience that users will remember and to enrich education through entertainment. '
                      'Our quiz is tailored to school curricula to help students better understand and retain information from various subjects. '
                      'Through interactive questions, we encourage learning through play. Our goal is to foster curiosity and a desire to learn among young generations.\n\n'
                      'Our app seeks to inspire young generations to develop an interest in cultural heritage, history, art, and music. '
                      'Through stories and information, we aim to awaken curiosity and a passion for learning.\n\n'
                      'We are aware of the importance of collaboration with educational institutions. The "Secrets of Museum Treasures" app can be a valuable tool for teachers to enrich their lessons and motivate students to explore cultural heritage.\n\n'
                      'This app provides an opportunity for a socially interactive experience. '
                      'Users can share their achievements, puzzle solutions, and coloring creations with friends and family, strengthening their bonds.\n\n'
                      'We thank the Ministry of Culture and Information of the Republic of Serbia for their support of our project. '
                      'Their support has enabled us to develop this app and provide a high-quality educational experience for children and youth, as well as to continuously improve the app and deliver the highest-quality content to users.\n\n'
                      'Our desire is for "Secrets of Museum Treasures" to become a means to preserve and promote our cultural heritage, inspire youth to take an interest in art and history, and contribute to enriching the cultural identity of the Republic of Serbia.\n\n'
                      '"IGNITE YOUR MIND"\n\n'
                      'Thank you for being a part of this adventure and supporting our mission!\n\n'
                      'Project Manager:\n\n'
                      'Jelena Milenković,\n'
                      'Senior Museum Educator.',
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
                child: Text('Choose a game'),
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
              buildSlide(Color(0xFFFF5733), 'assets/puzzle_icon.png', 'Puzzle', 'Every piece is a key!'),
              buildSlide(Color(0xFF3366FF), 'assets/quiz_icon.png', 'Quiz', 'Challenge the answers, unlock the knowledge.'),
              buildSlide(Color(0xFF33FF57), 'assets/color_icon.png', 'Happy Color', 'Express yourself through colors.'),
              buildSlide(Color(0xFF9933FF), 'assets/ic_reward.png', 'Game', 'Secrets revealed through play.'),
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
                      child: Text('Previous'),
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
                      child: Text(_currentPage < 3 ? 'Next' : 'Get started'),
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
                'CHOOSE A GAME',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GameCard(
                title: 'Quiz',
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
                title: 'Slide Puzzle',
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
                title: 'Happy Color',
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