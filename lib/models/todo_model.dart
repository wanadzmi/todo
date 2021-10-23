class Todo {
  int? id;
  final String title;
  DateTime startDate;
  DateTime endDate;
  DateTime creationDate;
  bool isChecked;

  // Declare constructor
  Todo({
    this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.creationDate,
    required this.isChecked,
  });

  // Data convert to map to be able to save them into database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'creationDate': creationDate.toString(),
      'isChecked': isChecked ? 1 : 0,
    };
  }
}
