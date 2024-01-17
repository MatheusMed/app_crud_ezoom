// ignore_for_file: use_build_context_synchronously

import 'package:app_crud_ezoom/app/controllers/user_controller.dart';
import 'package:app_crud_ezoom/app/services/user/user_services_imp.dart';
import 'package:app_crud_ezoom/app/views/listTasks/list_task_view.dart';
import 'package:app_crud_ezoom/app/views/widgets/button.dart';
import 'package:app_crud_ezoom/app/views/widgets/text_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final controller = UserController(UserServicesImp(dio: Dio()));

  @override
  void dispose() {
    super.dispose();
    controller.disposeTextEditing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.keySignIn,
          child: Center(
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Image.asset(
                    "assets/icons/online-registration.png",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                TextInput(
                  textEditingController: controller.textEddtingEmail,
                  labelText: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder(
                    valueListenable: controller.obscureText,
                    builder: (context, obsure, _) {
                      return TextInput(
                        textEditingController: controller.textEddtingPassword,
                        labelText: "Password",
                        obscureText: obsure,
                        suffixIcon: IconButton(
                          onPressed: () => controller.togleOsbcureText(),
                          icon: Icon(obsure == true
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                      );
                    }),
                const SizedBox(height: 10),
                ValueListenableBuilder(
                    valueListenable: controller.loading,
                    builder: (context, loading, _) {
                      return Button(
                        onPressed: () async {
                          final user = await controller.login();

                          if (user.name!.isNotEmpty) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListTaskView(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        label: "Sign In",
                        loading: loading,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
