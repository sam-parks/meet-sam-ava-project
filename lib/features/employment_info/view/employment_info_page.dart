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
        scrolledUnderElevation: 0,
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
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(SpacingTokens.space4),
                    child: SingleChildScrollView(
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
                              padding: const EdgeInsets.only(
                                  bottom: SpacingTokens.space4),
                              child: Text(
                                'Please review and confirm the below employment details are up-to-date.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
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
                            displayWidget: SizedBox(
                              width: double.infinity,
                              child: Text(
                                state.address.value.isEmpty
                                    ? 'Not set'
                                    : _formatAddress(state.address.value),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: state.address.value.isEmpty
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant
                                          : null,
                                      height: 1.4,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: SpacingTokens.space4),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time with employer',
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
                                    state.timeWithEmployer.value.isEmpty
                                        ? 'Not set'
                                        : state.timeWithEmployer.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: state.timeWithEmployer.value
                                                  .isEmpty
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant
                                              : null,
                                        ),
                                  ),
                                ),
                                secondChild: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _extractYears(
                                            state.timeWithEmployer.value),
                                        decoration: const InputDecoration(
                                          hintText: 'Years',
                                        ),
                                        items: List.generate(10, (index) {
                                          return DropdownMenuItem(
                                            value: '$index',
                                            child: Text(
                                                '$index ${index == 1 ? 'year' : 'years'}'),
                                          );
                                        }),
                                        onChanged: (years) {
                                          final months = _extractMonths(
                                              state.timeWithEmployer.value);
                                          _updateTimeWithEmployer(
                                              ref, years ?? '0', months);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: SpacingTokens.space3),
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _extractMonths(
                                            state.timeWithEmployer.value),
                                        decoration: const InputDecoration(
                                          hintText: 'Months',
                                        ),
                                        items: List.generate(12, (index) {
                                          return DropdownMenuItem(
                                            value: '$index',
                                            child: Text(
                                                '$index ${index == 1 ? 'month' : 'months'}'),
                                          );
                                        }),
                                        onChanged: (months) {
                                          final years = _extractYears(
                                              state.timeWithEmployer.value);
                                          _updateTimeWithEmployer(
                                              ref, years, months ?? '0');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: SpacingTokens.space4),

                          AnimatedFieldWidget(
                            label: 'My next payday is',
                            value: state.nextPayday.value,
                            isEditMode: state.isEditMode,
                            editWidget: TextFormField(
                              controller: TextEditingController(
                                text: state.nextPayday.value,
                              ),
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
                                hintText: 'Select a date',
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: SpacingTokens
                                  .space4), // Direct deposit section with AnimatedCrossFade
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
                          // Add extra padding at bottom for floating buttons
                          const SizedBox(height: SpacingTokens.space28),
                        ],
                      ),
                    ),
                  ),
                  // Floating action buttons positioned at bottom
                  Positioned(
                    bottom: SpacingTokens.space4,
                    left: SpacingTokens.space4,
                    right: SpacingTokens.space4,
                    child: AnimatedCrossFade(
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
                                      .read(employmentInfoViewModelProvider
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
                                          .read(employmentInfoViewModelProvider
                                              .notifier)
                                          .submit();
                                      if (success && context.mounted) {
                                        // Navigate back to home first
                                        await context.router
                                            .navigatePath('/')
                                            .then((route) async => {
                                                  // Show feedback bottom sheet after a short delay
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 300),
                                                      () {
                                                    if (context.mounted) {
                                                      ref
                                                          .read(
                                                              feedbackViewModelProvider
                                                                  .notifier)
                                                          .show();
                                                      FeedbackBottomSheet.show(
                                                          context);
                                                    }
                                                  })
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
                                      .read(employmentInfoViewModelProvider
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
                                          FormzSubmissionStatus.inProgress ||
                                      !state.isValid
                                  ? null
                                  : () async {
                                      final success = await ref
                                          .read(employmentInfoViewModelProvider
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
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .inverseSurface,
                                            behavior: SnackBarBehavior.floating,
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
      final monthName = _getMonthName(date.month);
      final dayWithSuffix = _getDayWithSuffix(date.day);
      final dayOfWeek = _getDayOfWeek(date.weekday);
      viewModel.onNextPaydayChanged(
          '$monthName $dayWithSuffix, ${date.year} ($dayOfWeek)');
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

  String _formatAddress(String address) {
    // Find the first comma and add a newline after it
    final firstCommaIndex = address.indexOf(',');
    if (firstCommaIndex != -1 && firstCommaIndex < address.length - 1) {
      // Add newline after the first comma
      return '${address.substring(0, firstCommaIndex + 1)}\n${address.substring(firstCommaIndex + 1).trim()}';
    }
    return address;
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  String _getDayWithSuffix(int day) {
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }
    return '$day$suffix';
  }

  String _extractYears(String timeWithEmployer) {
    if (timeWithEmployer.isEmpty) return '0';
    // Try to extract years from strings like "2 years 3 months" or "2 years"
    final yearsMatch = RegExp(r'(\d+)\s*year').firstMatch(timeWithEmployer);
    return yearsMatch?.group(1) ?? '0';
  }

  String _extractMonths(String timeWithEmployer) {
    if (timeWithEmployer.isEmpty) return '0';
    // Try to extract months from strings like "2 years 3 months" or "3 months"
    final monthsMatch = RegExp(r'(\d+)\s*month').firstMatch(timeWithEmployer);
    return monthsMatch?.group(1) ?? '0';
  }

  void _updateTimeWithEmployer(WidgetRef ref, String years, String months) {
    final yearsInt = int.tryParse(years) ?? 0;
    final monthsInt = int.tryParse(months) ?? 0;

    String timeText = '';
    if (yearsInt > 0) {
      timeText = '$yearsInt ${yearsInt == 1 ? 'year' : 'years'}';
    }
    if (monthsInt > 0) {
      if (timeText.isNotEmpty) timeText += ' ';
      timeText += '$monthsInt ${monthsInt == 1 ? 'month' : 'months'}';
    }
    if (timeText.isEmpty) {
      timeText = '0 years';
    }

    ref
        .read(employmentInfoViewModelProvider.notifier)
        .onTimeWithEmployerChanged(timeText);
  }
}
