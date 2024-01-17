// ignore_for_file: use_build_context_synchronously

import 'package:app_crud_ezoom/app/views/listTasks/list_task_view.dart';
import 'package:app_crud_ezoom/app/views/signUpView/sign_up_view.dart';
import 'package:app_crud_ezoom/app/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  splashVerify() async {
    final storage = await SharedPreferences.getInstance();

    final token = storage.getString("token");

    if (token != null && token.isNotEmpty) {
      Future.delayed(const Duration(seconds: 2))
          .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ListTaskView(),
              )));
    } else {
      Future.delayed(const Duration(seconds: 2))
          .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpView(),
              )));
    }
  }

  @override
  void initState() {
    splashVerify();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(label: "Loading..."),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
