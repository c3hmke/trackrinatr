import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackrinatr/models/workout.dart';
import 'package:trackrinatr/models/exercise.dart';

class WorkoutRepository {
  static const _boxName = 'workouts';
  final Box _box;

  WorkoutRepository._(this._box);

  static Future<WorkoutRepository> init() async {
    await Hive.initFlutter();
    final box = await Hive.openBox(_boxName);

    return WorkoutRepository._(box);
  }

  Future<void> save(Workout workout) async {
    await _box.put(workout.name, {
      'name': workout.name,
      'lastCompleted': workout.lastCompleted.toIso8601String(),
      'exercises': workout.exercises.map((e) => e.name).toList(),
    });
  }

  Workout? get(String name, Map<String, Exercise> exerciseMap) {
    final data = _box.get(name);
    return (data == null) ? null :
      Workout(
        name: data['name'],
        lastCompleted: DateTime.parse(data['lastCompleted']),
        exercises: (data['exercises'] as List)
            .map((n) => exerciseMap[n]!)
            .toList(),
      );
  }

  Future<List<Workout>> getAll(Map<String, Exercise> exerciseMap) async {
    return _box.values.map((data) => Workout(
      name: data['name'],
      lastCompleted: DateTime.parse(data['lastCompleted']),
      exercises: (data['exercises'] as List).map((n) => exerciseMap[n]!).toList(),
    )).toList();
  }
}