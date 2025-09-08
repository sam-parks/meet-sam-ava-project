import 'package:meet_sam_ava/features/employment_info/services/implementations/employment_info_cache_service.dart';
import 'package:meet_sam_ava/features/employment_info/services/interfaces/employment_info_cache_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_providers.g.dart';

@Riverpod(keepAlive: true)
IEmploymentInfoCacheService employmentInfoCacheService(Ref ref) {
  return EmploymentInfoCacheService();
}
