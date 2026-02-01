import 'package:flutter/material.dart';
import 'package:loopplayer/themes/AppColorsDark.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';

class AppThemes{
  final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColorsDark.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsDark.appBar,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColorsDark.accent,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColorsDark.entryText),
      bodyMedium: TextStyle(color: AppColorsDark.entryText),
    ),
    colorScheme: ColorScheme.dark(
      background: AppColorsDark.background,
      primary: AppColorsDark.accent,
      secondary: AppColorsDark.accent,
      surface: AppColorsDark.backgroundConstrast,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: AppColorsDark.entryText,
    ),
    extensions: <ThemeExtension<dynamic>>[
      const AppThemeTemplate(
        background: AppColorsDark.background,
        pickerEntry: AppColorsDark.pickerEntry,
        entrySeparator: AppColorsDark.entrySeparator,
        favoriteButtonEnabled: AppColorsDark.favoriteButtonEnabled,
        favoriteButtonDisabled: AppColorsDark.favoriteButtonDisabled,
        entryText: AppColorsDark.entryText,
        appBar: AppColorsDark.appBar,
        backgroundConstrast: AppColorsDark.backgroundConstrast,
        audioDataBackground: AppColorsDark.audioDataBackground,
        audioDataText: AppColorsDark.audioDataText,
        slider: AppColorsDark.slider,
        sliderButtons: AppColorsDark.sliderButtons,
        accent: AppColorsDark.accent,
      ),
    ],
  );
}