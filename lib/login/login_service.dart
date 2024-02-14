import 'dart:convert';
import "dart:io";
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';
import 'login_model.dart';

class LoginService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<LoginResponse?> getTokenWith(String userID, String password, bool rememberme) async {
    final SharedPreferences prefs = await _prefs;
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiRequest.BASE_URL + ApiRequest.LOGIN_ENDPIONT);
    var request = http.Request('POST', url);
    request.body = json
        .encode({"username": userID, "password": password});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      if (j["message"] == null){
        final loginResp = LoginResponse.fromJson(j);
       
       

        prefs.setString('token', loginResp.token);
        //prefs.setInt('userId', loginResp.user.userId);
        prefs.setString('username', loginResp.user.username);
        prefs.setString('name', loginResp.user.name);
       // prefs.setString('recepientid', loginResp.user.recipientId ?? '');
        prefs.setString('role', loginResp.user.role ?? '');
        
        if (rememberme == true){
          prefs.setString('loginUser', userID);
          prefs.setString('password', password);
        }else{
          prefs.remove('loginUser');
          prefs.remove('password');
        }

        prefs.setBool('rememberme', rememberme);
        return loginResp;
      }else{
         Fluttertoast.showToast(
            msg: j["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
         return null;
      }
      
      
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
}
