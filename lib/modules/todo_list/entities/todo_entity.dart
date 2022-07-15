class TodoEntity {
  TodoEntity({
    required this.id,
    required this.title,
    required this.completed,
  });

  final int id;
  final String title;

  final bool completed;

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
