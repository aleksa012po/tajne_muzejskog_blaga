import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'app_locale.dart';

extension LocalizedBuildContext on BuildContext {
  String getString(String key) {
    final localization = FlutterLocalization.instance;
    return localization.getString(key);
  }
}
