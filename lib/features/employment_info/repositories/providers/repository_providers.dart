import 'package:meet_sam_ava/features/employment_info/repositories/implementations/employment_info_repository_impl.dart';
import 'package:meet_sam_ava/features/employment_info/repositories/interfaces/employment_info_repository.dart';
import 'package:meet_sam_ava/features/employment_info/services/providers/service_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@Riverpod(keepAlive: true)
IEmploymentInfoRepository employmentInfoRepository(Ref ref) {
  final cacheService = ref.read(employmentInfoCacheServiceProvider);
  return EmploymentInfoRepositoryImpl(cacheService: cacheService);
}
