import 'package:app_crud_ezoom/app/models/user_model.dart';
import 'package:app_crud_ezoom/app/services/user/i_user_service.dart';
import 'package:flutter/material.dart';

class UserController {
  final textEddtingName = TextEditingController();
  final textEddtingPassword = TextEditingController();
  final textEddtingEmail = TextEditingController();

  final keySignUp = GlobalKey<FormState>();
  final keySignIn = GlobalKey<FormState>();

  final obscureText = ValueNotifier<bool>(true);
  final loading = ValueNotifier<bool>(false);

  final IUserService _servicesImp;

  UserController(this._servicesImp);

  Future<void> createUser() async {
    loading.value = true;
    try {
      final userModel = UserModel(
        name: textEddtingName.text,
        email: textEddtingEmail.text,
        password: textEddtingPassword.text,
      );

      await _servicesImp.create(userModel: userModel);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      throw Exception(e.toString());
    }
  }

  Future<UserModel> login() async {
    late UserModel user;
    loading.value = true;
    try {
      if (keySignIn.currentState!.validate()) {
        final userModel = UserModel(
          email: textEddtingEmail.text,
          password: textEddtingPassword.text,
        );

        user = await _servicesImp.loginUser(userModel: userModel);
      }
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      throw Exception(e.toString());
    }
  }

  togleOsbcureText() {
    obscureText.value = !obscureText.value;
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
