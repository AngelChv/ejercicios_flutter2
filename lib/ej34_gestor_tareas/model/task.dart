class Task {
  String title;
  String description;
  bool isComplete;

  Task({
    required this.title,
    required this.description,
    this.isComplete = false,
  });
}
