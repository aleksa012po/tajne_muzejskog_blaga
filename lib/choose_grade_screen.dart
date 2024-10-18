import 'package:flutter/material.dart';

class ChooseGradeScreen extends StatelessWidget {
  final String? selectedLanguage;

  ChooseGradeScreen({this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Grade'),
      ),
      body: Center(
        child: Text('Selected Language: ${selectedLanguage ?? 'Not selected'}'),
      ),
    );
  }
}
