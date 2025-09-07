class UtilizationRange {
  final String range;
  final bool isActive;

  const UtilizationRange({
    required this.range,
    required this.isActive,
  });

  UtilizationRange copyWith({String? range, bool? isActive}) {
    return UtilizationRange(
      range: range ?? this.range,
      isActive: isActive ?? this.isActive,
    );
  }

  static const defaultRanges = [
    UtilizationRange(range: '0-9%', isActive: true),
    UtilizationRange(range: '10-29%', isActive: false),
    UtilizationRange(range: '30-49%', isActive: false),
    UtilizationRange(range: '50-74%', isActive: false),
    UtilizationRange(range: '>75%', isActive: false),
  ];
  
  static List<UtilizationRange> getRangesForPercentage(double percentage) {
    return [
      UtilizationRange(range: '0-9%', isActive: percentage <= 9),
      UtilizationRange(range: '10-29%', isActive: percentage > 9 && percentage <= 29),
      UtilizationRange(range: '30-49%', isActive: percentage > 29 && percentage <= 49),
      UtilizationRange(range: '50-74%', isActive: percentage > 49 && percentage <= 74),
      UtilizationRange(range: '>75%', isActive: percentage > 74),
    ];
  }
}
