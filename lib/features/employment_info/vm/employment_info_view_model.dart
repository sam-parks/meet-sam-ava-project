import 'package:formz/formz.dart';
import 'package:meet_sam_ava/features/employment_info/model/employment_inputs.dart';
import 'package:meet_sam_ava/features/employment_info/model/employment_data.dart';
import 'package:meet_sam_ava/features/employment_info/repositories/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employment_info_view_model.g.dart';

class EmploymentInfoState {
  final EmploymentTypeInput employmentType;
  final EmployerInput employer;
  final JobTitleInput jobTitle;
  final IncomeInput grossAnnualIncome;
  final PayFrequencyInput payFrequency;
  final AddressInput address;
  final NextPaydayInput nextPayday;
  final bool? isDirectDeposit;
  final TimeWithEmployerInput timeWithEmployer;
  final FormzSubmissionStatus status;
  final String? error;
  final bool isEditMode;
  final EmploymentData? originalData;

  const EmploymentInfoState({
    this.employmentType = const EmploymentTypeInput.pure(),
    this.employer = const EmployerInput.pure(),
    this.jobTitle = const JobTitleInput.pure(),
    this.grossAnnualIncome = const IncomeInput.pure(),
    this.payFrequency = const PayFrequencyInput.pure(),
    this.address = const AddressInput.pure(),
    this.nextPayday = const NextPaydayInput.pure(),
    this.isDirectDeposit = false,
    this.timeWithEmployer = const TimeWithEmployerInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.error,
    this.isEditMode = false,
    this.originalData,
  });

  bool get isValid => Formz.validate([
        employmentType,
        employer,
        jobTitle,
        grossAnnualIncome,
        payFrequency,
        address,
        nextPayday,
        timeWithEmployer,
      ]);

  EmploymentData get employmentData => EmploymentData(
        employmentType: employmentType.value,
        employer: employer.value,
        jobTitle: jobTitle.value,
        grossAnnualIncome: grossAnnualIncome.value,
        payFrequency: payFrequency.value,
        address: address.value,
        nextPayday: nextPayday.value,
        isDirectDeposit: isDirectDeposit,
        timeWithEmployer: timeWithEmployer.value,
      );

  EmploymentInfoState copyWith({
    EmploymentTypeInput? employmentType,
    EmployerInput? employer,
    JobTitleInput? jobTitle,
    IncomeInput? grossAnnualIncome,
    PayFrequencyInput? payFrequency,
    AddressInput? address,
    NextPaydayInput? nextPayday,
    bool? isDirectDeposit,
    TimeWithEmployerInput? timeWithEmployer,
    FormzSubmissionStatus? status,
    String? error,
    bool? isEditMode,
    EmploymentData? originalData,
  }) =>
      EmploymentInfoState(
        employmentType: employmentType ?? this.employmentType,
        employer: employer ?? this.employer,
        jobTitle: jobTitle ?? this.jobTitle,
        grossAnnualIncome: grossAnnualIncome ?? this.grossAnnualIncome,
        payFrequency: payFrequency ?? this.payFrequency,
        address: address ?? this.address,
        nextPayday: nextPayday ?? this.nextPayday,
        isDirectDeposit: isDirectDeposit ?? this.isDirectDeposit,
        timeWithEmployer: timeWithEmployer ?? this.timeWithEmployer,
        status: status ?? this.status,
        error: error,
        isEditMode: isEditMode ?? this.isEditMode,
        originalData: originalData ?? this.originalData,
      );
}

@riverpod
class EmploymentInfoViewModel extends _$EmploymentInfoViewModel {
  @override
  Future<EmploymentInfoState> build() async {
    // Load data on initialization
    final repository = ref.read(employmentInfoRepositoryProvider);
    final result = await repository.getEmploymentInfo();

    return result.fold(
      (error) => EmploymentInfoState(
        error: error,
        status: FormzSubmissionStatus.failure,
      ),
      (data) {
        if (data != null) {
          // Return state with loaded data
          return EmploymentInfoState(
            employmentType: EmploymentTypeInput.dirty(data.employmentType),
            employer: EmployerInput.dirty(data.employer),
            jobTitle: JobTitleInput.dirty(data.jobTitle),
            grossAnnualIncome: IncomeInput.dirty(data.grossAnnualIncome),
            payFrequency: PayFrequencyInput.dirty(data.payFrequency),
            address: AddressInput.dirty(data.address),
            nextPayday: NextPaydayInput.dirty(data.nextPayday),
            isDirectDeposit: data.isDirectDeposit,
            timeWithEmployer:
                TimeWithEmployerInput.dirty(data.timeWithEmployer),
            originalData: data,
          );
        }
        // Return empty state if no data
        return const EmploymentInfoState();
      },
    );
  }

  void _populateFormWithData(EmploymentData data) {
    state = AsyncData(EmploymentInfoState(
      employmentType: EmploymentTypeInput.dirty(data.employmentType),
      employer: EmployerInput.dirty(data.employer),
      jobTitle: JobTitleInput.dirty(data.jobTitle),
      grossAnnualIncome: IncomeInput.dirty(data.grossAnnualIncome),
      payFrequency: PayFrequencyInput.dirty(data.payFrequency),
      address: AddressInput.dirty(data.address),
      nextPayday: NextPaydayInput.dirty(data.nextPayday),
      isDirectDeposit: data.isDirectDeposit,
      timeWithEmployer: TimeWithEmployerInput.dirty(data.timeWithEmployer),
      originalData: data, // Store original data for cancel functionality
    ));
  }

  void onEmploymentTypeChanged(String value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        employmentType: EmploymentTypeInput.dirty(value),
      ));
    });
  }

  void onEmployerChanged(String value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        employer: EmployerInput.dirty(value),
      ));
    });
  }

  void onJobTitleChanged(String value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        jobTitle: JobTitleInput.dirty(value),
      ));
    });
  }

  void onIncomeChanged(String value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        grossAnnualIncome: IncomeInput.dirty(value),
      ));
    });
  }

  void onPayFrequencyChanged(String value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        payFrequency: PayFrequencyInput.dirty(value),
      ));
    });
  }

  void onAddressChanged(String value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        address: AddressInput.dirty(value),
      ));
    });
  }

  void onNextPaydayChanged(String value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        nextPayday: NextPaydayInput.dirty(value),
      ));
    });
  }

  void onDirectDepositChanged(bool value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        isDirectDeposit: value,
      ));
    });
  }

  void onTimeWithEmployerChanged(String value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        timeWithEmployer: TimeWithEmployerInput.dirty(value),
      ));
    });
  }

  Future<bool> submit() async {
    return await state.maybeWhen(
      data: (currentState) async {
        final valid = currentState.isValid;
        if (!valid) {
          state = AsyncData(currentState.copyWith(
            employmentType: EmploymentTypeInput.dirty(currentState.employmentType.value),
            employer: EmployerInput.dirty(currentState.employer.value),
            jobTitle: JobTitleInput.dirty(currentState.jobTitle.value),
            grossAnnualIncome: IncomeInput.dirty(currentState.grossAnnualIncome.value),
            payFrequency: PayFrequencyInput.dirty(currentState.payFrequency.value),
            address: AddressInput.dirty(currentState.address.value),
            nextPayday: NextPaydayInput.dirty(currentState.nextPayday.value),
            timeWithEmployer:
                TimeWithEmployerInput.dirty(currentState.timeWithEmployer.value),
          ));
          return false;
        }

        state = AsyncData(currentState.copyWith(
          status: FormzSubmissionStatus.inProgress,
          error: null,
        ));

        final repository = ref.read(employmentInfoRepositoryProvider);
        final result = await repository.saveEmploymentInfo(currentState.employmentData);

        return result.fold(
          (error) {
            state = AsyncData(currentState.copyWith(
              status: FormzSubmissionStatus.failure,
              error: error,
            ));
            return false;
          },
          (_) {
            // Update original data after successful save
            state = AsyncData(currentState.copyWith(
              status: FormzSubmissionStatus.success,
              originalData: currentState.employmentData,
            ));
            return true;
          },
        );
      },
      orElse: () async => false,
    );
  }

  void toggleEditMode() {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        isEditMode: !currentState.isEditMode,
      ));
    });
  }

  void enterEditMode() {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        isEditMode: true,
      ));
    });
  }

  void exitEditMode() {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(
        isEditMode: false,
      ));
    });
  }

  void reset() {
    state = const AsyncData(EmploymentInfoState());
  }

  void cancel() {
    state.whenData((currentState) {
      if (currentState.originalData != null) {
        // Restore to the last saved state
        _populateFormWithData(currentState.originalData!);
      } else {
        // No saved data, reset to empty form
        state = const AsyncData(EmploymentInfoState());
      }
    });
  }
}
