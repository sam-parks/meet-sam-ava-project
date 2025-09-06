import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color success;
  final Color successLight;
  final Color successDark;
  final Color warning;
  final Color warningLight;
  final Color warningDark;
  final Color info;
  final Color infoLight;
  final Color infoDark;
  final Color chartGradientStart;
  final Color chartGradientEnd;
  final Color textTertiary;
  final Color textDisabled;
  final Color borderDark;

  const AppThemeExtension({
    required this.success,
    required this.successLight,
    required this.successDark,
    required this.warning,
    required this.warningLight,
    required this.warningDark,
    required this.info,
    required this.infoLight,
    required this.infoDark,
    required this.chartGradientStart,
    required this.chartGradientEnd,
    required this.textTertiary,
    required this.textDisabled,
    required this.borderDark,
  });

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? success,
    Color? successLight,
    Color? successDark,
    Color? warning,
    Color? warningLight,
    Color? warningDark,
    Color? info,
    Color? infoLight,
    Color? infoDark,
    Color? chartGradientStart,
    Color? chartGradientEnd,
    Color? textTertiary,
    Color? textDisabled,
    Color? borderDark,
  }) {
    return AppThemeExtension(
      success: success ?? this.success,
      successLight: successLight ?? this.successLight,
      successDark: successDark ?? this.successDark,
      warning: warning ?? this.warning,
      warningLight: warningLight ?? this.warningLight,
      warningDark: warningDark ?? this.warningDark,
      info: info ?? this.info,
      infoLight: infoLight ?? this.infoLight,
      infoDark: infoDark ?? this.infoDark,
      chartGradientStart: chartGradientStart ?? this.chartGradientStart,
      chartGradientEnd: chartGradientEnd ?? this.chartGradientEnd,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      borderDark: borderDark ?? this.borderDark,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      successDark: Color.lerp(successDark, other.successDark, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      warningDark: Color.lerp(warningDark, other.warningDark, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoLight: Color.lerp(infoLight, other.infoLight, t)!,
      infoDark: Color.lerp(infoDark, other.infoDark, t)!,
      chartGradientStart:
          Color.lerp(chartGradientStart, other.chartGradientStart, t)!,
      chartGradientEnd:
          Color.lerp(chartGradientEnd, other.chartGradientEnd, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      borderDark: Color.lerp(borderDark, other.borderDark, t)!,
    );
  }
}

extension AppThemeExtensions on BuildContext {
  AppThemeExtension get appTheme {
    return Theme.of(this).extension<AppThemeExtension>()!;
  }
}
