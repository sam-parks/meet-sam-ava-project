import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/employment_info/model/employment_data.dart';
import 'package:meet_sam_ava/features/employment_info/repositories/interfaces/employment_info_repository.dart';
import 'package:meet_sam_ava/features/employment_info/services/interfaces/employment_info_cache_service.dart';

class EmploymentInfoRepositoryImpl implements IEmploymentInfoRepository {
  final IEmploymentInfoCacheService _cacheService;

  EmploymentData? _cachedData;

  EmploymentInfoRepositoryImpl(
      {required IEmploymentInfoCacheService cacheService})
      : _cacheService = cacheService;

  @override
  Future<Either<String, EmploymentData?>> getEmploymentInfo() async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      _cachedData = await _cacheService.get();

      if (_cachedData != null) {
        return right(_cachedData);
      }

      return right(null);
    } catch (e) {
      return left('Failed to load employment information: $e');
    }
  }

  @override
  Future<Either<String, void>> saveEmploymentInfo(EmploymentData data) async {
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      await _cacheService.save(data);
      _cachedData = data;
      return right(null);
    } catch (e) {
      return left('Failed to save employment information: $e');
    }
  }

  @override
  Future<Either<String, void>> updateEmploymentInfo(EmploymentData data) async {
    return saveEmploymentInfo(data); // Same as save for this implementation
  }

  @override
  Future<Either<String, void>> deleteEmploymentInfo() async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      await _cacheService.delete();
      _cachedData = null;
      return right(null);
    } catch (e) {
      return left('Failed to delete employment information: $e');
    }
  }
}
