import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/extensions/theme_extensions.dart';
import 'package:meet_sam_ava/core/theme/tokens/color_tokens.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/core/theme/tokens/typography_tokens.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

@riverpod
ThemeData appTheme(Ref ref, Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: isDark ? ColorTokensDark.primary : ColorTokens.primary,
    onPrimary:
        isDark ? ColorTokensDark.textOnPrimary : ColorTokens.textOnPrimary,
    primaryContainer:
        isDark ? ColorTokensDark.primaryDark : ColorTokens.primaryLight,
    onPrimaryContainer:
        isDark ? ColorTokensDark.textPrimary : ColorTokens.textPrimary,
    secondary: isDark ? ColorTokensDark.secondary : ColorTokens.secondary,
    onSecondary: ColorTokensDark.textOnSecondary,
    secondaryContainer:
        isDark ? ColorTokensDark.secondaryDark : ColorTokens.secondaryLight,
    onSecondaryContainer: isDark
        ? ColorTokensDark.textOnSecondaryDark
        : ColorTokens.textOnSecondaryLight,
    tertiary: isDark ? ColorTokensDark.info : ColorTokens.info,
    onTertiary: ColorTokens.textOnPrimary,
    tertiaryContainer:
        isDark ? ColorTokensDark.infoDark : ColorTokens.infoLight,
    onTertiaryContainer:
        isDark ? ColorTokensDark.textPrimary : ColorTokens.textPrimary,
    error: isDark ? ColorTokensDark.error : ColorTokens.error,
    onError: ColorTokens.textOnPrimary,
    errorContainer: isDark ? ColorTokensDark.errorDark : ColorTokens.errorLight,
    onErrorContainer:
        isDark ? ColorTokensDark.textPrimary : ColorTokens.textPrimary,
    surface: isDark ? ColorTokensDark.surface : ColorTokens.surface,
    onSurface: isDark ? ColorTokensDark.textPrimary : ColorTokens.textPrimary,
    surfaceContainerHighest:
        isDark ? ColorTokensDark.surfaceVariant : ColorTokens.surfaceVariant,
    onSurfaceVariant:
        isDark ? ColorTokensDark.textSecondary : ColorTokens.textSecondary,
    outline: isDark ? ColorTokensDark.border : ColorTokens.border,
    outlineVariant:
        isDark ? ColorTokensDark.borderLight : ColorTokens.borderLight,
    shadow: Colors.black26,
    scrim: Colors.black54,
    inverseSurface: isDark ? ColorTokens.surface : ColorTokensDark.surface,
    onInverseSurface:
        isDark ? ColorTokens.textPrimary : ColorTokensDark.textPrimary,
    inversePrimary: isDark ? ColorTokens.primary : ColorTokensDark.primary,
  );

  final textTheme = const TextTheme(
    displayLarge: TypographyTokens.displayLarge,
    displayMedium: TypographyTokens.displayMedium,
    displaySmall: TypographyTokens.displaySmall,
    headlineLarge: TypographyTokens.headlineLarge,
    headlineMedium: TypographyTokens.headlineMedium,
    headlineSmall: TypographyTokens.headlineSmall,
    titleLarge: TypographyTokens.titleLarge,
    titleMedium: TypographyTokens.titleMedium,
    titleSmall: TypographyTokens.titleSmall,
    bodyLarge: TypographyTokens.bodyLarge,
    bodyMedium: TypographyTokens.bodyMedium,
    bodySmall: TypographyTokens.bodySmall,
    labelLarge: TypographyTokens.labelLarge,
    labelMedium: TypographyTokens.labelMedium,
    labelSmall: TypographyTokens.labelSmall,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    textTheme: textTheme,
    fontFamily: TypographyTokens.fontFamily,
    scaffoldBackgroundColor:
        isDark ? ColorTokensDark.background : ColorTokens.background,
    cardTheme: CardThemeData(
      elevation: ElevationTokens.card,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isDark ? ColorTokens.borderDark : ColorTokens.borderLight,
        ),
        borderRadius: BorderRadius.circular(RadiusTokens.card),
      ),
      color: isDark ? ColorTokensDark.surface : ColorTokens.surface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: ElevationTokens.button,
        minimumSize: const Size.fromHeight(SizeTokens.buttonHeightLg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.button),
        ),
        backgroundColor: isDark ? ColorTokensDark.primary : ColorTokens.primary,
        foregroundColor:
            isDark ? ColorTokensDark.textOnPrimary : ColorTokens.textOnPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space6,
          vertical: SpacingTokens.space3,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(SizeTokens.buttonHeightLg),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isDark ? ColorTokensDark.primary : ColorTokens.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(RadiusTokens.button),
        ),
        textStyle: TypographyTokens.button,
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space6,
          vertical: SpacingTokens.space3,
        ),
        side: BorderSide(
          color: isDark ? ColorTokensDark.primary : ColorTokens.primary,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(SizeTokens.buttonHeightLg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.button),
        ),
        textStyle: TypographyTokens.button,
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space4,
          vertical: SpacingTokens.space2,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor:
          isDark ? ColorTokensDark.surfaceVariant : ColorTokens.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: BorderSide(
          color: isDark ? ColorTokensDark.border : ColorTokens.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: BorderSide(
          color: isDark ? ColorTokensDark.border : ColorTokens.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: BorderSide(
          color: isDark ? ColorTokensDark.primary : ColorTokens.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: BorderSide(
          color: isDark ? ColorTokensDark.error : ColorTokens.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: BorderSide(
          color: isDark ? ColorTokensDark.error : ColorTokens.error,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space4,
        vertical: SpacingTokens.space3,
      ),
      labelStyle: TypographyTokens.labelLarge.copyWith(
        color:
            isDark ? ColorTokensDark.textSecondary : ColorTokens.textSecondary,
      ),
      hintStyle: TypographyTokens.bodyMedium.copyWith(
        color: isDark ? ColorTokensDark.textTertiary : ColorTokens.textTertiary,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: ElevationTokens.appBar,
      centerTitle: false,
      backgroundColor: isDark ? ColorTokensDark.surface : ColorTokens.surface,
      foregroundColor:
          isDark ? ColorTokensDark.textPrimary : ColorTokens.textPrimary,
      titleTextStyle: TypographyTokens.headlineSmall.copyWith(
        color: isDark ? ColorTokensDark.textPrimary : ColorTokens.textPrimary,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: isDark ? ColorTokensDark.divider : ColorTokens.divider,
      thickness: 1,
      space: SpacingTokens.space4,
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.chip),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space3,
        vertical: SpacingTokens.space2,
      ),
    ),
    dialogTheme: DialogThemeData(
      elevation: ElevationTokens.dialog,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.dialog),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: ElevationTokens.bottomSheet,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RadiusTokens.bottomSheet),
        ),
      ),
      backgroundColor: isDark ? ColorTokensDark.surface : ColorTokens.surface,
    ),
    extensions: [
      AppThemeExtension(
        success: isDark ? ColorTokensDark.success : ColorTokens.success,
        successLight:
            isDark ? ColorTokensDark.successLight : ColorTokens.successLight,
        successDark:
            isDark ? ColorTokensDark.successDark : ColorTokens.successDark,
        warning: isDark ? ColorTokensDark.warning : ColorTokens.warning,
        warningLight:
            isDark ? ColorTokensDark.warningLight : ColorTokens.warningLight,
        warningDark:
            isDark ? ColorTokensDark.warningDark : ColorTokens.warningDark,
        info: isDark ? ColorTokensDark.info : ColorTokens.info,
        infoLight: isDark ? ColorTokensDark.infoLight : ColorTokens.infoLight,
        infoDark: isDark ? ColorTokensDark.infoDark : ColorTokens.infoDark,
        chartGradientStart: isDark
            ? ColorTokensDark.chartGradientStart
            : ColorTokens.chartGradientStart,
        chartGradientEnd: isDark
            ? ColorTokensDark.chartGradientEnd
            : ColorTokens.chartGradientEnd,
        textTertiary:
            isDark ? ColorTokensDark.textTertiary : ColorTokens.textTertiary,
        textDisabled:
            isDark ? ColorTokensDark.textDisabled : ColorTokens.textDisabled,
        borderDark:
            isDark ? ColorTokensDark.borderDark : ColorTokens.borderDark,
      ),
    ],
  );
}

@riverpod
ThemeData lightTheme(Ref ref) {
  return ref.watch(appThemeProvider(Brightness.light));
}

@riverpod
ThemeData darkTheme(Ref ref) {
  return ref.watch(appThemeProvider(Brightness.dark));
}
