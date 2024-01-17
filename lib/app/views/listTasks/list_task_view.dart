// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app_crud_ezoom/app/controllers/task_controller.dart';
import 'package:app_crud_ezoom/app/services/task/task_services_imp.dart';
import 'package:app_crud_ezoom/app/views/createNewTask/create_new_task.dart';
import 'package:app_crud_ezoom/app/views/editTask/edit_task_view.dart';
import 'package:app_crud_ezoom/app/views/signUpView/sign_up_view.dart';
import 'package:app_crud_ezoom/app/views/viewTask/view_task.dart';
import 'package:app_crud_ezoom/app/views/widgets/text_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListTaskView extends StatefulWidget {
  const ListTaskView({super.key});

  @override
  State<ListTaskView> createState() => _ListTaskViewState();
}

class _ListTaskViewState extends State<ListTaskView> {
  late Timer _timer;
  final controller = TaskController(TaskServicesImp(dio: Dio()));

  @override
  void initState() {
    super.initState();
    controller.getListTasks();
    controller.clearTextEdding();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      controller.getListTasks();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    controller.disposeTextEdding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Tasks'),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.loggout();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpView(),
                  ));
            },
            icon: const Icon(Icons.person_off),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateNewTask(),
              ));
        },
        label: const Text("Create New Task"),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.listaTasks,
        builder: (context, lista, child) {
          return lista.isEmpty
              ? const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(label: "No tasks added to"),
                      SizedBox(width: 10),
                      Icon(Icons.add_task_outlined)
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (context, index) {
                    final item = lista[index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ViewTask(id: item.id!);
                            },
                          ));
                        },
                        title: Text("Title: ${item.title}"),
                        subtitle: Text("Description: ${item.desc}"),
                        leading: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return EditTaskView(taskModel: item);
                              },
                            ))
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => controller.deleteTask(item.id!),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
