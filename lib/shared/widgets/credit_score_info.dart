import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/shared/widgets/title_with_badge.dart';

class CreditScoreInfo extends StatelessWidget {
  final String title;
  final String badgeText;
  final String? subtitle;
  final String? provider;
  final TextStyle? titleStyle;
  final TextStyle? badgeTextStyle;
  final Color? badgeBackgroundColor;

  const CreditScoreInfo({
    required this.title,
    required this.badgeText,
    this.subtitle,
    this.provider,
    this.titleStyle,
    this.badgeTextStyle,
    this.badgeBackgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithBadge(
          title: title,
          badgeText: badgeText,
          titleStyle: titleStyle,
          badgeTextStyle: badgeTextStyle,
          badgeBackgroundColor: badgeBackgroundColor,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: SpacingTokens.space1),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
        if (provider != null) ...[
          const SizedBox(height: SpacingTokens.space3),
          Text(
            provider!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ],
    );
  }
}