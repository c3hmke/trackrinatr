import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/models/exercise.dart';
import 'package:trackrinatr/repositories/workout_repository.dart';
import 'package:trackrinatr/repositories/exercise_repository.dart';
import 'package:trackrinatr/app/seeders/exercise_seeder.dart';

extension WorkoutSeeder on WorkoutRepository {
  /// Seed default workouts if none exist
  Future<void> seedIfEmpty(ExerciseRepository exerciseRepository) async {
    final workouts = await getAll({
      for (var e in await exerciseRepository.getAll()) e.name: e,
    });

    if (workouts.isNotEmpty) return;

    final exercises = await exerciseRepository.seedIfEmpty();

    /// Helper function to return an exercise by name from the exercises list
    Exercise find(String name) => exercises.firstWhere((e) => e.name == name);

    // Create default workouts
    await save(Workout(
      name: "Workout A",
      exercises: [find("Squat"), find("Bench Press"), find("Pendlay Row")],
      lastCompleted: null,
    ));

    await save(Workout(
      name: "Workout B",
      exercises: [find("Squat"), find("Overhead Press"), find("Deadlift")],
      lastCompleted: null,
    ));
  }
}
