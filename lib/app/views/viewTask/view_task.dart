import 'package:app_crud_ezoom/app/controllers/task_controller.dart';
import 'package:app_crud_ezoom/app/services/task/task_services_imp.dart';
import 'package:app_crud_ezoom/app/views/widgets/text_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ViewTask extends StatefulWidget {
  final int id;
  const ViewTask({super.key, required this.id});

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  final controller = TaskController(TaskServicesImp(dio: Dio()));

  @override
  void initState() {
    controller.findTaskById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task By Id ${widget.id}'),
      ),
      body: ValueListenableBuilder(
          valueListenable: controller.task,
          builder: (context, task, _) {
            return task == null
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          label: "Title: ${task.title}",
                          fontSize: 20,
                        ),
                        const SizedBox(height: 20),
                        TextWidget(
                          label: "Description: ${task.desc}",
                          fontSize: 20,
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
