import 'package:flutter/material.dart';
import 'package:trackrinatr/screens/exercise_screen.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/models/exercise.dart';
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
      Exercise(name: "Barbell Rows", currentWeight: 155, warmups: [95, 125, 145]),
    ],
  )
];

class _HomeScreenState extends State<HomeScreen> {
  Workout getNextWorkout() {
    workouts.sort((a, b) => b.lastCompleted.compareTo(a.lastCompleted));
    return workouts.first;
  }

  String formatDate(DateTime date) {
    final diffDays = DateTime.now().difference(date).inDays;
    if (diffDays == 0) return "Today";
    if (diffDays == 1) return "Yesterday";
    return "$diffDays days ago";
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
                  const SizedBox(height: 16),
                  const Center(
                    child: Column(
                      children: [
                        Text("5x5 Trackrinatr",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        SizedBox(height: 4),
                        Text("Choose your workout for today",
                            style: TextStyle(color: Colors.blueAccent)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExerciseScreen(workout: nextWorkout),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("🚀 ", style: TextStyle(fontSize: 22)),
                        Column(
                          children: [
                            const Text("Start Next Workout",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(nextWorkout.name,
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text("All Workouts",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: workouts.length,
                      itemBuilder: (context, index) {
                        final workout = workouts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ExerciseScreen(workout: workout),
                              ),
                            ).then((_) => setState(() {}));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(workout.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text("Last: ${formatDate(workout.lastCompleted)}",
                                    style: const TextStyle(color: Colors.blueAccent)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      ),
    )
    );
  }
}