// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_crud_ezoom/app/models/user_model.dart';

class TaskModel {
  final int id;
  final String title;
  final String desc;
  final DateTime createdAt;
  final DateTime updateAt;
  final int userId;
  final UserModel usuario;
  TaskModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.createdAt,
    required this.updateAt,
    required this.userId,
    required this.usuario,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updateAt': updateAt.millisecondsSinceEpoch,
      'userId': userId,
      'usuario': usuario.toMap(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      title: map['title'] as String,
      desc: map['desc'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['updateAt'] as int),
      userId: map['userId'] as int,
      usuario: UserModel.fromMap(map['usuario'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, desc: $desc, createdAt: $createdAt, updateAt: $updateAt, userId: $userId, usuario: $usuario)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.createdAt == createdAt &&
        other.updateAt == updateAt &&
        other.userId == userId &&
        other.usuario == usuario;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        createdAt.hashCode ^
        updateAt.hashCode ^
        userId.hashCode ^
        usuario.hashCode;
  }
}
