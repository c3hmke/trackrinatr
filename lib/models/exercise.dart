import 'package:trackrinatr/services/warmup_weight_calculator.dart';

class Exercise {
  final String name;
  double weight;
  final int sets;
  int completedSets;


  Exercise({
    required this.name,
    required this.weight,
    required this.sets,
    this.completedSets = 0,
  });

  /// Calculate and retrieve the warmup weights.
  /// This is currently based on the 5x5 program where the warmup sets are
  /// performed at 40, 50, 60% of the working weight. This is something
  /// that may be configurable in future.
  List<double> get warmupWeights => WarmupWeightCalculator.getWarmupWeights(weight);

  /// Increment the number of completed sets. If it exceeds the total sets
  /// wrap around to 0. This is done to make the tapping area easier to
  /// interact with while busy, but still offer a way to loop around if
  /// a mistake is made.
  void completeNextSet() =>
    completedSets = completedSets < sets ? completedSets + 1 : 0;

  /// This provides an alternative method for decreasing the number of sets.
  void undoSet() => completedSets -= 1;

  /// Determine if a 'specific' set has already been completed based on
  /// the total number of sets and current set number.
  bool isSetCompleted(int set) => set < completedSets;
}