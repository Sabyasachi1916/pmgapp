import 'dart:convert';
import 'dart:io' show Platform;
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmgapp/src/doctors/acpnote/note_model.dart';
import 'package:pmgapp/src/doctors/activities/activity_model.dart';
import 'package:pmgapp/src/doctors/home/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../login/login_model.dart';

class Note_Services{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<List<ApsImage>?> getNoteList(String id) async {
    
    final SharedPreferences prefs = await _prefs;
    var bearerToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $bearerToken'};
    var url = Uri.parse(ApiRequest.BASE_URL +'/api/Apsnote/ImageList?LeadNumber=$id');
    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j != null) {
        final loginResp = apsImageListFromJson(str);
        print(str);

        return loginResp;
      } else {
        return null;
      }
    }
  }
}