import '../../data/data.dart';

abstract class LoginRepository {
  Future<LoginResponseEntity?> login(LoginRequestModel model);
}
