import 'package:formz/formz.dart';

enum EmploymentTypeValidationError { empty }

class EmploymentTypeInput extends FormzInput<String, EmploymentTypeValidationError> {
  const EmploymentTypeInput.pure() : super.pure('');
  const EmploymentTypeInput.dirty([super.value = '']) : super.dirty();

  @override
  EmploymentTypeValidationError? validator(String value) {
    return value.isEmpty ? EmploymentTypeValidationError.empty : null;
  }
}

enum EmployerValidationError { empty }

class EmployerInput extends FormzInput<String, EmployerValidationError> {
  const EmployerInput.pure() : super.pure('');
  const EmployerInput.dirty([super.value = '']) : super.dirty();

  @override
  EmployerValidationError? validator(String value) {
    return value.isEmpty ? EmployerValidationError.empty : null;
  }
}

enum JobTitleValidationError { empty }

class JobTitleInput extends FormzInput<String, JobTitleValidationError> {
  const JobTitleInput.pure() : super.pure('');
  const JobTitleInput.dirty([super.value = '']) : super.dirty();

  @override
  JobTitleValidationError? validator(String value) {
    return value.isEmpty ? JobTitleValidationError.empty : null;
  }
}

enum IncomeValidationError { empty, invalid }

class IncomeInput extends FormzInput<String, IncomeValidationError> {
  const IncomeInput.pure() : super.pure('');
  const IncomeInput.dirty([super.value = '']) : super.dirty();

  @override
  IncomeValidationError? validator(String value) {
    if (value.isEmpty) return IncomeValidationError.empty;
    
    final cleanValue = value.replaceAll(RegExp(r'[^\d.]'), '');
    final parsed = double.tryParse(cleanValue);
    
    return parsed == null || parsed <= 0 
        ? IncomeValidationError.invalid 
        : null;
  }
}

enum PayFrequencyValidationError { empty }

class PayFrequencyInput extends FormzInput<String, PayFrequencyValidationError> {
  const PayFrequencyInput.pure() : super.pure('');
  const PayFrequencyInput.dirty([super.value = '']) : super.dirty();

  @override
  PayFrequencyValidationError? validator(String value) {
    return value.isEmpty ? PayFrequencyValidationError.empty : null;
  }
}

enum AddressValidationError { empty, invalid }

class AddressInput extends FormzInput<String, AddressValidationError> {
  const AddressInput.pure() : super.pure('');
  const AddressInput.dirty([super.value = '']) : super.dirty();

  @override
  AddressValidationError? validator(String value) {
    if (value.isEmpty) return AddressValidationError.empty;
    return value.length < 10 ? AddressValidationError.invalid : null;
  }
}

enum NextPaydayValidationError { empty }

class NextPaydayInput extends FormzInput<String, NextPaydayValidationError> {
  const NextPaydayInput.pure() : super.pure('');
  const NextPaydayInput.dirty([super.value = '']) : super.dirty();

  @override
  NextPaydayValidationError? validator(String value) {
    return value.isEmpty ? NextPaydayValidationError.empty : null;
  }
}

enum TimeWithEmployerValidationError { empty }

class TimeWithEmployerInput extends FormzInput<String, TimeWithEmployerValidationError> {
  const TimeWithEmployerInput.pure() : super.pure('');
  const TimeWithEmployerInput.dirty([super.value = '']) : super.dirty();

  @override
  TimeWithEmployerValidationError? validator(String value) {
    return value.isEmpty ? TimeWithEmployerValidationError.empty : null;
  }
}