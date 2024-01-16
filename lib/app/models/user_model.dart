// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_crud_ezoom/app/models/task_model.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updateAt;
  final List<TaskModel> tasks;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updateAt,
    required this.tasks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updateAt': updateAt.millisecondsSinceEpoch,
      'tasks': tasks.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['updateAt'] as int),
      tasks: List<TaskModel>.from(
        (map['tasks'] as List<int>).map<TaskModel>(
          (x) => TaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, password: $password, createdAt: $createdAt, updateAt: $updateAt, tasks: $tasks)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.createdAt == createdAt &&
        other.updateAt == updateAt &&
        listEquals(other.tasks, tasks);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        createdAt.hashCode ^
        updateAt.hashCode ^
        tasks.hashCode;
  }
}
