import 'package:app_crud_ezoom/app/controllers/home_controller.dart';
import 'package:app_crud_ezoom/app/views/widgets/button.dart';
import 'package:app_crud_ezoom/app/views/widgets/text_input.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();

  @override
  void dispose() {
    super.dispose();
    controller.textEddtingEmail.dispose();
    controller.textEddtingName.dispose();
    controller.textEddtingPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextInput(
              textEditingController: controller.textEddtingName,
              labelText: "Usuario",
            ),
            const SizedBox(height: 10),
            TextInput(
              textEditingController: controller.textEddtingEmail,
              labelText: "Email",
            ),
            const SizedBox(height: 10),
            TextInput(
              textEditingController: controller.textEddtingPassword,
              labelText: "Senha",
            ),
            const SizedBox(height: 10),
            Button(onPressed: () {}, label: "Criar Conta")
          ],
        ),
      ),
    );
  }
}
