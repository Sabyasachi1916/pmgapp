// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.token,
    required this.expiration,
    required this.user,
  });

  String token;
  DateTime expiration;
  User user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        expiration: DateTime.parse(json["expiration"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expiration": expiration.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  User({
    // required this.userId,
    required this.name,
    required this.username,
    // required this.isPasswordReset,
    // required this.recipientId,
    required this.role,
  });

  //int userId;
  String name;
  String username;
  //bool isPasswordReset;
 // String? recipientId;
  String? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        //userId: json["UserId"],
        name: json["Name"],
        username: json["Username"],
        //isPasswordReset: json["IsPasswordReset"],
        //recipientId: json["RecipientId"],
        role: json["Role"],
      );

  Map<String, dynamic> toJson() => {
        //"UserId": userId,
        "Name": name,
        "Username": username,
       // "IsPasswordReset": isPasswordReset,
       // "RecipientId": recipientId,
        "Role": role,
      };
}
