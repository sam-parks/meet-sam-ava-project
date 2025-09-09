import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class AnimatedDropdownWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditMode;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  final Duration duration;

  const AnimatedDropdownWidget({
    required this.label,
    required this.value,
    required this.isEditMode,
    required this.items,
    required this.onChanged,
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
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: SpacingTokens.space2),
        AnimatedCrossFade(
          duration: duration,
          crossFadeState:
              isEditMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: SizedBox(
            width: double.infinity,
            child: Text(
              value.isEmpty ? 'Not selected' : value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: value.isEmpty
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : null,
                  ),
            ),
          ),
          secondChild: DropdownButtonFormField<String>(
            value: value.isEmpty ? null : value,
            items: items,
            onChanged: onChanged,
            decoration: const InputDecoration(),
          ),
        ),
      ],
    );
  }
}
