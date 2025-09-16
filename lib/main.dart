import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackrinatr/app/app.dart';
import 'package:trackrinatr/app/app_initializer.dart';
import 'package:trackrinatr/repositories/exercise_repository.dart';
import 'package:trackrinatr/repositories/workout_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final exerciseRepo = await ExerciseRepository.init();
  final workoutRepo = await WorkoutRepository.init();

  final initializer = AppInitializer(
    workoutRepository: workoutRepo,
    exerciseRepository: exerciseRepo,
  );
  await initializer.initializeData();

  runApp(App(
    workoutRepository: workoutRepo,
    exerciseRepository: exerciseRepo,
  ));
}
