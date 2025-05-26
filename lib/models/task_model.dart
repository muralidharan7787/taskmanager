class Task {
  int? id;
  String title;
  String description;
  String dueDate;
  bool isCompleted;

  Task({this.id, required this.title, required this.description, required this.dueDate, this.isCompleted = false});

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate,
    'isCompleted': isCompleted ? 1 : 0,
  };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['title'],
    description: map['description'],
    dueDate: map['dueDate'],
    isCompleted: map['isCompleted'] == 1,
  );
}
