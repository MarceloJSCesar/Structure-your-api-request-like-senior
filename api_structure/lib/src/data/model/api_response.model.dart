import 'package:api_structure/src/interfaces/interfaces.dart';

export 'api_response.model.dart';

class ApiResponseModel {
  dynamic data;
  NetworkStatus? networkStatus;

  ApiResponseModel({
    this.data,
    this.networkStatus,
  });

  Map<String, dynamic> toJson() => {
        'data': data,
        'networkStatus': networkStatus,
      };
}
