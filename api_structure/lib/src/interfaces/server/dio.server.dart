import '../../utils/utils.dart';

abstract class DioClient {
  Future callDio(
    NetworkMethod networkMethod,
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    dynamic formData,
    bool canShowSnackbar = false,
    Map<String, dynamic>? queryParameters,
  });
}
