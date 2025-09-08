// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(feedbackRepository)
const feedbackRepositoryProvider = FeedbackRepositoryProvider._();

final class FeedbackRepositoryProvider extends $FunctionalProvider<
    FeedbackRepository,
    FeedbackRepository,
    FeedbackRepository> with $Provider<FeedbackRepository> {
  const FeedbackRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedbackRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedbackRepositoryHash();

  @$internal
  @override
  $ProviderElement<FeedbackRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeedbackRepository create(Ref ref) {
    return feedbackRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedbackRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedbackRepository>(value),
    );
  }
}

String _$feedbackRepositoryHash() =>
    r'3ba4467d9e4da4e2a6a2c274a072c0076b9bc1d0';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
