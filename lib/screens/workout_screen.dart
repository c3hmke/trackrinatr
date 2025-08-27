import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/widgets/exercise_card.dart';
import 'package:trackrinatr/widgets/gradient_background.dart';

class WorkoutScreen extends StatefulWidget {
  final Workout workout;
  const WorkoutScreen({super.key, required this.workout});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
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
            ...widget.workout.exercises.asMap().entries.map((entry) =>
              ExerciseCard(
                exercise: entry.value,
                onChanged: () => setState(() {})
              )
            )
          ]
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final isComplete = widget.workout.exercises.every(
              (exercise) => exercise.completedSets == exercise.totalSets
            );

            if (isComplete) { _completeWorkout(); }
            else {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                        "Incomplete Workout!",
                        style: AppText.heading,
                        textAlign: TextAlign.center
                    ),
                    content: const Text(
                        "You haven't completed all sets.\n"
                        "Do you want to log this workout as is?",
                        style: AppText.body,
                        textAlign: TextAlign.center),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.accentAlt, width: 2),
                          foregroundColor: AppColors.accentAlt
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("cancel")
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.amber, width: 2),
                              foregroundColor: Colors.amber
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _completeWorkout();
                          },
                          child: const Text("complete")
                      )
                    ],
                  )
              );
            }
          },
          icon: const Icon(Icons.check),
          label: const Text("Complete Workout", style: AppText.subheading),
          backgroundColor: AppColors.accentAlt,

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }

  void _completeWorkout() {
    widget.workout.lastCompleted = DateTime.now();
    Navigator.pop(context);
  }
}