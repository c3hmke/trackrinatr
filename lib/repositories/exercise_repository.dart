import 'package:hive_flutter/hive_flutter.dart';
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

  Future<void> save(Exercise exercise) async {
    await _box.put(exercise.name, {
      'name': exercise.name,
      'weight': exercise.weight,
      'sets': exercise.sets,
      'completedSets': exercise.completedSets,
    });
  }

  Exercise? get(String name) {
    final data = _box.get(name);
    return (data == null) ? null :
      Exercise(
        name: data['name'],
        weight: data['weight'],
        sets: data['sets'],
        completedSets: data['completedSets'],
      );
  }

  Future<List<Exercise>> getAll() async {
    return _box.values.map(
      (data) => Exercise(
        name: data['name'],
        weight: data['weight'],
        sets: data['sets'],
        completedSets: data['completedSets']
      )
    ).toList();
  }
}