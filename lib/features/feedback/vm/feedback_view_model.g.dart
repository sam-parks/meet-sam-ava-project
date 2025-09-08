// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FeedbackViewModel)
const feedbackViewModelProvider = FeedbackViewModelProvider._();

final class FeedbackViewModelProvider
    extends $NotifierProvider<FeedbackViewModel, FeedbackState> {
  const FeedbackViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedbackViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedbackViewModelHash();

  @$internal
  @override
  FeedbackViewModel create() => FeedbackViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedbackState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedbackState>(value),
    );
  }
}

String _$feedbackViewModelHash() => r'4cac41412b7880355efeedcb7171814ed5cca26c';

abstract class _$FeedbackViewModel extends $Notifier<FeedbackState> {
  FeedbackState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FeedbackState, FeedbackState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<FeedbackState, FeedbackState>,
        FeedbackState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
