// ignore_for_file: use_build_context_synchronously

import 'package:app_crud_ezoom/app/controllers/task_controller.dart';
import 'package:app_crud_ezoom/app/services/task/task_services_imp.dart';
import 'package:app_crud_ezoom/app/views/widgets/button.dart';
import 'package:app_crud_ezoom/app/views/widgets/text_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({super.key});

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final controller = TaskController(TaskServicesImp(dio: Dio()));

  @override
  void initState() {
    super.initState();
    controller.clearTextEdding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Task'),
      ),
      body: Form(
        key: controller.keyTaks,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Icon(Icons.file_copy, size: 60),
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
                    await controller.createTask();
                    Navigator.pop(context);
                  },
                  label: "Create Task",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
