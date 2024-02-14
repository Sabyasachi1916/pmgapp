import 'dart:convert';
import "dart:io";
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'forgotpass_model.dart';

class ForgotPassword_Service{

  Future<GetPasswordResetLinkResp?> submitEmail(String email) async {
    // final SharedPreferences prefs = await _prefs;
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiRequest.BASE_URL + ApiRequest.FORGOT_PASSWORD_ENDPOINT);
    var request = http.Request('POST', url);
    request.body = json
        .encode({"baseurl": "https://united.octdaily.com", "email": email});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      if (j["message"] != null){
        final loginResp = GetPasswordResetLinkResp.fromJson(j);
        print(str);
        // prefs.setString('token', loginResp.token);
        // prefs.setInt('userId', loginResp.user.userId);
        // prefs.setString('username', loginResp.user.username);
        // prefs.setString('name', loginResp.user.name);
        // prefs.setString('recepientid', loginResp.user.recipientId ?? '');
        //  Fluttertoast.showToast(
        //     msg: j["message"],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
        return loginResp;
      }else{
        //  Fluttertoast.showToast(
        //     msg: j["message"],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
         return null;
      }
      
      
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
}