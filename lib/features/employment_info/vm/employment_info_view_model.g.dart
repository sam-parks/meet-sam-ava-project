// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employment_info_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EmploymentInfoViewModel)
const employmentInfoViewModelProvider = EmploymentInfoViewModelProvider._();

final class EmploymentInfoViewModelProvider extends $AsyncNotifierProvider<
    EmploymentInfoViewModel, EmploymentInfoState> {
  const EmploymentInfoViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'employmentInfoViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$employmentInfoViewModelHash();

  @$internal
  @override
  EmploymentInfoViewModel create() => EmploymentInfoViewModel();
}

String _$employmentInfoViewModelHash() =>
    r'42f6fc699917e530ac0627a45d61813eaa38ea23';

abstract class _$EmploymentInfoViewModel
    extends $AsyncNotifier<EmploymentInfoState> {
  FutureOr<EmploymentInfoState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<EmploymentInfoState>, EmploymentInfoState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<EmploymentInfoState>, EmploymentInfoState>,
        AsyncValue<EmploymentInfoState>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
