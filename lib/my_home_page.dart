import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.choose_a_game), // Localized text for app bar
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle continue button press
          },
          child: Text(AppLocalizations.of(context)!.continue), // Localized text for button
        ),
      ),
    );
  }
}
