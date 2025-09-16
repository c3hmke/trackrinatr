import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/widgets/start_workout_button.dart';
import 'package:trackrinatr/widgets/workout_list.dart';
import 'package:trackrinatr/widgets/gradient_background.dart';
import 'package:trackrinatr/repositories/exercise_repository.dart';
import 'package:trackrinatr/repositories/workout_repository.dart';

class HomeScreen extends StatefulWidget {
  final WorkoutRepository workoutRepository;
  final ExerciseRepository exerciseRepository;

  const HomeScreen({
    super.key,
    required this.workoutRepository,
    required this.exerciseRepository,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Workout>> _workouts;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  void _loadWorkouts() {
    _workouts = _fetchWorkouts();
  }

  Future<List<Workout>> _fetchWorkouts() async {
    final exercises = {
      for (var e in await widget.exerciseRepository.getAll()) e.name: e
    };
    return widget.workoutRepository.getAll(exercises);
  }

  Workout _getNextWorkout(List<Workout> workouts) {
    workouts.sort((a, b) => b.lastCompleted.compareTo(a.lastCompleted));
    return workouts.first;
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<List<Workout>>(
              future: _workouts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No workouts found"));
                }

                final workouts = snapshot.data!;
                final nextWorkout = _getNextWorkout(workouts);

                return Column(
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
                        onUpdated: () {
                          setState(() => _loadWorkouts());
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButton: FutureBuilder<List<Workout>>(
          future: _workouts,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final nextWorkout = _getNextWorkout(snapshot.data!);
              return StartWorkoutButton(
                workout: nextWorkout,
                onFinished: () => setState(() => _loadWorkouts()),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
