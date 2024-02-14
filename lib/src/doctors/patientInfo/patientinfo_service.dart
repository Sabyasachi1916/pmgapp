import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmgapp/constants.dart';
import 'package:pmgapp/src/doctors/home/home_model.dart';
import 'package:pmgapp/src/doctors/patientInfo/patient_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PatientInfoService{
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    Future<PatientInfoResponse?> getPatientInfo(String leadNumber) async {
    var platform = '';
    if (Platform.isIOS) {
      print('is a IOS');
      platform = 'ios';
    } else if (Platform.isAndroid) {
      print('is a Andriod');
      platform = 'android';
    } else {
    }
    final SharedPreferences prefs = await _prefs;
    var bearerToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $bearerToken'};
    print(bearerToken);
    var url = Uri.parse(ApiRequest.BASE_URL + '/api/Patients/patientdetails/$leadNumber/0/20?isAsc=true'); //yyyy-MM-dd
    var request = http.Request('GET', url);
    
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j["message"] == null){
        final loginResp = PatientInfoResponse.fromJson(j);
        print(str);

        return loginResp;
      }else{
        
         return null;
      }
}

  }
    Future<StateList?> getStateList() async {
   
    final SharedPreferences prefs = await _prefs;
    var bearerToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $bearerToken'};
    var url = Uri.parse(ApiRequest.BASE_URL +'/api/State/State'); //yyyy-MM-dd
    var request = http.Request('GET', url);
    
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j["message"] == null){
        final loginResp = StateList.fromJson(j);
        print(str);

        return loginResp;
      }else{
        
         return null;
      }
}

  }

  Future<List<InsuranceList>?> getInsuranceList() async {
   
    final SharedPreferences prefs = await _prefs;
    var bearerToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $bearerToken'};
    var url = Uri.parse('https://atlas.unitedwounds.org/api/api/PatientInfo/InsurenceName');
    var request = http.Request('GET', url);
    
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j != null){
        final loginResp = insuranceListFromJson(str);
        print(str);

        return loginResp;
      }else{
        
         return null;
      }
}

  }

}

