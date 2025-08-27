import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/models/exercise.dart';
import 'package:trackrinatr/widgets/frosted_card.dart';


class ExerciseCard extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onChanged;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onChanged
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;

    return FrostedCard(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row( // Name + Weights
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side (Name + warmup weights)
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise.name, style: AppText.subheading),
                  SizedBox(height: 4),
                  Text("Warmup weights", style: AppText.small),
                  Wrap(
                    spacing: 4,
                    children: exercise.warmupWeights.map((w) => Chip(
                      label: Text("$w", style: AppText.caption),
                      backgroundColor: AppColors.primary.withValues(alpha: 0.5),
                    )).toList(),
                  ),

                ],
              )),

              // Right side (working weight)
              Column(
                children: [
                  SizedBox(height: 18),
                  Text(
                    "${exercise.currentWeight}",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),

          SizedBox(height: 8),
          Text("Sets completed", style: AppText.small),
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
        ]

      ),

    );
  }
}