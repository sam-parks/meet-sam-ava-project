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
        utilizationPercentage: '21%',
        balance: '\$1,500 Balance',
        creditLimit: '\$6,500 Limit',
        reportedDate: 'Reported on June 30, 2023',
      ),
      const CreditCardAccount(
        provider: 'Syncb/Amazon',
        utilizationPercentage: '21%',
        balance: '\$1,500 Balance',
        creditLimit: '\$6,500 Limit',
        reportedDate: 'Reported on June 30, 2023',
      ),
      const CreditCardAccount(
        provider: 'Syncb/Amazon',
        utilizationPercentage: '21%',
        balance: '\$1,500 Balance',
        creditLimit: '\$6,500 Limit',
        reportedDate: 'Reported on June 30, 2023',
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