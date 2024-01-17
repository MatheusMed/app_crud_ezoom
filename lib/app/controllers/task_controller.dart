import 'package:app_crud_ezoom/app/models/task_model.dart';
import 'package:app_crud_ezoom/app/services/task/i_task_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController {
  final ITaskServices _iTaskServices;

  TaskController(this._iTaskServices);

  final textEddtingTitle = TextEditingController();
  final textEddtingDesc = TextEditingController();

  final keyTaks = GlobalKey<FormState>();

  final listaTasks = ValueNotifier(<TaskModel>[]);
  final task = ValueNotifier<TaskModel?>(null);

  createTask() async {
    if (keyTaks.currentState!.validate()) {
      final taskModel = TaskModel(
        title: textEddtingTitle.text,
        desc: textEddtingDesc.text,
      );

      await _iTaskServices.createTask(taskModel);
    }
  }

  upadateTask(int id) async {
    if (keyTaks.currentState!.validate()) {
      final taskModel = TaskModel(
        id: id,
        title: textEddtingTitle.text,
        desc: textEddtingDesc.text,
      );

      await _iTaskServices.updateTask(taskModel);
    }
  }

  getListTasks() async {
    final listaTaskRemote = await _iTaskServices.getListTask();

    listaTasks.value = List.from(listaTaskRemote);
  }

  deleteTask(int id) async {
    await _iTaskServices.deleteTask(id);
  }

  findTaskById(int id) async {
    final taskFind = await _iTaskServices.findByIdTask(id);
    task.value = taskFind;
  }

  loggout() async {
    final storage = await SharedPreferences.getInstance();
    await storage.clear();
  }

  clearTextEdding() {
    textEddtingDesc.clear();
    textEddtingTitle.clear();
  }

  disposeTextEdding() {
    textEddtingDesc.dispose();
    textEddtingTitle.dispose();
  }
}
