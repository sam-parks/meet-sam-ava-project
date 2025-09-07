import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/account_details_repository.dart';

class MockAccountDetailsRepository implements IAccountDetailsRepository {
  @override
  Future<Either<String, AccountDetails>> getAccountDetails() async {
    await Future.delayed(const Duration(milliseconds: 350));

    return right(const AccountDetails(
      spendLimitValue: 100.0,
      balanceValue: 30.0,
      creditLimitValue: 600.0,
      totalBalanceValue: 8390.0,
      totalLimitValue: 200900.0,
      currentSpend: 75.0,
      ratingLabel: 'Excellent',
    ));
  }

  @override
  Future<Either<String, void>> refreshAccountDetails() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return right(null);
  }
}
