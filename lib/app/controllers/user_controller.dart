import 'package:app_crud_ezoom/app/models/user_model.dart';
import 'package:app_crud_ezoom/app/services/user/i_user_service.dart';
import 'package:flutter/material.dart';

class UserController {
  final textEddtingName = TextEditingController();
  final textEddtingPassword = TextEditingController();
  final textEddtingEmail = TextEditingController();

  final keySingUp = GlobalKey<FormState>();

  final IUserService _servicesImp;

  UserController(this._servicesImp);

  Future<void> createUser() async {
    if (keySingUp.currentState!.validate()) {
      final userModel = UserModel(
        name: textEddtingName.text,
        email: textEddtingEmail.text,
        password: textEddtingPassword.text,
      );

      await _servicesImp.create(userModel: userModel);
    }
  }

  Future<UserModel> login() async {
    late UserModel user;
    try {
      if (keySingUp.currentState!.validate()) {
        final userModel = UserModel(
          email: textEddtingEmail.text,
          password: textEddtingPassword.text,
        );

        user = await _servicesImp.loginUser(userModel: userModel);
      }
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  disposeTextEditing() {
    textEddtingEmail.dispose();
    textEddtingName.dispose();
    textEddtingPassword.dispose();
  }

  clearTextEditing() {
    textEddtingEmail.clear();
    textEddtingName.clear();
    textEddtingPassword.clear();
  }
}
