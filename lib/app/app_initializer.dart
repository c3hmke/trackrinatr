import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/models/exercise.dart';
import 'package:trackrinatr/repositories/workout_repository.dart';
import 'package:trackrinatr/repositories/exercise_repository.dart';

/// Initialize services required by this application on launch
class AppInitializer {
  final WorkoutRepository workoutRepository;
  final ExerciseRepository exerciseRepository;

  AppInitializer({
    required this.workoutRepository,
    required this.exerciseRepository,
  });

  /// Get data for display when app initializes
  Future<void> initializeData() async {
    // Get the workouts and their corresponding exercises
    final workouts = await workoutRepository.getAll({
        for (var exercise in await exerciseRepository.getAll())
          exercise.name: exercise
    });

    /// If no workouts are found we want to create some initial data
    /// for display purposes; TODO: remove with ability to create workouts
    if (workouts.isEmpty) await createDemoData();
  }

  Future<void> createDemoData() async {
    // Shared exercises; start at naked bar weight
    final squat = Exercise(name: "Squat", weight: 20, sets: 5);
    final bench = Exercise(name: "Bench Press", weight: 20, sets: 5);
    final deadlift = Exercise(name: "Deadlift", weight: 20, sets: 1);
    final ohp = Exercise(name: "Overhead Press", weight: 20, sets: 5);
    final row = Exercise(name: "Pendlay Row", weight: 20, sets: 5);

    // Save exercises
    await exerciseRepository.save(squat);
    await exerciseRepository.save(bench);
    await exerciseRepository.save(deadlift);
    await exerciseRepository.save(ohp);
    await exerciseRepository.save(row);

    // Workouts (using exercise references by name)
    await workoutRepository.save(Workout(
      name: "Workout A",
      exercises: [squat, bench, row],
      lastCompleted: null,
    ));
    await workoutRepository.save(Workout(
      name: "Workout B",
      exercises: [squat, ohp, deadlift],
      lastCompleted: null,
    ));
  }
}