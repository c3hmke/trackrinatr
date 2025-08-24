import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/widgets/exercise_card.dart';
import 'package:trackrinatr/widgets/frosted_card.dart';
import 'package:trackrinatr/widgets/gradient_background.dart';

class ExerciseScreen extends StatefulWidget {
  final Workout workout;
  const ExerciseScreen({super.key, required this.workout});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.workout.name, style: AppText.heading),
          centerTitle: true,
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...widget.workout.exercises.asMap().entries.map(
                    (entry) => ExerciseCard(
                        exercise: entry.value,
                        onChanged: () => setState(() {})
                    )
            ),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
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
              icon: const Icon(Icons.check, size: 28),
              label: const Text("Complete Workout", style: AppText.subheading),
            )
          ],
        ),
    ));
  }
}