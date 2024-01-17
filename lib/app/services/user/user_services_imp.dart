import 'dart:developer';

import 'package:app_crud_ezoom/app/models/user_model.dart';
import 'package:app_crud_ezoom/app/services/user/i_user_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class UserServicesImp implements IUserService {
  const UserServicesImp({required this.dio});
  final Dio dio;

  @override
  Future<UserModel> create({required UserModel userModel}) async {
    try {
      final response = await dio.post("$BASEURL/createUser",
          data: {
            "name": userModel.name,
            "email": userModel.email,
            "password": userModel.password
          },
          options: Options(
            contentType: "application/json",
          ));

      final usuario = UserModel.fromMap(response.data["usuario"]);

      return usuario;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> loginUser({required UserModel userModel}) async {
    final storage = await SharedPreferences.getInstance();

    try {
      final response = await dio.post(
        "$BASEURL/loginUser",
        data: {
          "email": userModel.email,
          "password": userModel.password,
        },
        options: Options(
          contentType: "application/json",
        ),
      );

      log(response.data.toString());
      final usuario = UserModel.fromMap(response.data["usuario"]);
      await storage.setInt("userId", usuario.id!);
      await storage.setString("token", response.data["token"]);
      return usuario;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
