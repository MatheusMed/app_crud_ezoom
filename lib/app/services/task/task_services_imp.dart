import 'dart:developer';

import 'package:app_crud_ezoom/app/models/task_model.dart';
import 'package:app_crud_ezoom/app/services/task/i_task_services.dart';
import 'package:app_crud_ezoom/app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskServicesImp implements ITaskServices {
  final Dio dio;

  TaskServicesImp({required this.dio});

  @override
  Future<TaskModel> createTask(TaskModel taskModel) async {
    final storage = await SharedPreferences.getInstance();

    final token = storage.getString("token");
    final userId = storage.getInt("userId");

    final response = await dio.post(
      "$BASEURL/createTask",
      data: {
        "userId": userId,
        "title": taskModel.title,
        "desc": taskModel.desc,
      },
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    log(response.data.toString());
    final taskCreate = TaskModel.fromMap(response.data["task"]);

    return taskCreate;
  }

  @override
  Future deleteTask(int id) async {
    final storage = await SharedPreferences.getInstance();

    final token = storage.getString("token");
    final userId = storage.getInt("userId");
    await dio.delete(
      "$BASEURL/deleteTask",
      data: {"userId": userId, "id": id},
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }

  @override
  Future<TaskModel> findByIdTask(int id) async {
    final storage = await SharedPreferences.getInstance();

    try {
      final token = storage.getString("token");
      final userId = storage.getInt("userId");

      final response = await dio.get(
        "$BASEURL/getTaksById",
        data: {"userId": userId, "id": id},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      final taskModel = TaskModel.fromMap(response.data["task"]);

      return taskModel;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<List<TaskModel>> getListTask() async {
    final storage = await SharedPreferences.getInstance();

    try {
      final token = storage.getString("token");
      final userId = storage.getInt("userId");

      final response = await dio.get(
        "$BASEURL/listasTaks",
        data: {"userId": userId},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      final listaTasks = response.data["getListaTasks"] as List;

      final lista = listaTasks.map((e) {
        return TaskModel.fromMap(e);
      }).toList();

      return lista;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel taskModel) async {
    final storage = await SharedPreferences.getInstance();

    final token = storage.getString("token");
    final userId = storage.getInt("userId");

    final response = await dio.post(
      "$BASEURL/editingTaksById",
      data: {
        "id": taskModel.id,
        "userId": userId,
        "title": taskModel.title,
        "desc": taskModel.desc,
      },
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    final taskUpdate = TaskModel.fromMap(response.data["task"]);

    return taskUpdate;
  }
}
