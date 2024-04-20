import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../data/model/api_response.model.dart';
import '../interfaces/interfaces.dart';

class HttpApi implements HttpClient {
  @override
  Future callHttp(
    NetworkMethod networkMethod, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    dynamic formData,
    String? url,
    bool canShowSnackbar = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    // configuring headers
    dynamic data = {};

    data = json.encode(body ?? formData);

    // making the requests according to networkMethod
    http.Response response = await (() {
      switch (networkMethod) {
        case NetworkMethod.post:
          return http.post(Uri.parse(url ?? ''), body: data, headers: headers);
        case NetworkMethod.get:
          return http.get(Uri.parse(url ?? ''), headers: headers);
        case NetworkMethod.put:
          return http.put(Uri.parse(url ?? ''), body: data);
        case NetworkMethod.delete:
          return http.delete(Uri.parse(url ?? ''), body: data);
        case NetworkMethod.patch:
          return http.patch(Uri.parse(url ?? ''), body: data);
      }
    })();

    // In case any error occur while making a request it sends a error
    switch (response.statusCode) {
      case 400:
        // show snackbar message, try again
        log("${response.statusCode} --- ${response.body}");

        // I would state managment to throw error messages from here automatically because I need the context of my current screen(login view)
        throw ApiResponseModel(
            data: response.body, networkStatus: NetworkStatus.clientError);
      case 401:
        // show snackbar message, try again
        log("${response.statusCode} --- ${response.body}");
        throw ApiResponseModel(
            data: response.body, networkStatus: NetworkStatus.unauthenticated);
      case 403:
        // show snackbar message, no permission
        log("${response.statusCode} --- ${response.body}");
        throw ApiResponseModel(
            data: response.body, networkStatus: NetworkStatus.unauthorized);
      case 404:
        // show snackbar message, not found
        log("${response.statusCode} --- ${response.body}");
        throw ApiResponseModel(
            data: response.body, networkStatus: NetworkStatus.notFound);
      case 200:
        log("${response.statusCode} --- ${response.body}");

        // final data = jsonDecode(response.body);

        if (data != null && data != "" && canShowSnackbar) {
          // show snackbar or anything showing "login success" ...
          log("login success");
        }

        return ApiResponseModel(
          data: response.body,
          networkStatus: NetworkStatus.success,
        );

      case 201:
        // show snackbar message, success
        return ApiResponseModel(
            data: response.body, networkStatus: NetworkStatus.success);
      case 409:
        // show snackbar message, conflict
        log("${response.statusCode} --- ${response.body}");
        throw ApiResponseModel(
            data: response.body, networkStatus: NetworkStatus.conflict);
      case 424:
        // show snackbar message, not found
        log("${response.statusCode} --- ${response.body}");
        throw ApiResponseModel(
            data: response.body, networkStatus: NetworkStatus.failed);
      case 422:
        // show snackbar message, when sending files/import
        log("${response.statusCode} --- ${response.body}");
        throw ApiResponseModel(
            data: response.body, networkStatus: NetworkStatus.unproccessable);
      default:
        log("${response.statusCode} ---  ${response.body}");
        throw ApiResponseModel(
            data: response.body, networkStatus: NetworkStatus.unexpected);
    }
  }
}
