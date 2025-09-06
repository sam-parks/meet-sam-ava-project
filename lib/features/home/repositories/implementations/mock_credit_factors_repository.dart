import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/credit_factors_model.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_factors_repository.dart';

class MockCreditFactorsRepository implements ICreditFactorsRepository {
  @override
  Future<Either<String, CreditFactors>> getCreditFactors() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final factors = [
      const CreditFactor(
        name: 'Payment History',
        percentage: '100%',
        impact: CreditFactorImpact.high,
        description: 'You always pay your bills on time',
      ),
      const CreditFactor(
        name: 'Credit Card Utilization',
        percentage: '4%',
        impact: CreditFactorImpact.low,
        description: 'Using a small portion of your credit limit',
      ),
      const CreditFactor(
        name: 'Derogatory Marks',
        percentage: '0',
        impact: CreditFactorImpact.medium,
        description: 'No negative marks on your credit report',
      ),
    ];

    return right(CreditFactors(factors: factors));
  }

  @override
  Future<Either<String, void>> refreshCreditFactors() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return right(null);
  }
}