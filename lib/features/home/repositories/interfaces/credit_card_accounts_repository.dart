import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/credit_card_accounts_model.dart';

abstract class ICreditCardAccountsRepository {
  Future<Either<String, CreditCardAccounts>> getCreditCardAccounts();
  Future<Either<String, void>> refreshCreditCardAccounts();
}