import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class GameCard extends StatefulWidget {
  final Color color;
  final String imagePath;
  final Function onTap;

  GameCard({required this.color, required this.imagePath, required this.onTap});

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
                    AppLocalizations.of(context)!.secrets_of_museum_treasures, // Localized text
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
