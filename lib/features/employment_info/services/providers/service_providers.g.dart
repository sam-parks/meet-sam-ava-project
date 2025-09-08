// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(employmentInfoCacheService)
const employmentInfoCacheServiceProvider =
    EmploymentInfoCacheServiceProvider._();

final class EmploymentInfoCacheServiceProvider extends $FunctionalProvider<
    IEmploymentInfoCacheService,
    IEmploymentInfoCacheService,
    IEmploymentInfoCacheService> with $Provider<IEmploymentInfoCacheService> {
  const EmploymentInfoCacheServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'employmentInfoCacheServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$employmentInfoCacheServiceHash();

  @$internal
  @override
  $ProviderElement<IEmploymentInfoCacheService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IEmploymentInfoCacheService create(Ref ref) {
    return employmentInfoCacheService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IEmploymentInfoCacheService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IEmploymentInfoCacheService>(value),
    );
  }
}

String _$employmentInfoCacheServiceHash() =>
    r'4fa66a152b672bba362e2bdd045dcf2c337b5701';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
