import 'dart:math';

class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  final _random = Random();
  late final Map<String, dynamic> _currentScenario;
  bool _initialized = false;

  void _initializeScenario() {
    if (_initialized) return;
    
    final scenarios = [
      // Excellent (0-9% utilization)
      {
        'totalBalance': 5000.0,
        'totalLimit': 100000.0,
        'utilization': 5.0,
        'rating': 'Excellent',
        'impact': 'low',
      },
      {
        'totalBalance': 8390.0,
        'totalLimit': 200900.0,
        'utilization': 4.2,
        'rating': 'Excellent',
        'impact': 'low',
      },
      
      // Very Good (10-29% utilization)
      {
        'totalBalance': 15000.0,
        'totalLimit': 75000.0,
        'utilization': 20.0,
        'rating': 'Very Good',
        'impact': 'low',
      },
      {
        'totalBalance': 25000.0,
        'totalLimit': 100000.0,
        'utilization': 25.0,
        'rating': 'Very Good',
        'impact': 'low',
      },
      
      // Good (30-49% utilization)
      {
        'totalBalance': 40000.0,
        'totalLimit': 100000.0,
        'utilization': 40.0,
        'rating': 'Good',
        'impact': 'medium',
      },
      {
        'totalBalance': 35000.0,
        'totalLimit': 80000.0,
        'utilization': 43.8,
        'rating': 'Good',
        'impact': 'medium',
      },
      
      // Fair (50-74% utilization)
      {
        'totalBalance': 60000.0,
        'totalLimit': 100000.0,
        'utilization': 60.0,
        'rating': 'Fair',
        'impact': 'high',
      },
      {
        'totalBalance': 70000.0,
        'totalLimit': 100000.0,
        'utilization': 70.0,
        'rating': 'Fair',
        'impact': 'high',
      },
      
      // Poor (75%+ utilization)
      {
        'totalBalance': 80000.0,
        'totalLimit': 100000.0,
        'utilization': 80.0,
        'rating': 'Poor',
        'impact': 'high',
      },
      {
        'totalBalance': 95000.0,
        'totalLimit': 100000.0,
        'utilization': 95.0,
        'rating': 'Poor',
        'impact': 'high',
      },
    ];
    
    _currentScenario = scenarios[_random.nextInt(scenarios.length)];
    _initialized = true;
  }

  Map<String, dynamic> getCurrentScenario() {
    _initializeScenario();
    return _currentScenario;
  }

  // Reset for testing different scenarios
  void reset() {
    _initialized = false;
  }
}