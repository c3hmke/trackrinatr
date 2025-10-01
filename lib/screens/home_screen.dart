import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/widgets/start_workout_button.dart';
import 'package:trackrinatr/widgets/workout_list.dart';
import 'package:trackrinatr/widgets/gradient_background.dart';
import 'package:trackrinatr/repositories/exercise_repository.dart';
import 'package:trackrinatr/repositories/workout_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Workout>> _workouts;
  late final WorkoutRepository workoutRepository;
  late final ExerciseRepository exerciseRepository;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    workoutRepository  = context.read<WorkoutRepository>();
    exerciseRepository = context.read<ExerciseRepository>();
    _loadWorkouts();
  }

  void _loadWorkouts() => _workouts = _fetchWorkouts();
  Future<List<Workout>> _fetchWorkouts() async {
    /// Get all the exercises, so they can be updated in UI
    final exercises = {
      for (var e in await exerciseRepository.getAll()) e.name: e
    };

    /// Get all the workouts to display the list on the home page
    final workouts = await workoutRepository.getAll(exercises);

    /// Order the workouts so those with the oldest last completed
    /// date go to the top. Most programs are cyclical so this will
    /// produce the order in which they should be completed. If a
    /// workout has never been completed, it's considered the oldest.
    workouts.sort((a, b) {
      final aDate = a.lastCompleted;
      final bDate = b.lastCompleted;

      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return -1;  // a comes first (never done)
      if (bDate == null) return 1;   // b comes first (never done)

      return aDate.compareTo(bDate); // oldest first
    });

    return workouts;
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
                final nextWorkout = workouts.first;

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
              final nextWorkout = snapshot.data!.first;
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
