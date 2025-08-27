import 'package:hive_flutter/hive_flutter.dart/';
import 'package:trackrinatr/models/exercise.dart';

class ExerciseRepository {
  static const _boxName = 'exercises';
  final Box _box;

  ExerciseRepository._(this._box);

  static Future<ExerciseRepository> init() async {
    await Hive.initFlutter();
    final box = await Hive.openBox(_boxName);

    return ExerciseRepository._(box);
  }

  Exercise? getByName(String name) {
    final data = _box.get(name);

    if (data == null) return null;

    return Exercise(
      name: data['name'],
      weight: data['weight'],
      sets: data['sets'],
      completedSets: data['completedSets'],
    );
  }

  Future<void> save(Exercise exercise) async {
    await _box.put(exercise.name, {
      'name': exercise.name,
      'weight': exercise.weight,
      'sets': exercise.sets,
      'completedSets': exercise.completedSets,
    });
  }
}