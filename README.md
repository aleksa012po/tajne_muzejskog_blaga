# BrainTrio - Museum Interactive App

**BrainTrio** is a Flutter-based interactive application designed for museums to engage visitors with fun and educational games. The app includes multiple games like quizzes, slide puzzles, and coloring activities, all themed around museum treasures. It supports multiple languages and provides a seamless user experience.

**Features**

**Multi-language Support**: Choose between English, Serbian (Latin), and Serbian (Cyrillic).

**Interactive Games**:

**Quiz**: Test your knowledge about museum artifacts.

**Slide Puzzle**: Solve puzzles featuring museum treasures.

**Happy Color**: Color museum-related images and learn about their history.

**Splash Screen**: A visually appealing introduction to the app.

**Language Selection**: Users can select their preferred language at the start.

**Localization**: All text is localized for a better user experience.

# Getting Started

Prerequisites

**Flutter SDK**: Make sure you have Flutter installed on your machine. If not, follow the official installation guide.

**Dart**: Flutter uses Dart as its programming language. Ensure you have Dart installed alongside Flutter.

**IDE**: Use **Android Studio** or **VS Code** with the Flutter and Dart plugins installed.

**Installation**

**1. Clone the repository:**
git clone https://github.com/your-username/brain-trio-museum-app.git
cd brain-trio-museum-app

**2. Install dependencies:**
flutter pub get

**3. Run the app:**
flutter run

# Project Structure

Here’s an overview of the project structure:

brain-trio-museum-app/
|-- lib/
|   |-- main.dart              **Entry point of the application**
|   |-- l10n.dart              **Localization configuration**
|   |-- screens/               **Contains all the screens of the app**
|   |   |-- splash_screen.dart
|   |   |-- choose_language_screen.dart
|   |   |-- introduction_game_screen.dart
|   |   |-- intro_slider_screen.dart
|   |   |-- choose_game_screen.dart
|   |   |-- quiz_screen.dart
|   |   |-- slide_puzzle_screen.dart
|   |   |-- happy_color_screen.dart
|   |-- widgets/               **Reusable widgets**
|       |-- game_card.dart
|-- assets/                    **Contains images, icons, and other static files**
|-- l10n/                      **Localization files**
|-- pubspec.yaml               **Project dependencies and metadata**

# Localization

The app supports multiple languages. To add or modify translations:

**1. Add new translations:**

Navigate to the l10n/ directory.
Add or modify the .arb files (e.g., app_en.arb, app_sr.arb, app_sr_Cyrl.arb).

**2. Generate localization files:**
   
Run the following command to generate the localization files:
flutter gen-l10n

**3. Update supported locales:**
Modify the L10n.all list in l10n.dart to include new locales.

# Building the App

**Android**

**1. Generate a release APK:**
flutter build apk --release

**2. Generate an app bundle:**
flutter build appbundle --release

**iOS**

**1. Build for iOS:**
flutter build ios --release

**2. Open the project in Xcode:**
open ios/Runner.xcworkspace

**3. Archive and distribute via Xcode.**

# LICENSE
This project is licensed under the MIT License. See the **LICENSE** file for details.

**Acknowledgments**

**Museum Partners:**: Thanks to the museum for providing the content and inspiration.

**Flutter Community:**: For the amazing tools and libraries that made this project possible.

 #Contact

For any questions or feedback, feel free to reach out:

Mail: **aleksa012po@gmail.com**

GitHub: **aleksa012po**

This #README.md provides a comprehensive guide for users and contributors. Make sure to replace placeholders like your-username, your-email@example.com, and add actual screenshots for a more polished look. Good luck with your project! 🚀
