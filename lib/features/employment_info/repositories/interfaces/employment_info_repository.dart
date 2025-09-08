import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/employment_info/model/employment_data.dart';

abstract class IEmploymentInfoRepository {
  Future<Either<String, EmploymentData?>> getEmploymentInfo();
  Future<Either<String, void>> saveEmploymentInfo(EmploymentData data);
  Future<Either<String, void>> updateEmploymentInfo(EmploymentData data);
  Future<Either<String, void>> deleteEmploymentInfo();
}