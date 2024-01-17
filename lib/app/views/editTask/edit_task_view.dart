// ignore_for_file: use_build_context_synchronously

import 'package:app_crud_ezoom/app/controllers/task_controller.dart';
import 'package:app_crud_ezoom/app/models/task_model.dart';
import 'package:app_crud_ezoom/app/services/task/task_services_imp.dart';
import 'package:app_crud_ezoom/app/views/widgets/button.dart';
import 'package:app_crud_ezoom/app/views/widgets/text_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditTaskView extends StatefulWidget {
  final TaskModel taskModel;

  const EditTaskView({super.key, required this.taskModel});

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  final controller = TaskController(TaskServicesImp(dio: Dio()));

  @override
  void initState() {
    super.initState();
    controller.textEddtingTitle.text = widget.taskModel.title;
    controller.textEddtingDesc.text = widget.taskModel.desc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
      ),
      body: Form(
        key: controller.keyTaks,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Icon(Icons.file_open, size: 60),
                const SizedBox(height: 30),
                TextInput(
                  textEditingController: controller.textEddtingTitle,
                  labelText: "Title",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextInput(
                  textEditingController: controller.textEddtingDesc,
                  labelText: "Description",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Button(
                  onPressed: () async {
                    await controller.upadateTask(widget.taskModel.id!).then(
                          (_) => Navigator.pop(context),
                        );
                  },
                  label: "Update Task",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
