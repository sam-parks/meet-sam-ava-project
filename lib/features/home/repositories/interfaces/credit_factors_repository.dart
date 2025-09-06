import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/credit_factors_model.dart';

abstract class ICreditFactorsRepository {
  Future<Either<String, CreditFactors>> getCreditFactors();
  Future<Either<String, void>> refreshCreditFactors();
}