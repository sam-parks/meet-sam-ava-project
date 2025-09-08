import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:meet_sam_ava/core/theme/tokens/color_tokens.dart';
import 'package:meet_sam_ava/core/theme/tokens/typography_tokens.dart';
import 'package:meet_sam_ava/features/employment_info/vm/employment_info_view_model.dart';
import 'package:meet_sam_ava/features/employment_info/view/widgets/animated_field_widget.dart';
import 'package:meet_sam_ava/features/employment_info/view/widgets/animated_dropdown_widget.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/features/feedback/vm/feedback_view_model.dart';
import 'package:meet_sam_ava/features/feedback/view/widgets/feedback_bottom_sheet.dart';

@RoutePage()
class EmploymentInfoPage extends ConsumerWidget {
  const EmploymentInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(employmentInfoViewModelProvider);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: ColorTokens.background,
        elevation: 0,
        toolbarHeight: SizeTokens.appBarHeight - SpacingTokens.space4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SafeArea(
        child: asyncState.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(SpacingTokens.space4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: SpacingTokens.space4),
                  Text(
                    'Failed to load employment information',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: SpacingTokens.space2),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: SpacingTokens.space4),
                  ElevatedButton(
                    onPressed: () =>
                        ref.invalidate(employmentInfoViewModelProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          data: (state) {
            final directDeposit = state.isDirectDeposit;

            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
              padding: const EdgeInsets.all(SpacingTokens.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.isEditMode
                        ? 'Edit employment information'
                        : 'Confirm your employment',
                    style: TypographyTokens.headlineLargeCondensed,
                  ),
                  const SizedBox(
                    height: SpacingTokens.space1,
                  ),
                  if (!state.isEditMode)
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: SpacingTokens.space4),
                      child: Text(
                        'Please review and confirm the below employment details are up-to-date.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              height: 1.6,
                            ),
                      ),
                    ),
                  const SizedBox(
                    height: SpacingTokens.space7,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AnimatedDropdownWidget(
                            label: 'Employment type',
                            value: state.employmentType.value,
                            isEditMode: state.isEditMode,
                            items: const [
                              DropdownMenuItem(
                                  value: 'Full-time', child: Text('Full-time')),
                              DropdownMenuItem(
                                  value: 'Part-time', child: Text('Part-time')),
                              DropdownMenuItem(
                                  value: 'Contract', child: Text('Contract')),
                            ],
                            onChanged: (value) => ref
                                .read(employmentInfoViewModelProvider.notifier)
                                .onEmploymentTypeChanged(value ?? ''),
                          ),
                          const SizedBox(height: SpacingTokens.space4),

                          AnimatedFieldWidget(
                            label: 'Employer',
                            value: state.employer.value,
                            isEditMode: state.isEditMode,
                            editWidget: TextFormField(
                              initialValue: state.employer.value,
                              onChanged: ref
                                  .read(
                                      employmentInfoViewModelProvider.notifier)
                                  .onEmployerChanged,
                              decoration: InputDecoration(
                                errorText: state.employer.displayError != null
                                    ? 'Please enter your employer'
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: SpacingTokens.space4),

                          AnimatedFieldWidget(
                            label: 'Job title',
                            value: state.jobTitle.value,
                            isEditMode: state.isEditMode,
                            editWidget: TextFormField(
                              initialValue: state.jobTitle.value,
                              onChanged: ref
                                  .read(
                                      employmentInfoViewModelProvider.notifier)
                                  .onJobTitleChanged,
                              decoration: InputDecoration(
                                errorText: state.jobTitle.displayError != null
                                    ? 'Please enter your job title'
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: SpacingTokens.space4),

                          AnimatedFieldWidget(
                            label: 'Gross annual income',
                            value: state.grossAnnualIncome.value,
                            isEditMode: state.isEditMode,
                            editWidget: TextFormField(
                              initialValue: state.grossAnnualIncome.value,
                              onChanged: ref
                                  .read(
                                      employmentInfoViewModelProvider.notifier)
                                  .onIncomeChanged,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                errorText:
                                    state.grossAnnualIncome.displayError != null
                                        ? 'Please enter a valid income amount'
                                        : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: SpacingTokens.space4),

                          AnimatedDropdownWidget(
                            label: 'Pay frequency',
                            value: state.payFrequency.value,
                            isEditMode: state.isEditMode,
                            items: const [
                              DropdownMenuItem(
                                  value: 'Bi-weekly', child: Text('Bi-weekly')),
                              DropdownMenuItem(
                                  value: 'Weekly', child: Text('Weekly')),
                              DropdownMenuItem(
                                  value: 'Monthly', child: Text('Monthly')),
                              DropdownMenuItem(
                                  value: 'Bi-monthly',
                                  child: Text('Bi-monthly')),
                            ],
                            onChanged: (value) => ref
                                .read(employmentInfoViewModelProvider.notifier)
                                .onPayFrequencyChanged(value ?? ''),
                          ),
                          const SizedBox(height: SpacingTokens.space4),
                          AnimatedFieldWidget(
                            label: 'Employer address',
                            value: state.address.value,
                            isEditMode: state.isEditMode,
                            editWidget: TextFormField(
                              initialValue: state.address.value,
                              onChanged: ref
                                  .read(
                                      employmentInfoViewModelProvider.notifier)
                                  .onAddressChanged,
                              maxLines: 3,
                              decoration: InputDecoration(
                                errorText: state.address.displayError != null
                                    ? 'Please enter a valid address'
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: SpacingTokens.space4),

                          AnimatedDropdownWidget(
                            label: 'Time with employer',
                            value: state.timeWithEmployer.value,
                            isEditMode: state.isEditMode,
                            items: const [
                              DropdownMenuItem(
                                  value: '1 year', child: Text('1 year')),
                              DropdownMenuItem(
                                  value: '2 years', child: Text('2 years')),
                              DropdownMenuItem(
                                  value: '3 years', child: Text('3 years')),
                              DropdownMenuItem(
                                  value: '4+ years', child: Text('4+ years')),
                            ],
                            onChanged: (value) => ref
                                .read(employmentInfoViewModelProvider.notifier)
                                .onTimeWithEmployerChanged(value ?? ''),
                          ),

                          const SizedBox(height: SpacingTokens.space4),

                          AnimatedFieldWidget(
                            label: 'My next payday is',
                            value: state.nextPayday.value,
                            isEditMode: state.isEditMode,
                            editWidget: TextFormField(
                              initialValue: state.nextPayday.value,
                              onChanged: ref
                                  .read(
                                      employmentInfoViewModelProvider.notifier)
                                  .onNextPaydayChanged,
                              readOnly: true,
                              onTap: () => _selectDate(
                                  context,
                                  ref.read(employmentInfoViewModelProvider
                                      .notifier)),
                              decoration: InputDecoration(
                                errorText: state.nextPayday.displayError != null
                                    ? 'Please enter your next payday'
                                    : null,
                                suffixIcon: const Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                          const SizedBox(height: SpacingTokens.space4),

                          // Direct deposit section with AnimatedCrossFade
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Is your pay a direct deposit?',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                              const SizedBox(height: SpacingTokens.space2),
                              AnimatedCrossFade(
                                duration: const Duration(milliseconds: 300),
                                crossFadeState: state.isEditMode
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                firstChild: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                      directDeposit == null
                                          ? 'Not set'
                                          : directDeposit
                                              ? 'Yes'
                                              : 'No',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                                secondChild: Row(
                                  children: [
                                    Radio<bool>(
                                      value: true,
                                      groupValue: directDeposit,
                                      onChanged: (value) => ref
                                          .read(employmentInfoViewModelProvider
                                              .notifier)
                                          .onDirectDepositChanged(
                                              value ?? false),
                                    ),
                                    const Text('Yes'),
                                    const SizedBox(width: SpacingTokens.space4),
                                    Radio<bool>(
                                      value: false,
                                      groupValue: state.isDirectDeposit,
                                      onChanged: (value) => ref
                                          .read(employmentInfoViewModelProvider
                                              .notifier)
                                          .onDirectDepositChanged(
                                              value ?? false),
                                    ),
                                    const Text('No'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SpacingTokens.space4),

                          AnimatedCrossFade(
                            duration: const Duration(milliseconds: 300),
                            crossFadeState: state.isEditMode
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            firstChild: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: state.status ==
                                            FormzSubmissionStatus.inProgress
                                        ? null
                                        : () => ref
                                            .read(
                                                employmentInfoViewModelProvider
                                                    .notifier)
                                            .enterEditMode(),
                                    child: const Text('Edit'),
                                  ),
                                ),
                                const SizedBox(height: SpacingTokens.space3),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: state.status ==
                                            FormzSubmissionStatus.inProgress
                                        ? null
                                        : () async {
                                            final success = await ref
                                                .read(
                                                    employmentInfoViewModelProvider
                                                        .notifier)
                                                .submit();
                                            if (success && context.mounted) {
                                              // Navigate back to home first
                                              context.router.pop();

                                              // Show feedback bottom sheet after a short delay
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 300), () {
                                                if (context.mounted) {
                                                  ref
                                                      .read(
                                                          feedbackViewModelProvider
                                                              .notifier)
                                                      .show();
                                                  FeedbackBottomSheet.show(
                                                      context);
                                                }
                                              });
                                            }
                                          },
                                    child: state.status ==
                                            FormzSubmissionStatus.inProgress
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          )
                                        : const Text('Confirm'),
                                  ),
                                ),
                              ],
                            ),
                            secondChild: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: state.status ==
                                            FormzSubmissionStatus.inProgress
                                        ? null
                                        : () => ref
                                            .read(
                                                employmentInfoViewModelProvider
                                                    .notifier)
                                            .cancel(),
                                    child: const Text('Cancel'),
                                  ),
                                ),
                                const SizedBox(height: SpacingTokens.space3),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: state.status ==
                                                FormzSubmissionStatus
                                                    .inProgress ||
                                            !state.isValid
                                        ? null
                                        : () async {
                                            final success = await ref
                                                .read(
                                                    employmentInfoViewModelProvider
                                                        .notifier)
                                                .submit();
                                            if (success && context.mounted) {
                                              ref
                                                  .read(
                                                      employmentInfoViewModelProvider
                                                          .notifier)
                                                  .exitEditMode();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: const Text(
                                                      'Employment information saved'),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .inverseSurface,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                          },
                                    child: state.status ==
                                            FormzSubmissionStatus.inProgress
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          )
                                        : const Text(
                                            'Continue',
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, EmploymentInfoViewModel viewModel) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      viewModel.onNextPaydayChanged(
          'Sept ${date.day}, ${date.year} (${_getDayOfWeek(date.weekday)})');
    }
  }

  String _getDayOfWeek(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[weekday - 1];
  }
}
