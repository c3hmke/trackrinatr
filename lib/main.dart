import 'package:flutter/material.dart';

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

class Workout {
  final int id;
  final String name;
  DateTime lastCompleted;
  final List<Exercise> exercises;

  Workout({
    required this.id,
    required this.name,
    required this.lastCompleted,
    required this.exercises,
  });
}

class Exercise {
  final String name;
  final int currentWeight;
  final List<int> warmups;
  List<bool> sets;

  Exercise({
    required this.name,
    required this.currentWeight,
    required this.warmups,
    this.sets = const [false, false, false, false, false],
  });
}

List<Workout> workouts = [
  Workout(
    id: 1,
    name: "Push Day",
    lastCompleted: DateTime(2024, 1, 15),
    exercises: [
      Exercise(name: "Bench Press", currentWeight: 185, warmups: [135, 155, 175]),
      Exercise(name: "Overhead Press", currentWeight: 135, warmups: [95, 115, 125]),
      Exercise(name: "Incline Dumbbell Press", currentWeight: 70, warmups: [45, 55, 65]),
      Exercise(name: "Tricep Dips", currentWeight: 25, warmups: [0, 10, 20]),
    ],
  ),
  Workout(
    id: 2,
    name: "Pull Day",
    lastCompleted: DateTime(2024, 1, 13),
    exercises: [
      Exercise(name: "Deadlift", currentWeight: 225, warmups: [135, 185, 205]),
      Exercise(name: "Pull-ups", currentWeight: 25, warmups: [0, 10, 20]),
      Exercise(name: "Barbell Rows", currentWeight: 155, warmups: [95, 125, 145]),
      Exercise(name: "Bicep Curls", currentWeight: 35, warmups: [20, 25, 30]),
    ],
  ),
  Workout(
    id: 3,
    name: "Leg Day",
    lastCompleted: DateTime(2024, 1, 11),
    exercises: [
      Exercise(name: "Squats", currentWeight: 205, warmups: [135, 165, 185]),
      Exercise(name: "Romanian Deadlift", currentWeight: 185, warmups: [95, 135, 165]),
      Exercise(name: "Leg Press", currentWeight: 315, warmups: [225, 275, 295]),
      Exercise(name: "Calf Raises", currentWeight: 185, warmups: [135, 155, 175]),
    ],
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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

    return Scaffold(
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
    );
  }
}

class ExerciseScreen extends StatefulWidget {
  final Workout workout;
  const ExerciseScreen({super.key, required this.workout});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.workout.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...widget.workout.exercises.asMap().entries.map((entry) {
            final index = entry.key;
            final exercise = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise.name,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 12),
                  Text("Working Weight",
                      style: TextStyle(color: Colors.blue[200], fontSize: 12)),
                  Text("${exercise.currentWeight} lbs",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 12),
                  Text("Warmup Weights",
                      style: TextStyle(color: Colors.blue[200], fontSize: 12)),
                  Wrap(
                    spacing: 8,
                    children: exercise.warmups
                        .map((w) => Chip(
                      label: Text("$w lbs",
                          style: const TextStyle(color: Colors.white)),
                      backgroundColor: Colors.blue.withOpacity(0.3),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Text("Sets Completed",
                      style: TextStyle(color: Colors.blue[200], fontSize: 12)),
                  Row(
                    children: List.generate(5, (setIndex) {
                      final completed = exercise.sets[setIndex];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            exercise.sets[setIndex] = !completed;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8, top: 8),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color:
                                completed ? Colors.green : Colors.blueAccent,
                                width: 2),
                            color: completed ? Colors.green : Colors.transparent,
                          ),
                          child: Center(
                            child: completed
                                ? const Icon(Icons.check,
                                color: Colors.white, size: 18)
                                : Text("${setIndex + 1}",
                                style: const TextStyle(
                                    color: Colors.blueAccent)),
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            );
          }),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              minimumSize: const Size.fromHeight(60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              setState(() {
                widget.workout.lastCompleted = DateTime.now();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("🎉 Completed ${widget.workout.name}!"),
              ));
            },
            icon: const Icon(Icons.check, size: 22),
            label: const Text("Complete Workout",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
