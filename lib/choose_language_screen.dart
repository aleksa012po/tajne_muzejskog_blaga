import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phoenix/phoenix.dart';
import 'introduction_game_screen.dart';

class ChooseLanguageScreen extends StatefulWidget {
  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  final List<String> languages = ["English", "Serbian - Latinica", "Serbian - Ćirilica"];
  final List<String> languageCodes = ["en", "sr_Latn", "sr_Cyrl"];
  String selectedLanguage = "English";
  String selectedLanguageCode = "en";
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  _loadLanguage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguageCode = prefs.getString('selectedLanguage') ?? "en";
      selectedLanguage = languages[languageCodes.indexOf(selectedLanguageCode)];
    });
  }

  _saveLanguage(String langCode) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedLanguage', langCode);
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
                      selectedLanguageCode = languageCodes[languages.indexOf(newValue)];
                    });
                    _saveLanguage(selectedLanguageCode);
                  }
                },
                dropdownColor: Color(0xFF000B48),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Phoenix.rebirth(context);
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
