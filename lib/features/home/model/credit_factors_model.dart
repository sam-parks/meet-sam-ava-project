import 'dart:ui';

import 'package:meet_sam_ava/core/theme/tokens/color_tokens.dart';

enum CreditFactorImpact {
  high('HIGH IMPACT'),
  medium('MEDIUM IMPACT'),
  low('LOW IMPACT');

  final String label;

  const CreditFactorImpact(this.label);
}

extension CreditFactorImpactExtension on CreditFactorImpact {
  Color get backgroundColor {
    switch (this) {
      case CreditFactorImpact.high:
        return ColorTokens.secondaryDark;
      case CreditFactorImpact.medium:
        return ColorTokens.secondary;
      case CreditFactorImpact.low:
        return ColorTokens.secondaryLight;
    }
  }

  Color get textColor {
    switch (this) {
      case CreditFactorImpact.high:
        return ColorTokens.textOnSecondaryDark;
      case CreditFactorImpact.medium:
        return ColorTokens.textOnSecondaryDark;
      case CreditFactorImpact.low:
        return ColorTokens.textOnSecondaryLight;
    }
  }
}

class CreditFactor {
  final String name;
  final String percentage;
  final CreditFactorImpact impact;
  final String description;

  const CreditFactor({
    required this.name,
    required this.percentage,
    required this.impact,
    required this.description,
  });

  factory CreditFactor.empty() => const CreditFactor(
        name: '',
        percentage: '',
        impact: CreditFactorImpact.low,
        description: '',
      );

  CreditFactor copyWith({
    String? name,
    String? percentage,
    CreditFactorImpact? impact,
    String? description,
  }) {
    return CreditFactor(
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
      impact: impact ?? this.impact,
      description: description ?? this.description,
    );
  }
}

class CreditFactors {
  final List<CreditFactor> factors;

  const CreditFactors({required this.factors});

  factory CreditFactors.empty() => const CreditFactors(factors: []);

  CreditFactors copyWith({List<CreditFactor>? factors}) {
    return CreditFactors(factors: factors ?? this.factors);
  }
}
