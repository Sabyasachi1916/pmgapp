// To parse this JSON data, do
//
//     final getPasswordResetLinkResp = getPasswordResetLinkRespFromJson(jsonString);

import 'dart:convert';

GetPasswordResetLinkResp getPasswordResetLinkRespFromJson(String str) => GetPasswordResetLinkResp.fromJson(json.decode(str));

String getPasswordResetLinkRespToJson(GetPasswordResetLinkResp data) => json.encode(data.toJson());

class GetPasswordResetLinkResp {
    GetPasswordResetLinkResp({
        required this.message,
    });

    String message;

    factory GetPasswordResetLinkResp.fromJson(Map<String, dynamic> json) => GetPasswordResetLinkResp(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
