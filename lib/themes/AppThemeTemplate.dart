import 'package:flutter/material.dart';

@immutable
class AppThemeTemplate extends ThemeExtension<AppThemeTemplate> {
  final Color background;
  final Color pickerEntry;
  final Color entrySeparator;
  final Color favoriteButtonEnabled;
  final Color favoriteButtonDisabled;
  final Color entryText;
  final Color appBar;
  final Color backgroundConstrast;
  final Color audioDataBackground;
  final Color audioDataText;
  final Color slider;
  final Color sliderButtons;
  final Color accent;

  const AppThemeTemplate({
    required this.background,
    required this.pickerEntry,
    required this.entrySeparator,
    required this.favoriteButtonEnabled,
    required this.favoriteButtonDisabled,
    required this.entryText,
    required this.appBar,
    required this.backgroundConstrast,
    required this.audioDataBackground,
    required this.audioDataText,
    required this.slider,
    required this.sliderButtons,
    required this.accent,
  });

  @override
  AppThemeTemplate copyWith({
    Color? background,
    Color? pickerEntry,
    Color? entrySeparator,
    Color? favoriteButtonEnabled,
    Color? favoriteButtonDisabled,
    Color? entryText,
    Color? appBar,
    Color? backgroundConstrast,
    Color? audioDataBackground,
    Color? audioDataText,
    Color? slider,
    Color? sliderButtons,
    Color? accent,
  }) {
    return AppThemeTemplate(
      background: background ?? this.background,
      pickerEntry: pickerEntry ?? this.pickerEntry,
      entrySeparator: entrySeparator ?? this.entrySeparator,
      favoriteButtonEnabled: favoriteButtonEnabled ?? this.favoriteButtonEnabled,
      favoriteButtonDisabled: favoriteButtonDisabled ?? this.favoriteButtonDisabled,
      entryText: entryText ?? this.entryText,
      appBar: appBar ?? this.appBar,
      backgroundConstrast: backgroundConstrast ?? this.backgroundConstrast,
      audioDataBackground: audioDataBackground ?? this.audioDataBackground,
      audioDataText: audioDataText ?? this.audioDataText,
      slider: slider ?? this.slider,
      sliderButtons: sliderButtons ?? this.sliderButtons,
      accent: accent ?? this.accent,
    );
  }

  @override
  AppThemeTemplate lerp(ThemeExtension<AppThemeTemplate>? other, double t) {
    if (other is! AppThemeTemplate) return this;
    return AppThemeTemplate(
      background: Color.lerp(background, other.background, t)!,
      pickerEntry: Color.lerp(pickerEntry, other.pickerEntry, t)!,
      entrySeparator: Color.lerp(entrySeparator, other.entrySeparator, t)!,
      favoriteButtonEnabled: Color.lerp(favoriteButtonEnabled, other.favoriteButtonEnabled, t)!,
      favoriteButtonDisabled: Color.lerp(favoriteButtonDisabled, other.favoriteButtonDisabled, t)!,
      entryText: Color.lerp(entryText, other.entryText, t)!,
      appBar: Color.lerp(appBar, other.appBar, t)!,
      backgroundConstrast: Color.lerp(backgroundConstrast, other.backgroundConstrast, t)!,
      audioDataBackground: Color.lerp(audioDataBackground, other.audioDataBackground, t)!,
      audioDataText: Color.lerp(audioDataText, other.audioDataText, t)!,
      slider: Color.lerp(slider, other.slider, t)!,
      sliderButtons: Color.lerp(sliderButtons, other.sliderButtons, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }
}