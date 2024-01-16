import 'package:app_crud_ezoom/app/models/user_model.dart';
import 'package:app_crud_ezoom/app/services/user/i_user_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServicesImp implements IUserService {
  const UserServicesImp({required this.dio});
  final Dio dio;

  @override
  Future<UserModel> create({required UserModel userModel}) async {
    final response = await dio.post(
      "http://localhost:3000/createUser",
      data: {
        "name": userModel.name,
        "email": userModel.email,
        "password": userModel.password
      },
    );

    final usuario = UserModel.fromMap(response.data["user"]);

    return usuario;
  }

  @override
  Future<UserModel> loginUser({required UserModel userModel}) async {
    final storage = await SharedPreferences.getInstance();

    final response = await dio.post(
      "http://localhost:3000/createUser",
      data: {
        "email": userModel.email,
        "password": userModel.password,
      },
    );
    final usuario = UserModel.fromMap(response.data["usuario"]);
    await storage.setInt("userId", usuario.id);
    await storage.setString("token", response.data["token"]);
    return usuario;
  }
}
