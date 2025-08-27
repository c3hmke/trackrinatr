class Exercise {
  final String name;
  final int totalSets;
  int completedSets;
  double currentWeight;

  Exercise({
    required this.name,
    required this.currentWeight,
    required this.totalSets,
    this.completedSets = 0,
  });

  /// Calculate and retrieve the warmup weights.
  /// This is currently based on the 5x5 program where the warmup sets are
  /// performed at 40, 50, 60% of the working weight. This is something
  /// that may be configurable in future.
  List<int> get warmupWeights => [
    (currentWeight * 0.4).round(),
    (currentWeight * 0.5).round(),
    (currentWeight * 0.6).round(),
  ];

  /// Increment the number of completed sets. If it exceeds the total sets
  /// wrap around to 0. This is done to make the tapping area easier to
  /// interact with while busy, but still offer a way to loop around if
  /// a mistake is made.
  void completeNextSet() =>
    completedSets = completedSets < totalSets ? completedSets + 1 : 0;

  /// Determine if a 'specific' set has already been completed based on
  /// the total number of sets and current set number.
  bool isSetCompleted(int set) => set < completedSets;
}