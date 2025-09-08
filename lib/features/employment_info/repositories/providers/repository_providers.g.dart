// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(employmentInfoRepository)
const employmentInfoRepositoryProvider = EmploymentInfoRepositoryProvider._();

final class EmploymentInfoRepositoryProvider extends $FunctionalProvider<
    IEmploymentInfoRepository,
    IEmploymentInfoRepository,
    IEmploymentInfoRepository> with $Provider<IEmploymentInfoRepository> {
  const EmploymentInfoRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'employmentInfoRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$employmentInfoRepositoryHash();

  @$internal
  @override
  $ProviderElement<IEmploymentInfoRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IEmploymentInfoRepository create(Ref ref) {
    return employmentInfoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IEmploymentInfoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IEmploymentInfoRepository>(value),
    );
  }
}

String _$employmentInfoRepositoryHash() =>
    r'484bcf766589ec9532ad30a6d0b16db054e3239b';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
