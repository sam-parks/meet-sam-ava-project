import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class AnimatedFieldWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditMode;
  final Widget editWidget;
  final Widget? displayWidget;
  final Duration duration;

  const AnimatedFieldWidget({
    required this.label,
    required this.value,
    required this.isEditMode,
    required this.editWidget,
    this.displayWidget,
    this.duration = const Duration(milliseconds: 300),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: SpacingTokens.space2),
        AnimatedCrossFade(
          duration: duration,
          crossFadeState:
              isEditMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: displayWidget != null 
              ? SizedBox(
                  width: double.infinity,
                  child: displayWidget,
                )
              : SizedBox(
                  width: double.infinity,
                  child: Text(
                    value.isEmpty ? 'Not set' : value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: value.isEmpty
                              ? Theme.of(context).colorScheme.onSurfaceVariant
                              : null,
                        ),
                  ),
                ),
          secondChild: editWidget,
        ),
      ],
    );
  }
}
