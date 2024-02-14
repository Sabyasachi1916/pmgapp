import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmgapp/src/doctors/activities/activity_model.dart';
import 'package:pmgapp/src/doctors/documents/documents_model.dart';
import 'package:pmgapp/src/doctors/home/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../login/login_model.dart';

class DocumentService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<DocumentList?> getDocuments(String id) async {
    
    final SharedPreferences prefs = await _prefs;
    var bearerToken = prefs.getString('token');
    print(bearerToken);
    var headers = {'Authorization': 'Bearer $bearerToken'};
    var url = Uri.parse(ApiRequest.BASE_URL +'/api/LeadDocument/Get/$id');
    var request = http.Request('GET', url);

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j["message"] == null) {
        final loginResp = DocumentList.fromJson(j);
        print(str);

        return loginResp;
      } else {
        return null;
      }
    }
  }
}