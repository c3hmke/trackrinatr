import 'package:flutter/material.dart';
import 'package:trackrinatr/screens/home_screen.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/models/exercise.dart';

void main() {
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const LinearGradient(
          colors: [Colors.blue, Colors.purple, Colors.indigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, 200, 200)) == null
            ? Colors.black
            : ThemeData.dark().scaffoldBackgroundColor,
      ),
      home: const HomeScreen(),
    );
  }
}
