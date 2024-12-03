class Task {
  int? id;
  String title;
  String description;
  bool isComplete;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isComplete = false,
  });
}