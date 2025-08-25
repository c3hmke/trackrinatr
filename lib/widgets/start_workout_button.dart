import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/screens/workout_screen.dart';

class StartWorkoutButton extends StatelessWidget {
  final Workout workout;
  final VoidCallback onFinished;

  const StartWorkoutButton({
    super.key,
    required this.workout,
    required this.onFinished,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.accentAlt,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WorkoutScreen(workout: workout),
          ),
        ).then((_) => onFinished());
      },
      icon: const Text("🚀", style: TextStyle(fontSize: 22)),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Start Next Workout", style: AppText.body),
        ],
      ),
    );
  }
}
