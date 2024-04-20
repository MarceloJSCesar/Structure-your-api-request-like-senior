import 'dart:developer';

import 'package:dio/dio.dart';

import '../data/model/api_response.model.dart';
import '../interfaces/interfaces.dart';
import '../utils/utils.dart';

class DioApi implements DioClient {
  final dio = Dio();
  @override
  Future callDio(
    NetworkMethod networkMethod,
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    dynamic formData,
    bool canShowSnackbar = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    // default content-type
    dio.options.contentType = Headers.jsonContentType;

    // configuring headers
    dynamic data = {};
    if (headers != null) {
      dio.options.headers = headers;
    }

    data = body ?? formData;

    // making the requests according to networkMethod
    Response response = await (() {
      switch (networkMethod) {
        case NetworkMethod.post:
          return dio.post(url, data: data);
        case NetworkMethod.get:
          return dio.get(url, queryParameters: queryParameters);
        case NetworkMethod.put:
          return dio.put(url, data: data);
        case NetworkMethod.delete:
          return dio.delete(url, data: data);
        case NetworkMethod.patch:
          return dio.patch(url, data: data);
      }
    })();

    // In case any error occur while making a request it sends a error
    switch (response.statusCode) {
      case 400:
        // show snackbar message, try again
        log("${response.statusCode} --- ${response.data}");

        // I would state managment to throw error messages from here automatically because I need the context of my current screen(login view)
        throw ApiResponseModel(
            data: response.data, networkStatus: NetworkStatus.clientError);
      case 401:
        // show snackbar message, try again
        log("${response.statusCode} --- ${response.data}");
        throw ApiResponseModel(
            data: response.data, networkStatus: NetworkStatus.unauthenticated);
      case 403:
        // show snackbar message, no permission
        log("${response.statusCode} --- ${response.data}");
        throw ApiResponseModel(
            data: response.data, networkStatus: NetworkStatus.unauthorized);
      case 404:
        // show snackbar message, not found
        log("${response.statusCode} --- ${response.data}");
        throw ApiResponseModel(
            data: response.data, networkStatus: NetworkStatus.notFound);
      case 200:
        log("${response.statusCode} --- ${response.data}");

        // You would decode it only if the response was a map
        //  final data = jsonDecode(response.data);

        if (data != null && data != "" && canShowSnackbar) {
          // show snackbar or anything showing "login success" ...
          log("login success");
        }

        return ApiResponseModel(
          data: response.data,
          networkStatus: NetworkStatus.success,
        );

      case 201:
        // show snackbar message, success
        return ApiResponseModel(
            data: response.data, networkStatus: NetworkStatus.success);
      case 409:
        // show snackbar message, conflict
        log("${response.statusCode} --- ${response.data}");
        throw ApiResponseModel(
            data: response.data, networkStatus: NetworkStatus.conflict);
      case 424:
        // show snackbar message, not found
        log("${response.statusCode} --- ${response.data}");
        throw ApiResponseModel(
            data: response.data, networkStatus: NetworkStatus.failed);
      case 422:
        // show snackbar message, when sending files/import
        log("${response.statusCode} --- ${response.data}");
        throw ApiResponseModel(
            data: response.data, networkStatus: NetworkStatus.unproccessable);
      default:
        log("${response.statusCode} ---  ${response.data}");
        throw ApiResponseModel(
            data: response.data, networkStatus: NetworkStatus.unexpected);
    }
  }
}
