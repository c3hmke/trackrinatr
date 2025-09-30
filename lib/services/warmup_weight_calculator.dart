/// Service used to calculate the warmup weights for a workout using plates.
/// currently simply defaults to 2.5kg (2 x 1.25kg plates)
class WarmupWeightCalculator {

  /// Round the weight given to the nearest value allowed by plate sizes
  static double roundToPlate(double value) => (value / 2.5).round() * 2.5;

  /// Calculate and return a list of warmup weights based on the working weight.
  static List<double> getWarmupWeights(double weight, [List<double>? percentages]){
    percentages ??= [0.4, 0.5, 0.6]; // assign some defaults if null passed

    return percentages.map((p) => roundToPlate(weight * p)).toList();
  }
}