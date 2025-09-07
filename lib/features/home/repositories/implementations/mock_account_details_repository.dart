import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/account_details_repository.dart';
import 'package:meet_sam_ava/features/home/services/mock_data_service.dart';

class MockAccountDetailsRepository implements IAccountDetailsRepository {
  final _mockDataService = MockDataService();
  
  @override
  Future<Either<String, AccountDetails>> getAccountDetails() async {
    await Future.delayed(const Duration(milliseconds: 350));

    final scenario = _mockDataService.getCurrentScenario();
    
    return right(AccountDetails(
      spendLimitValue: 100.0,
      balanceValue: 30.0,
      creditLimitValue: 600.0,
      totalBalanceValue: scenario['totalBalance'] as double,
      totalLimitValue: scenario['totalLimit'] as double,
      currentSpend: 75.0,
      ratingLabel: scenario['rating'] as String,
    ));
  }

  @override
  Future<Either<String, void>> refreshAccountDetails() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return right(null);
  }
}
