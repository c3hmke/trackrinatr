import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/widgets/workout_list_item.dart';

class WorkoutList extends StatelessWidget {
  final List<Workout> workouts;
  final VoidCallback onUpdated;

  const WorkoutList({
    super.key, required this.workouts, required this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) {

        if (index == 0) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WorkoutListItem(
                    workout: workouts[index],
                    onUpdated: onUpdated
                ),

                Row(children: [

                  const Text('up next', style: AppText.captionAlt),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: AppColors.accentAlt,
                    ),
                  ),
                ]),
                const SizedBox(height: 24)
              ]
          );
        }

        return WorkoutListItem(
            workout: workouts[index],
            onUpdated: onUpdated
        );
      },
    );
  }

}