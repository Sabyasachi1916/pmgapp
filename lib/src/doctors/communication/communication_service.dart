import 'dart:convert';

import 'package:pmgapp/constants.dart';
import 'package:pmgapp/src/doctors/communication/communication_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Communication_service {
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


Future<CommunicationList?> getCommunication(String leadNo) async {
    final SharedPreferences prefs = await _prefs;

    var bearerToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $bearerToken', 'content-type': 'application/json'};
    var url = Uri.parse(ApiRequest.BASE_URL + '/api/Message/List?isAsc=false&LeadNumber=$leadNo&length=10');
    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j["message"] == null) {
        final loginResp = CommunicationList.fromJson(j);
        print(str);
        return loginResp;
      } else {
        return null;
      }
    } else {
      print(response.statusCode.toString());
    }
  }


}