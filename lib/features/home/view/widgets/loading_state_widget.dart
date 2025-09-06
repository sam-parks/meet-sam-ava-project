import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
      padding: EdgeInsets.all(SpacingTokens.space8),
      child: CircularProgressIndicator(),
    ),
    );
  }
}