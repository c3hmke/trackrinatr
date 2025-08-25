import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/models/exercise.dart';
import 'package:trackrinatr/widgets/start_workout_button.dart';
import 'package:trackrinatr/widgets/workout_list.dart';
import 'package:trackrinatr/widgets/workout_list_item.dart';
import 'package:trackrinatr/widgets/gradient_background.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Workout> workouts = [
  Workout(
    id: 1,
    name: "Workout A",
    lastCompleted: DateTime(2024, 1, 15),
    exercises: [
      Exercise(name: "Barbell Squats", currentWeight: 70, warmups: [45, 55, 65]),
      Exercise(name: "Overhead Press", currentWeight: 135, warmups: [95, 115, 125]),
      Exercise(name: "Deadlift", currentWeight: 225, warmups: [135, 185, 205]),
    ],
  ),
  Workout(
    id: 2,
    name: "Workout B",
    lastCompleted: DateTime(2024, 1, 13),
    exercises: [
      Exercise(name: "Barbell Squats", currentWeight: 70, warmups: [45, 55, 65]),
      Exercise(name: "Bench Press", currentWeight: 185, warmups: [135, 155, 175]),
      Exercise(name: "Pendlay Row", currentWeight: 155, warmups: [95, 125, 145]),
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