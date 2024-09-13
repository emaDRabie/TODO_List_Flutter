class Todo {
  String id;
  String title;
  String description;
  bool isCompleted;
  DateTime? timestamp;
  DateTime? date;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.timestamp,
    this.date,
  });
}
