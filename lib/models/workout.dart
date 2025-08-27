import 'package:trackrinatr/models/exercise.dart';

class Workout {
  final String name;
  DateTime lastCompleted;
  final List<Exercise> exercises;

  Workout({
    required this.name,
    required this.lastCompleted,
    required this.exercises,
  });
}