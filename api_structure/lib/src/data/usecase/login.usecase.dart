import 'dart:convert';
import 'dart:developer';

import '../../api/dio.api.dart';
import '../../api/http.api.dart';
import '../../interfaces/interfaces.dart';
import '../../utils/utils.dart';
import '../data.dart';

class LoginUsecase extends LoginRepository {
  // When using state managment
  // DioClient? dio;
  // HttpClient? http;

  final DioClient dio = DioApi();
  final HttpClient http = HttpApi();

  // API Request using Dio
  /* @override
  Future<LoginResponseEntity?> login(LoginRequestModel model) async {
    try {
      log("data sent: ${model.toJson()}");
      final request = await dio.callDio(
        NetworkMethod.post,
        ApiRoutes.login,
        body: model.toJson(),
        headers: {'Content-Type': 'application/json'},
        canShowSnackbar: true,
      );
      log("response: ${request.toJson()}");
      return LoginResponseModel.fromJson(request.data).toEntity();
    } on DioException {
      log("bad request");
    } catch (errorMsg) {
      log(errorMsg.toString());
    }
    return null;
  } */

  // API Request using HTTP
  @override
  Future<LoginResponseEntity?> login(LoginRequestModel model) async {
    try {
      log("data sent: ${model.toJson()}");
      final request = await http.callHttp(
        NetworkMethod.post,
        body: model.toJson(),
        url: ApiRoutes.login,
        headers: {'Content-Type': 'application/json'},
        canShowSnackbar: true,
      );

      return LoginResponseModel.fromJson(json.decode(request.data)).toEntity();
    } catch (errorMsg) {
      log('errorMsg $errorMsg');
    }
    return null;
  }
}
