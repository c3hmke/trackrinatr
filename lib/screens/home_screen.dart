import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/models/exercise.dart';
import 'package:trackrinatr/widgets/start_workout_button.dart';
import 'package:trackrinatr/widgets/workout_list.dart';
import 'package:trackrinatr/widgets/gradient_background.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Workout> workouts = [
  Workout(
    name: "Workout A",
    lastCompleted: DateTime(2024, 1, 15),
    exercises: [
      Exercise(name: "Barbell Squats", weight: 70, sets: 5),
      Exercise(name: "Overhead Press", weight: 135, sets: 5),
      Exercise(name: "Deadlift", weight: 225, sets: 1),
    ],
  ),
  Workout(
    name: "Workout B",
    lastCompleted: DateTime(2024, 1, 13),
    exercises: [
      Exercise(name: "Barbell Squats", weight: 70, sets: 5),
      Exercise(name: "Bench Press", weight: 185, sets: 5),
      Exercise(name: "Pendlay Row", weight: 155, sets: 5),
    ],
  )
];

class _HomeScreenState extends State<HomeScreen> {
  Workout getNextWorkout() {
    workouts.sort((a, b) => b.lastCompleted.compareTo(a.lastCompleted));
    return workouts.first;
  }

  @override
  Widget build(BuildContext context) {
    final nextWorkout = getNextWorkout();

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 18),
                const Center(
                  child: Column(
                    children: [
                      Text("Trackrinatr", style: AppText.heading),
                      Text("Paper++ workout tracker", style: AppText.caption),
                      SizedBox(height: 18),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const Text("Stronglifts 5x5", style: AppText.subheading),
                const SizedBox(height: 12),

                Expanded(
                  child: WorkoutList(
                      workouts: workouts,
                      onUpdated: () => setState(() {})
                  )
                )

              ],
            ),
          ),
        ),

        floatingActionButton: StartWorkoutButton(
            workout: nextWorkout, onFinished: () => setState(() {})
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      )
    );
  }
}