import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trackrinatr/app/app.dart';
import 'package:trackrinatr/app/seeders/workout_seeder.dart';
import 'package:trackrinatr/repositories/exercise_repository.dart';
import 'package:trackrinatr/repositories/workout_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize repositories & register in Hive
  await Hive.initFlutter();

  final exerciseRepository = await ExerciseRepository.init();
  final workoutRepository  = await WorkoutRepository.init();

  /// Seed data on first initialization
  await workoutRepository.seedIfEmpty(exerciseRepository);

  /// Run the application
  runApp(
    MultiProvider(
      providers: [
        Provider<WorkoutRepository>.value(value: workoutRepository),
        Provider<ExerciseRepository>.value(value: exerciseRepository),
      ],
      child: const App()
    )
  );
}