import 'package:meet_sam_ava/features/employment_info/model/employment_data.dart';

abstract class IEmploymentInfoCacheService {
  Future<EmploymentData?> get();
  Future<void> save(EmploymentData data);
  Future<void> delete();
  Future<bool> exists();
}