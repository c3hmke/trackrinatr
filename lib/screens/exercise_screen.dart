import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
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
            ...widget.workout.exercises.asMap().entries.map((entry) {
              final index = entry.key;
              final exercise = entry.value;
              return FrostedCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(exercise.name, style: AppText.subheading),
                    const SizedBox(height: 12),

                    Text("Working Weight", style: AppText.small),
                    Text("${exercise.currentWeight}", style: AppText.important),
                    const SizedBox(height: 12),

                    Text("Warmup Weights", style: AppText.small),
                    Wrap(
                      spacing: 8,
                      children: exercise.warmups.map((w) => Chip(
                        label: Text("$w", style: AppText.body),
                        backgroundColor: Colors.blue.withOpacity(0.3),
                      )).toList(),
                    ),
                    const SizedBox(height: 12),

                    Text("Sets Completed", style: AppText.small),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  style: AppText.caption),
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