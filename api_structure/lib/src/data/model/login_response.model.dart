import '../entity/login_response.entity.dart';

class LoginResponseModel {
  int? id;
  String? username;
  String? gender;
  String? email;
  String? firstName;
  String? lastName;
  String? image;
  String? token;

  LoginResponseModel({
    this.id,
    this.username,
    this.gender,
    this.email,
    this.firstName,
    this.lastName,
    this.image,
    this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json['id'] as int?,
        username: json['username'] as String?,
        gender: json['gender'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        image: json['image'] as String?,
        token: json['token'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "username": username,
        "firstName": firstName,
        "lastname": lastName,
        "email": email,
        "image": image,
        "gender": gender,
      };

  LoginResponseEntity toEntity() => LoginResponseEntity(
        token: token,
        id: id,
        username: username,
        firstName: firstName,
        lastName: lastName,
        email: email,
        image: image,
        gender: gender,
      );
}
