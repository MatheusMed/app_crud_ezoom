// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final int? id;
  final String title;
  final String desc;
  final int? userId;

  TaskModel({
    this.id,
    required this.title,
    required this.desc,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'userId': userId,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      desc: map['desc'] as String,
      userId: map['userId'] != null ? map['userId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, desc: $desc, userId: $userId)';
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? desc,
    int? userId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      userId: userId ?? this.userId,
    );
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ desc.hashCode ^ userId.hashCode;
  }
}
