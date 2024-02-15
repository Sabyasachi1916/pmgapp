import 'dart:convert';
import 'dart:io' show Platform;
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmgapp/src/doctors/home/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../login/login_model.dart';

class homeService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // getToken() async {
  //   final SharedPreferences prefs = await _prefs;

  //   messaging.getToken().then((value) => {
  //         prefs.setString('device_token', value.toString()),
  //         print('Device token - ${value.toString()}'),
  //         saveDeviceToken(value.toString())
  //       });
  // }

  Future<LoginResponse?> saveDeviceToken(String deviceToken) async {
    var platform = '';
    if (Platform.isIOS) {
      print('is a IOS');
      platform = 'ios';
    } else if (Platform.isAndroid) {
      print('is a Andriod');
      platform = 'android';
    } else {}
    final SharedPreferences prefs = await _prefs;
    var bearerToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $bearerToken'};
    var url = Uri.parse(ApiRequest.BASE_URL +
        ApiRequest.SAVE_DEVICE_TOKEN +
        '?deviceId=$deviceToken&deviceType=$platform');
        print('Url is ' + url.toString());
    var request = http.Request('POST', url);

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j["message"] == null) {
        final loginResp = LoginResponse.fromJson(j);
        print(str);

        return loginResp;
      } else {
        return null;
      }
    }
  }

  Future<LoginResponse?> deleteDeviceToken() async {
    var platform = '';
    if (Platform.isIOS) {
      print('is a IOS');
      platform = 'ios';
    } else if (Platform.isAndroid) {
      print('is a Andriod');
      platform = 'android';
    } else {}
    final SharedPreferences prefs = await _prefs;
    var device_token = prefs.getString('device_token');
    var bearerToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $bearerToken'};
    var url = Uri.parse(ApiRequest.BASE_URL +
        ApiRequest.REMOVE_DEVICE_TOKEN +
        '?deviceId=$device_token&deviceType=$platform');
    var request = http.Request('POST', url);

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j["message"] == null) {
        final loginResp = LoginResponse.fromJson(j);
        print(str);
        prefs.remove('device_token');

        return loginResp;
      } else {
        return null;
      }
    }
  }

  Future<LoginResponse?> saveLocation(String lat, String lng) async {
    final SharedPreferences prefs = await _prefs;
    var data = {"lat": lat, "long": lng,};

    var bearerToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $bearerToken', 'content-type': 'application/json'};
    var url = Uri.parse(ApiRequest.BASE_URL + '/api/LocationTrack/Save');
    var request = http.Request('POST', url);
    request.body = json.encode(data);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j["message"] == null) {
        final loginResp = LoginResponse.fromJson(j);
        print(str);
        return loginResp;
      } else {
        return null;
      }
    } else {
      print(response.statusCode.toString());
    }
  }

  Future<FollowUpList?> getDailyLeads(String date) async {
    var platform = '';
    if (Platform.isIOS) {
      print('is a IOS');
      platform = 'ios';
    } else if (Platform.isAndroid) {
      print('is a Andriod');
      platform = 'android';
    } else {}
    final SharedPreferences prefs = await _prefs;
    var bearerToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $bearerToken'};
    var url = Uri.parse(
        ApiRequest.BASE_URL +'/api/FollowUp/List?length=20&isAsc=true&FollowUpDate=${date}'); //yyyy-MM-dd
        print('Getting data from - $url');
    var request = http.Request('GET', url);

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      
      print(str);
      if (j["message"] == null) {
        final loginResp = FollowUpList.fromJson(j);
        print(str);

        return loginResp;
      } else {
        return null;
      }
    }
  }

  
}
