class AccountDetails {
  final String spendLimit;
  final String balance;
  final String creditLimit;
  final String utilizationPercentage;
  final String totalBalance;
  final String totalLimit;
  final String ratingLabel;
  final List<UtilizationRange> utilizationRanges;

  const AccountDetails({
    required this.spendLimit,
    required this.balance,
    required this.creditLimit,
    required this.utilizationPercentage,
    required this.totalBalance,
    required this.totalLimit,
    required this.ratingLabel,
    required this.utilizationRanges,
  });

  factory AccountDetails.empty() => const AccountDetails(
        spendLimit: '',
        balance: '',
        creditLimit: '',
        utilizationPercentage: '',
        totalBalance: '',
        totalLimit: '',
        ratingLabel: '',
        utilizationRanges: [],
      );

  AccountDetails copyWith({
    String? spendLimit,
    String? balance,
    String? creditLimit,
    String? utilizationPercentage,
    String? totalBalance,
    String? totalLimit,
    String? ratingLabel,
    List<UtilizationRange>? utilizationRanges,
  }) {
    return AccountDetails(
      spendLimit: spendLimit ?? this.spendLimit,
      balance: balance ?? this.balance,
      creditLimit: creditLimit ?? this.creditLimit,
      utilizationPercentage: utilizationPercentage ?? this.utilizationPercentage,
      totalBalance: totalBalance ?? this.totalBalance,
      totalLimit: totalLimit ?? this.totalLimit,
      ratingLabel: ratingLabel ?? this.ratingLabel,
      utilizationRanges: utilizationRanges ?? this.utilizationRanges,
    );
  }
}

class UtilizationRange {
  final String range;
  final bool isActive;

  const UtilizationRange({
    required this.range,
    required this.isActive,
  });

  UtilizationRange copyWith({String? range, bool? isActive}) {
    return UtilizationRange(
      range: range ?? this.range,
      isActive: isActive ?? this.isActive,
    );
  }
}