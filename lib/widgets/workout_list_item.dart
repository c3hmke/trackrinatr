import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/screens/workout_screen.dart';
import 'package:trackrinatr/widgets/frosted_card.dart';

class WorkoutListItem extends StatelessWidget {
  final Workout workout;
  final VoidCallback onUpdated;

  const WorkoutListItem({
    super.key,
    required this.workout,
    required this.onUpdated,
  });

  String formatDate(DateTime date) {
    final diffDays = DateTime.now().difference(date).inDays;

    switch (diffDays) {
      case 0: return "Today";
      case 1: return "Yesterday";
      default: return "$diffDays days ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    String lastCompletedText = formatDate(workout.lastCompleted);

    return GestureDetector(

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WorkoutScreen(workout: workout),
          ),
        ).then((_) => onUpdated());
      },

      child: FrostedCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(workout.name, style: AppText.subheading),
            Text("Last: $lastCompletedText", style: AppText.caption),
          ],
        ),
      ),

    );
  }
}