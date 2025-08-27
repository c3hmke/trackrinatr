class Exercise {
  final String name;
  double currentWeight;
  List<bool> sets;

  Exercise({
    required this.name,
    required this.currentWeight,
    this.sets = const [false, false, false, false, false],
  });

  List<int> get warmupWeights => [
    (currentWeight * 0.4).round(),
    (currentWeight * 0.5).round(),
    (currentWeight * 0.6).round(),
  ];
}