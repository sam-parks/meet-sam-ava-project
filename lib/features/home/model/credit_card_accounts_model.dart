class CreditCardAccount {
  final String provider;
  final String utilizationPercentage;
  final String balance;
  final String creditLimit;
  final String reportedDate;

  const CreditCardAccount({
    required this.provider,
    required this.utilizationPercentage,
    required this.balance,
    required this.creditLimit,
    required this.reportedDate,
  });

  factory CreditCardAccount.empty() => const CreditCardAccount(
        provider: '',
        utilizationPercentage: '',
        balance: '',
        creditLimit: '',
        reportedDate: '',
      );

  CreditCardAccount copyWith({
    String? provider,
    String? utilizationPercentage,
    String? balance,
    String? creditLimit,
    String? reportedDate,
  }) {
    return CreditCardAccount(
      provider: provider ?? this.provider,
      utilizationPercentage: utilizationPercentage ?? this.utilizationPercentage,
      balance: balance ?? this.balance,
      creditLimit: creditLimit ?? this.creditLimit,
      reportedDate: reportedDate ?? this.reportedDate,
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