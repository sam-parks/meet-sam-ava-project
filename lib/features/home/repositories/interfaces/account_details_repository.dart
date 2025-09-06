import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';

abstract class IAccountDetailsRepository {
  Future<Either<String, AccountDetails>> getAccountDetails();
  Future<Either<String, void>> refreshAccountDetails();
}