class LoginRequestModel {
  String? email;
  String? password;
  int? expiresInMins;

  LoginRequestModel({
    this.email,
    this.password,
    this.expiresInMins,
  });

  Map<String, dynamic> toJson() => {
        'username': email,
        'password': password,
        "expiresInMins": 30,
      };
}
