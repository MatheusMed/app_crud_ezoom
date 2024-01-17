// ignore_for_file: use_build_context_synchronously

import 'package:app_crud_ezoom/app/controllers/user_controller.dart';
import 'package:app_crud_ezoom/app/services/user/user_services_imp.dart';
import 'package:app_crud_ezoom/app/views/signInView/sign_in_view.dart';
import 'package:app_crud_ezoom/app/views/widgets/button.dart';
import 'package:app_crud_ezoom/app/views/widgets/text_input.dart';
import 'package:app_crud_ezoom/app/views/widgets/text_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final controller = UserController(UserServicesImp(dio: Dio()));

  @override
  void dispose() {
    controller.disposeTextEditing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: controller.keySignUp,
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Image.asset(
                    "assets/icons/online-registration-outline.png",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                TextInput(
                  textEditingController: controller.textEddtingName,
                  labelText: "User Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
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
                          if (controller.keySignUp.currentState!.validate()) {
                            await controller.createUser();
                            controller.clearTextEditing();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInView(),
                                ));
                          }
                        },
                        label: "Sign Up",
                        loading: loading,
                      );
                    }),
                const SizedBox(height: 10),
                const Center(
                  child: TextWidget(
                    label: "Already have an account?",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Button(
                  onPressed: () {
                    controller.clearTextEditing();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInView(),
                        ));
                  },
                  label: "Sign In",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
