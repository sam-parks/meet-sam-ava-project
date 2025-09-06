import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/color_tokens.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class TitleWithBadge extends StatelessWidget {
  final String title;
  final String badgeText;
  final TextStyle? titleStyle;
  final TextStyle? badgeTextStyle;
  final Color? badgeBackgroundColor;
  final EdgeInsetsGeometry? badgePadding;
  final double? badgeBorderRadius;

  const TitleWithBadge({
    required this.title,
    required this.badgeText,
    this.titleStyle,
    this.badgeTextStyle,
    this.badgeBackgroundColor,
    this.badgePadding,
    this.badgeBorderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: titleStyle ??
              Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
        ),
        const SizedBox(width: SpacingTokens.space2),
        Container(
          padding: badgePadding ??
              const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space2,
              ),
          decoration: BoxDecoration(
            color: badgeBackgroundColor ?? ColorTokens.secondary,
            borderRadius: BorderRadius.circular(
              badgeBorderRadius ?? RadiusTokens.xxxl,
            ),
          ),
          child: Text(
            badgeText,
            style: badgeTextStyle ??
                Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.w600,
                    ),
          ),
        ),
      ],
    );
  }
}
