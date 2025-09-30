import 'package:trackrinatr/models/exercise.dart';

/// Workouts are containers for Exercises, where multiple workouts
/// may contain the same exercise. They hold some extra information
/// relevant to tracking and managing which set of Exercises should
/// be performed next.
class Workout {
  final String name;
  DateTime? lastCompleted;
  final List<Exercise> exercises;

  Workout({
    required this.name,
    required this.lastCompleted,
    required this.exercises,
  });
}