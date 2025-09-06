import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/account_details_repository.dart';

class MockAccountDetailsRepository implements IAccountDetailsRepository {
  @override
  Future<Either<String, AccountDetails>> getAccountDetails() async {
    await Future.delayed(const Duration(milliseconds: 350));
    
    final utilizationRanges = [
      const UtilizationRange(range: '0-9%', isActive: true),
      const UtilizationRange(range: '10-29%', isActive: false),
      const UtilizationRange(range: '30-49%', isActive: false),
      const UtilizationRange(range: '50-74%', isActive: false),
      const UtilizationRange(range: '>75%', isActive: false),
    ];

    return right(AccountDetails(
      spendLimit: '\$100',
      balance: '\$30',
      creditLimit: '\$600',
      utilizationPercentage: '4%',
      totalBalance: '\$8,390',
      totalLimit: '\$200,900',
      ratingLabel: 'Excellent',
      utilizationRanges: utilizationRanges,
    ));
  }

  @override
  Future<Either<String, void>> refreshAccountDetails() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return right(null);
  }
}