import 'package:trackrinatr/models/exercise.dart';

/// The ExerciseLog class is used to keep a log of completed exercises.
/// It's serves as an append-only progress history across workouts.
class ExerciseLog {
  final String   name;
  final double   weight;
  final int      sets;
  final int      completedSets;
  final DateTime completedDate;

  ExerciseLog({
    required this.name,
    required this.weight,
    required this.sets,
    required this.completedSets,
    required this.completedDate,
  });

  /// Create a new log using an Exercise as base
  ExerciseLog fromExercise(Exercise exercise, DateTime logDate) {
    return ExerciseLog(
      name:          exercise.name,
      weight:        exercise.weight,
      sets:          exercise.sets,
      completedSets: exercise.completedSets,
      completedDate: logDate,
    );
  }
}