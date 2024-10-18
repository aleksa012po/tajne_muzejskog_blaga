import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'introduction_game_screen.dart'; // Make sure to create this file

class ChooseLanguageScreen extends StatefulWidget {
  final Function(Locale) onLanguageChanged;

  ChooseLanguageScreen({required this.onLanguageChanged});

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
    await prefs.setString('selectedLanguage', lang);
    widget.onLanguageChanged(_getLocaleFromLanguage(lang));
  }

  Locale _getLocaleFromLanguage(String language) {
    switch (language) {
      case "English - US":
        return Locale('en');
      case "Serbian - Latinica":
        return Locale('sr', 'Latn');
      case "Serbian - Ćirilica":
        return Locale('sr', 'Cyrl');
      default:
        return Locale('en');
    }
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
                AppLocalizations.of(context)!.chooseLanguage,
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
                    MaterialPageRoute(builder: (context) => IntroductionGameScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF10C88),
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 50),
                ),
                child: Text(AppLocalizations.of(context)!.continue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}