class Exercise {
  final String name;
  final int currentWeight;
  final List<int> warmups;
  List<bool> sets;

  Exercise({
    required this.name,
    required this.currentWeight,
    required this.warmups,
    this.sets = const [false, false, false, false, false],
  });
}