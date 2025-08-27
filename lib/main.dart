import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/screens/home_screen.dart';

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

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'trackrinatr',
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}
