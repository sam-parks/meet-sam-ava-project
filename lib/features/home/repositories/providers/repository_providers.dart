import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_score_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_factors_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/account_details_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_card_accounts_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/implementations/mock_credit_score_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/implementations/mock_credit_factors_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/implementations/mock_account_details_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/implementations/mock_credit_card_accounts_repository.dart';

part 'repository_providers.g.dart';

@riverpod
ICreditScoreRepository creditScoreRepository(Ref ref) {
  return MockCreditScoreRepository();
}

@riverpod
ICreditFactorsRepository creditFactorsRepository(Ref ref) {
  return MockCreditFactorsRepository();
}

@riverpod
IAccountDetailsRepository accountDetailsRepository(Ref ref) {
  return MockAccountDetailsRepository();
}

@riverpod
ICreditCardAccountsRepository creditCardAccountsRepository(Ref ref) {
  return MockCreditCardAccountsRepository();
}
