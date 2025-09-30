import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackrinatr/models/exercise.dart';
import 'package:trackrinatr/models/exercise_log.dart';

class ExerciseLogRepository {
  static const _boxName = 'exercise_logs';
  final Box    _box;

  ExerciseLogRepository._(this._box);

  static Future<ExerciseLogRepository> init() async {
    await Hive.initFlutter();
    return ExerciseLogRepository._(await Hive.openBox(_boxName));
  }

  /// Saves an exercise to the logs
  Future<void> log(Exercise exercise, DateTime? date) async {
    date = date ?? DateTime.now();
    await _box.add({
      'name':          exercise.name,
      'weight':        exercise.weight,
      'sets':          exercise.sets,
      'completedSets': exercise.completedSets,
      'completedDate': date.toIso8601String(),
    });
  }

  /// Retrieve all logs for a specific exercise
  Future<List<ExerciseLog>> getHistory(String name) async {
    return _box.values
      .where((data) => data['name'] == name)
      .map((data) => ExerciseLog(
        name:          data['name'],
        weight:        data['weight'],
        sets:          data['sets'],
        completedSets: data['completedSets'],
        completedDate: DateTime.parse(data['completedDate']),
      ))
      .toList();
  }
}