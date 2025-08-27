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
        children: [

          Row( // Name + Weights
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
                  GestureDetector(
                    onTap: () async {
                      final controller = TextEditingController(
                        text: exercise.currentWeight.toString(),
                      );

                      final newWeight = await showDialog<double>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Update Working Weight"),
                            content: TextField(
                              controller: controller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Weight",
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  final value = double.tryParse(controller.text);
                                  Navigator.pop(context, value);
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          );
                        },
                      );

                      if (newWeight != null) {
                        setState(() => exercise.currentWeight = newWeight);
                        widget.onChanged();
                      }
                    },
                    child: Text(
                      "${exercise.currentWeight}",
                      style: const TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),

          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setState(() { exercise.completeNextSet(); });
              widget.onChanged();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sets completed", style: AppText.small),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(exercise.totalSets, (setIndex) {
                    final completed = exercise.isSetCompleted(setIndex);
                    return Container(
                      margin: const EdgeInsets.only(right: 8, top: 8),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: completed ? Colors.green : Colors.blueAccent,
                            width: 2
                        ),
                        color: completed ? Colors.green : Colors.transparent,
                      ),
                      child: Center(
                        child: completed
                            ? const Icon(Icons.check, color: Colors.white, size: 18)
                            : Text("${setIndex + 1}", style: AppText.caption),
                      ),
                    );
                  }),
                )
              ],

            ),
          ),
        ]

      ),

    );
  }
}