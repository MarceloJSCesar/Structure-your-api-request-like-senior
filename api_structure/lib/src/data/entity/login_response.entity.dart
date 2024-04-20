class LoginResponseEntity {
  int? id;
  String? username;
  String? gender;
  String? email;
  String? firstName;
  String? lastName;
  String? image;
  String? token;

  LoginResponseEntity({
    this.id,
    this.username,
    this.gender,
    this.email,
    this.firstName,
    this.lastName,
    this.image,
    this.token,
  });

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
}
