import 'package:app_crud_ezoom/app/models/task_model.dart';

abstract interface class ITaskServices {
  Future<TaskModel> createTask(TaskModel taskModel);
}
