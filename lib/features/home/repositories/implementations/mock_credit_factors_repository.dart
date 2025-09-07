import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/credit_factors_model.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_factors_repository.dart';
import 'package:meet_sam_ava/features/home/services/mock_data_service.dart';

class MockCreditFactorsRepository implements ICreditFactorsRepository {
  final _mockDataService = MockDataService();

  @override
  Future<Either<String, CreditFactors>> getCreditFactors() async {
    await Future.delayed(const Duration(milliseconds: 400));

    final scenario = _mockDataService.getCurrentScenario();
    final utilization = scenario['utilization'] as double;
    final impactStr = scenario['impact'] as String;

    // Map impact string to enum
    final impact = impactStr == 'high'
        ? CreditFactorImpact.high
        : impactStr == 'medium'
            ? CreditFactorImpact.medium
            : CreditFactorImpact.low;

    // Generate description based on utilization
    final description = utilization <= 9
        ? 'Excellent! Using a very small portion of your credit limit'
        : utilization <= 29
            ? 'Good! Using a reasonable portion of your credit limit'
            : utilization <= 49
                ? 'Fair. Consider reducing your credit usage'
                : utilization <= 74
                    ? 'High utilization may impact your score'
                    : 'Very high utilization is negatively impacting your score';

    final factors = [
      const CreditFactor(
        name: 'Payment History',
        percentage: '100%',
        impact: CreditFactorImpact.high,
        description: 'You always pay your bills on time',
      ),
      CreditFactor(
        name: 'Credit Card Utilization',
        percentage: '${utilization.round()}%',
        impact: impact,
        description: description,
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
