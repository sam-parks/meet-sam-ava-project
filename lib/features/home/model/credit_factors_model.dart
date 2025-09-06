enum CreditFactorImpact { high, medium, low }

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