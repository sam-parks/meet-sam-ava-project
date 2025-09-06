import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';

abstract class ICreditScoreRepository {
  Future<Either<String, CreditScore>> getCreditScore();
  Future<Either<String, CreditScoreChart>> getCreditScoreChart();
  Future<Either<String, void>> refreshCreditScore();
}