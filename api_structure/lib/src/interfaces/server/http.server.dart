import 'network_method.server.dart';

abstract class HttpClient {
  Future callHttp(
    NetworkMethod networkMethod, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    dynamic formData,
    String? url,
    bool canShowSnackbar = false,
    Map<String, dynamic>? queryParameters,
  });
}
