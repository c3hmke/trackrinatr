import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/exercise.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/repositories/exercise_log_repository.dart';
import 'package:trackrinatr/repositories/exercise_repository.dart';
import 'package:trackrinatr/repositories/workout_repository.dart';
import 'package:trackrinatr/widgets/exercise_card.dart';
import 'package:trackrinatr/widgets/gradient_background.dart';

class WorkoutScreen extends StatefulWidget {
  final Workout workout;
  const WorkoutScreen({super.key, required this.workout});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late final ExerciseRepository _exerciseRepository;
  late final WorkoutRepository _workoutRepository;
  late final ExerciseLogRepository _logRepository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _exerciseRepository = Provider.of<ExerciseRepository>(context, listen: false);
    _workoutRepository  = Provider.of<WorkoutRepository>(context, listen: false);
    _logRepository      = Provider.of<ExerciseLogRepository>(context, listen: false);
  }

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
              (exercise) => exercise.completedSets == exercise.sets
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

  /// Complete a workout, this will log the progress on exercises completed
  /// and update the working weights if all sets have been completed as well
  /// as reset the working models so they're ready for the next session.
  void _completeWorkout() async {
    final now = DateTime.now();

    /// Concurrently log & update the completed exercises
    final updatedExercises = await Future.wait(
      widget.workout.exercises.map((e) async {
        await _logRepository.log(e, now);

        final updated = Exercise(
          name:          e.name,
          weight:        e.completedSets == e.sets ? e.weight + 2.5 : e.weight,
          sets:          e.sets,
          completedSets: 0,
        );

        await _exerciseRepository.save(updated);
        return updated;
      }),
    );

    /// Update & save the Workout information
    widget.workout
      ..lastCompleted = now
      ..exercises     = updatedExercises;

    await _workoutRepository.save(widget.workout);

    /// Return to the previous screen
    if (!mounted) return;   // if the widget is no longer in the tree due to
    Navigator.pop(context); // async shenanigans just return, otherwise pop
  }
}