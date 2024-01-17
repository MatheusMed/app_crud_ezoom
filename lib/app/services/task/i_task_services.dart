import 'package:app_crud_ezoom/app/models/task_model.dart';

abstract interface class ITaskServices {
  Future<TaskModel> createTask(TaskModel taskModel);
  Future<TaskModel> updateTask(TaskModel taskModel);
  Future<List<TaskModel>> getListTask();
  Future deleteTask(int id);
  Future<TaskModel> findByIdTask(int id);
}
