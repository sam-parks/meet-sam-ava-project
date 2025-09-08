class EmploymentData {
  final String employmentType;
  final String employer;
  final String jobTitle;
  final String grossAnnualIncome;
  final String payFrequency;
  final String address;
  final String nextPayday;
  final bool? isDirectDeposit;
  final String timeWithEmployer;

  const EmploymentData({
    required this.employmentType,
    required this.employer,
    required this.jobTitle,
    required this.grossAnnualIncome,
    required this.payFrequency,
    required this.address,
    required this.nextPayday,
    this.isDirectDeposit,
    required this.timeWithEmployer,
  });

  factory EmploymentData.empty() => const EmploymentData(
        employmentType: '',
        employer: '',
        jobTitle: '',
        grossAnnualIncome: '',
        payFrequency: '',
        address: '',
        nextPayday: '',
        isDirectDeposit: null,
        timeWithEmployer: '',
      );

  EmploymentData copyWith({
    String? employmentType,
    String? employer,
    String? jobTitle,
    String? grossAnnualIncome,
    String? payFrequency,
    String? address,
    String? nextPayday,
    bool? isDirectDeposit,
    String? timeWithEmployer,
  }) {
    return EmploymentData(
      employmentType: employmentType ?? this.employmentType,
      employer: employer ?? this.employer,
      jobTitle: jobTitle ?? this.jobTitle,
      grossAnnualIncome: grossAnnualIncome ?? this.grossAnnualIncome,
      payFrequency: payFrequency ?? this.payFrequency,
      address: address ?? this.address,
      nextPayday: nextPayday ?? this.nextPayday,
      isDirectDeposit: isDirectDeposit ?? this.isDirectDeposit,
      timeWithEmployer: timeWithEmployer ?? this.timeWithEmployer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employmentType': employmentType,
      'employer': employer,
      'jobTitle': jobTitle,
      'grossAnnualIncome': grossAnnualIncome,
      'payFrequency': payFrequency,
      'address': address,
      'nextPayday': nextPayday,
      'isDirectDeposit': isDirectDeposit,
      'timeWithEmployer': timeWithEmployer,
    };
  }

  factory EmploymentData.fromJson(Map<String, dynamic> json) {
    return EmploymentData(
      employmentType: json['employmentType'] as String? ?? '',
      employer: json['employer'] as String? ?? '',
      jobTitle: json['jobTitle'] as String? ?? '',
      grossAnnualIncome: json['grossAnnualIncome'] as String? ?? '',
      payFrequency: json['payFrequency'] as String? ?? '',
      address: json['address'] as String? ?? '',
      nextPayday: json['nextPayday'] as String? ?? '',
      isDirectDeposit: json['isDirectDeposit'] as bool?,
      timeWithEmployer: json['timeWithEmployer'] as String? ?? '',
    );
  }
}
