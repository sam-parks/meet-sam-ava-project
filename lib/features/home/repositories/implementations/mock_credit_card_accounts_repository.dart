import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/credit_card_accounts_model.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_card_accounts_repository.dart';

class MockCreditCardAccountsRepository implements ICreditCardAccountsRepository {
  @override
  Future<Either<String, CreditCardAccounts>> getCreditCardAccounts() async {
    await Future.delayed(const Duration(milliseconds: 450));
    
    final accounts = [
      const CreditCardAccount(
        provider: 'Syncb/Amazon',
        balanceValue: 1500.0,
        creditLimitValue: 6300.0,
        reportedDate: 'Reported on June 20, 2023',
      ),
      const CreditCardAccount(
        provider: 'Chase Freedom',
        balanceValue: 850.0,
        creditLimitValue: 5000.0,
        reportedDate: 'Reported on June 18, 2023',
      ),
      const CreditCardAccount(
        provider: 'Discover it',
        balanceValue: 320.0,
        creditLimitValue: 2500.0,
        reportedDate: 'Reported on June 22, 2023',
      ),
    ];

    return right(CreditCardAccounts(accounts: accounts));
  }

  @override
  Future<Either<String, void>> refreshCreditCardAccounts() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return right(null);
  }
}