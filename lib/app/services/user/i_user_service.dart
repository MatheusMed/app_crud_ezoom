import 'package:app_crud_ezoom/app/models/user_model.dart';

abstract class IUserService {
  Future<UserModel> create({required UserModel userModel});
  Future<UserModel> loginUser({required UserModel userModel});
}
