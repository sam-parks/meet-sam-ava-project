import 'package:intl/intl.dart';

class AccountDetails {
  final double spendLimitValue;
  final double balanceValue;
  final double creditLimitValue;
  final double totalBalanceValue;
  final double totalLimitValue;
  final double currentSpend;
  final String ratingLabel;
  final String currency;

  const AccountDetails({
    required this.spendLimitValue,
    required this.balanceValue,
    required this.creditLimitValue,
    required this.totalBalanceValue,
    required this.totalLimitValue,
    required this.currentSpend,
    required this.ratingLabel,
    this.currency = '\$',
  });

  // Currency formatted getters
  String get spendLimit => _formatCurrency(spendLimitValue);
  String get balance => _formatCurrency(balanceValue);
  String get creditLimit => _formatCurrency(creditLimitValue);
  String get totalBalance => _formatCurrency(totalBalanceValue);
  String get totalLimit => _formatCurrency(totalLimitValue);

  String _formatCurrency(double value) {
    final formatter = NumberFormat.currency(symbol: currency, decimalDigits: 0);
    return formatter.format(value);
  }

  factory AccountDetails.empty() => const AccountDetails(
        spendLimitValue: 0.0,
        balanceValue: 0.0,
        creditLimitValue: 0.0,
        totalBalanceValue: 0.0,
        totalLimitValue: 0.0,
        currentSpend: 0.0,
        ratingLabel: '',
      );

  AccountDetails copyWith({
    double? spendLimitValue,
    double? balanceValue,
    double? creditLimitValue,
    double? totalBalanceValue,
    double? totalLimitValue,
    double? currentSpend,
    String? ratingLabel,
    String? currency,
  }) {
    return AccountDetails(
      spendLimitValue: spendLimitValue ?? this.spendLimitValue,
      balanceValue: balanceValue ?? this.balanceValue,
      creditLimitValue: creditLimitValue ?? this.creditLimitValue,
      totalBalanceValue: totalBalanceValue ?? this.totalBalanceValue,
      totalLimitValue: totalLimitValue ?? this.totalLimitValue,
      currentSpend: currentSpend ?? this.currentSpend,
      ratingLabel: ratingLabel ?? this.ratingLabel,
      currency: currency ?? this.currency,
    );
  }
}
