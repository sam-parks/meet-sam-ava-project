import 'package:intl/intl.dart';

class CreditCardAccount {
  final String provider;
  final double balanceValue;
  final double creditLimitValue;
  final String reportedDate;
  final String currency;

  const CreditCardAccount({
    required this.provider,
    required this.balanceValue,
    required this.creditLimitValue,
    required this.reportedDate,
    this.currency = '\$',
  });

  // Computed getters
  String get balance => _formatCurrency(balanceValue);
  String get creditLimit => _formatCurrency(creditLimitValue);
  double get utilizationPercentage => creditLimitValue > 0 
      ? (balanceValue / creditLimitValue * 100).clamp(0.0, 100.0)
      : 0.0;
  String get utilizationPercentageString => '${utilizationPercentage.round()}%';

  String _formatCurrency(double value) {
    final formatter = NumberFormat.currency(symbol: currency, decimalDigits: 0);
    return formatter.format(value);
  }

  factory CreditCardAccount.empty() => const CreditCardAccount(
        provider: '',
        balanceValue: 0.0,
        creditLimitValue: 0.0,
        reportedDate: '',
      );

  CreditCardAccount copyWith({
    String? provider,
    double? balanceValue,
    double? creditLimitValue,
    String? reportedDate,
    String? currency,
  }) {
    return CreditCardAccount(
      provider: provider ?? this.provider,
      balanceValue: balanceValue ?? this.balanceValue,
      creditLimitValue: creditLimitValue ?? this.creditLimitValue,
      reportedDate: reportedDate ?? this.reportedDate,
      currency: currency ?? this.currency,
    );
  }
}

class CreditCardAccounts {
  final List<CreditCardAccount> accounts;

  const CreditCardAccounts({required this.accounts});

  factory CreditCardAccounts.empty() => const CreditCardAccounts(accounts: []);

  CreditCardAccounts copyWith({List<CreditCardAccount>? accounts}) {
    return CreditCardAccounts(accounts: accounts ?? this.accounts);
  }
}