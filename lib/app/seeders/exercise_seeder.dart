import 'package:trackrinatr/models/exercise.dart';
import 'package:trackrinatr/repositories/exercise_repository.dart';

extension ExerciseSeeder on ExerciseRepository {
  /// Seed default exercises if they do not exist
  Future<List<Exercise>> seedIfEmpty() async {
    final existing = await getAll();
    if (existing.isNotEmpty) return existing;

    final squat = Exercise(name: "Squat", weight: 20, sets: 5);
    final bench = Exercise(name: "Bench Press", weight: 20, sets: 5);
    final deadlift = Exercise(name: "Deadlift", weight: 20, sets: 1);
    final ohp = Exercise(name: "Overhead Press", weight: 20, sets: 5);
    final row = Exercise(name: "Pendlay Row", weight: 20, sets: 5);

    final exercises = [squat, bench, deadlift, ohp, row];

    for (var exercise in exercises) {
      await save(exercise);
    }

    return exercises;
  }
}