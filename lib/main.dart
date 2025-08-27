import 'package:flutter/material.dart';
import 'package:trackrinatr/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();

  // TODO: write these adapters
  // Hive.registerAdapter(ExerciseAdapter());
  // Hive.registerAdapter(WorkoutAdapter());
  //
  // await Hive.openBox<Exercise>('exercises');
  // await Hive.openBox<Workout>('workouts');

  runApp(const App());
}
