import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/extensions/theme_extensions.dart';
import 'package:meet_sam_ava/core/theme/tokens/color_tokens.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/core/theme/tokens/typography_tokens.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
ThemeData appTheme(Ref ref) {
  final colorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: ColorTokens.primary,
    onPrimary: ColorTokens.textOnPrimary,
    primaryContainer: ColorTokens.primaryLight,
    onPrimaryContainer: ColorTokens.textPrimary,
    secondary: ColorTokens.secondary,
    onSecondary: ColorTokens.textOnPrimary,
    secondaryContainer: ColorTokens.secondaryLight,
    onSecondaryContainer: ColorTokens.textOnSecondaryLight,
    tertiary: ColorTokens.info,
    onTertiary: ColorTokens.textOnPrimary,
    tertiaryContainer: ColorTokens.infoLight,
    onTertiaryContainer: ColorTokens.textPrimary,
    error: ColorTokens.error,
    onError: ColorTokens.textOnPrimary,
    errorContainer: ColorTokens.errorLight,
    onErrorContainer: ColorTokens.textPrimary,
    surface: ColorTokens.surface,
    onSurface: ColorTokens.textPrimary,
    surfaceContainerHighest: ColorTokens.surfaceVariant,
    onSurfaceVariant: ColorTokens.textSecondary,
    outline: ColorTokens.border,
    outlineVariant: ColorTokens.borderLight,
    shadow: Colors.black26,
    scrim: Colors.black54,
    inverseSurface: ColorTokens.surfaceVariant,
    onInverseSurface: ColorTokens.textPrimary,
    inversePrimary: ColorTokens.primary,
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
    brightness: Brightness.light,
    colorScheme: colorScheme,
    textTheme: textTheme,
    fontFamily: TypographyTokens.fontFamily,
    scaffoldBackgroundColor: ColorTokens.background,
    cardTheme: CardThemeData(
      elevation: ElevationTokens.card,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: ColorTokens.borderLight,
        ),
        borderRadius: BorderRadius.circular(RadiusTokens.card),
      ),
      color: ColorTokens.surface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: ElevationTokens.button,
        minimumSize: const Size.fromHeight(SizeTokens.buttonHeightLg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.button),
        ),
        backgroundColor: ColorTokens.primary,
        foregroundColor: ColorTokens.textOnPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space6,
          vertical: SpacingTokens.space3,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: ColorTokens.background,
        foregroundColor: ColorTokens.primary,
        minimumSize: const Size.fromHeight(SizeTokens.buttonHeightLg),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: ColorTokens.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(RadiusTokens.button),
        ),
        textStyle: TypographyTokens.button,
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space6,
          vertical: SpacingTokens.space3,
        ),
        side: const BorderSide(
          color: ColorTokens.primary,
           width: 2,
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
      fillColor: ColorTokens.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: const BorderSide(
          color: ColorTokens.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: const BorderSide(
          color: ColorTokens.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: const BorderSide(
          color: ColorTokens.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: const BorderSide(
          color: ColorTokens.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.input),
        borderSide: const BorderSide(
          color: ColorTokens.error,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space4,
        vertical: SpacingTokens.space3,
      ),
      labelStyle: TypographyTokens.labelLarge.copyWith(
        color: ColorTokens.textSecondary,
      ),
      hintStyle: TypographyTokens.bodyMedium.copyWith(
        color: ColorTokens.textTertiary,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: ElevationTokens.appBar,
      centerTitle: false,
      backgroundColor: ColorTokens.surface,
      foregroundColor: ColorTokens.textPrimary,
      titleTextStyle: TypographyTokens.headlineSmall.copyWith(
        color: ColorTokens.textPrimary,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: ColorTokens.divider,
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
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: ElevationTokens.bottomSheet,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RadiusTokens.bottomSheet),
        ),
      ),
      backgroundColor: ColorTokens.surface,
    ),
    extensions: const [
      AppThemeExtension(
        success: ColorTokens.success,
        successLight: ColorTokens.successLight,
        successDark: ColorTokens.successDark,
        warning: ColorTokens.warning,
        warningLight: ColorTokens.warningLight,
        warningDark: ColorTokens.warningDark,
        info: ColorTokens.info,
        infoLight: ColorTokens.infoLight,
        infoDark: ColorTokens.infoDark,
        chartGradientStart: ColorTokens.chartGradientStart,
        chartGradientEnd: ColorTokens.chartGradientEnd,
        textTertiary: ColorTokens.textTertiary,
        textDisabled: ColorTokens.textDisabled,
        borderDark: ColorTokens.borderDark,
      ),
    ],
  );
}
