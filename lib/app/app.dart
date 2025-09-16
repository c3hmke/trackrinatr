import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/screens/home_screen.dart';
import 'package:trackrinatr/repositories/exercise_repository.dart';
import 'package:trackrinatr/repositories/workout_repository.dart';

class App extends StatelessWidget {
  final ExerciseRepository exerciseRepository;
  final WorkoutRepository workoutRepository;

  const App({
    super.key,
    required this.exerciseRepository,
    required this.workoutRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'trackrinatr',
      theme: AppTheme.theme,
      home: HomeScreen(
        workoutRepository: workoutRepository,
        exerciseRepository: exerciseRepository,
      ),
    );
  }
}
