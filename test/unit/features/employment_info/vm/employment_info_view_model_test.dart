import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:meet_sam_ava/features/employment_info/vm/employment_info_view_model.dart';
import 'package:meet_sam_ava/features/employment_info/model/employment_inputs.dart';

void main() {
  group('EmploymentInfoViewModel Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('EmploymentInfoState', () {
      test('should create initial state with pure inputs', () {
        const state = EmploymentInfoState();
        
        expect(state.employmentType, equals(const EmploymentTypeInput.pure()));
        expect(state.employer, equals(const EmployerInput.pure()));
        expect(state.jobTitle, equals(const JobTitleInput.pure()));
        expect(state.grossAnnualIncome, equals(const IncomeInput.pure()));
        expect(state.payFrequency, equals(const PayFrequencyInput.pure()));
        expect(state.address, equals(const AddressInput.pure()));
        expect(state.nextPayday, equals(const NextPaydayInput.pure()));
        expect(state.timeWithEmployer, equals(const TimeWithEmployerInput.pure()));
        expect(state.isDirectDeposit, equals(false));
        expect(state.status, equals(FormzSubmissionStatus.initial));
        expect(state.error, isNull);
        expect(state.isEditMode, equals(false));
        expect(state.originalData, isNull);
      });

      test('should validate form correctly with valid inputs', () {
        final state = const EmploymentInfoState().copyWith(
          employmentType: const EmploymentTypeInput.dirty('Full-time'),
          employer: const EmployerInput.dirty('Acme Corp'),
          jobTitle: const JobTitleInput.dirty('Software Engineer'),
          grossAnnualIncome: const IncomeInput.dirty('75000'),
          payFrequency: const PayFrequencyInput.dirty('Bi-weekly'),
          address: const AddressInput.dirty('123 Main St, City, ST 12345'),
          nextPayday: const NextPaydayInput.dirty('2024-01-15'),
          timeWithEmployer: const TimeWithEmployerInput.dirty('2 years, 6 months'),
        );

        expect(state.isValid, isTrue);
      });

      test('should invalidate form with empty required fields', () {
        const state = EmploymentInfoState();
        expect(state.isValid, isFalse);
      });

      test('should generate employment data correctly', () {
        final state = const EmploymentInfoState().copyWith(
          employmentType: const EmploymentTypeInput.dirty('Full-time'),
          employer: const EmployerInput.dirty('Acme Corp'),
          jobTitle: const JobTitleInput.dirty('Software Engineer'),
          grossAnnualIncome: const IncomeInput.dirty('75000'),
          payFrequency: const PayFrequencyInput.dirty('Bi-weekly'),
          address: const AddressInput.dirty('123 Main St, City, ST 12345'),
          nextPayday: const NextPaydayInput.dirty('2024-01-15'),
          isDirectDeposit: true,
          timeWithEmployer: const TimeWithEmployerInput.dirty('2 years, 6 months'),
        );

        final employmentData = state.employmentData;
        
        expect(employmentData.employmentType, equals('Full-time'));
        expect(employmentData.employer, equals('Acme Corp'));
        expect(employmentData.jobTitle, equals('Software Engineer'));
        expect(employmentData.grossAnnualIncome, equals('75000'));
        expect(employmentData.payFrequency, equals('Bi-weekly'));
        expect(employmentData.address, equals('123 Main St, City, ST 12345'));
        expect(employmentData.nextPayday, equals('2024-01-15'));
        expect(employmentData.isDirectDeposit, equals(true));
        expect(employmentData.timeWithEmployer, equals('2 years, 6 months'));
      });

      test('should copy with new values correctly', () {
        const initialState = EmploymentInfoState();
        
        final newState = initialState.copyWith(
          employmentType: const EmploymentTypeInput.dirty('Part-time'),
          isEditMode: true,
          status: FormzSubmissionStatus.inProgress,
        );

        expect(newState.employmentType.value, equals('Part-time'));
        expect(newState.isEditMode, isTrue);
        expect(newState.status, equals(FormzSubmissionStatus.inProgress));
        
        // Other properties should remain unchanged
        expect(newState.employer, equals(const EmployerInput.pure()));
        expect(newState.isDirectDeposit, equals(false));
      });

      test('should handle null direct deposit correctly', () {
        const state = EmploymentInfoState(isDirectDeposit: null);
        expect(state.employmentData.isDirectDeposit, isNull);
      });
    });

    group('Input Validation', () {
      test('EmploymentTypeInput should validate correctly', () {
        const pureInput = EmploymentTypeInput.pure();
        const validInput = EmploymentTypeInput.dirty('Full-time');
        const invalidInput = EmploymentTypeInput.dirty('');

        expect(pureInput.isPure, isTrue);
        expect(pureInput.isValid, isFalse); // Pure with empty value fails validation
        expect(pureInput.error, equals(EmploymentTypeValidationError.empty));
        expect(validInput.isValid, isTrue);
        expect(invalidInput.isValid, isFalse);
        expect(invalidInput.error, equals(EmploymentTypeValidationError.empty));
      });

      test('EmployerInput should validate correctly', () {
        const pureInput = EmployerInput.pure();
        const validInput = EmployerInput.dirty('Acme Corp');
        const invalidInput = EmployerInput.dirty('');

        expect(pureInput.isPure, isTrue);
        expect(pureInput.isValid, isFalse); // Pure with empty value fails validation
        expect(pureInput.error, equals(EmployerValidationError.empty));
        expect(validInput.isValid, isTrue);
        expect(invalidInput.isValid, isFalse);
        expect(invalidInput.error, equals(EmployerValidationError.empty));
      });

      test('IncomeInput should validate correctly', () {
        const pureInput = IncomeInput.pure();
        const validInput = IncomeInput.dirty('50000');
        const invalidInput = IncomeInput.dirty('invalid');
        const emptyInput = IncomeInput.dirty('');

        expect(pureInput.isPure, isTrue);
        expect(pureInput.isValid, isFalse); // Pure with empty value fails validation
        expect(pureInput.error, equals(IncomeValidationError.empty));
        expect(validInput.isValid, isTrue);
        expect(invalidInput.isValid, isFalse);
        expect(emptyInput.isValid, isFalse);
        expect(emptyInput.error, equals(IncomeValidationError.empty));
      });
    });
  });
}