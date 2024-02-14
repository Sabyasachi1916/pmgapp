import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmgapp/constants.dart';
import 'package:pmgapp/src/doctors/activities/activity_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadService {
  saveImageTogallery(base64Data) async {
    Uint8List bytes = base64.decode(base64Data);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> submitSubscription(
      {required Map<String, dynamic> body,
      required String url,
      required File file,
      required String filename}) async {
    ///MultiPart request
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString('token');

    var headers = {
      //"Authorization":"Bearer $token",
      "Content-Type": "multipart/form-data",
      'Authorization': 'Bearer $token'
    };
    Directory directory = await getApplicationDocumentsDirectory();
    var filePath = join(directory.path, filename);
    var request1 = http.MultipartRequest('POST', Uri.parse(url));
    request1.files.add(
      http.MultipartFile(
        'file',
        file.readAsBytes().asStream(),
        await file.length(),
        filename: filename,
        contentType: MediaType('document', 'pdf'),
      ),
    );
    request1.headers.addAll(headers);

    http.StreamedResponse response = await request1.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    return response.statusCode;
  }

  Future<String> uploadCustomerDocuments(
      {required List<File> files,
      required String filename,
      required String recordID}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://unitedapi.octdaily.com/api/Upload/wound'),
    );
    print(url);
    //https://dailytel.collegeparkbt.com
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      'Authorization': 'Bearer $token'
    };

    for (File file in files) {
      request.files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          await file.length(),
          filename: filename,
          contentType: MediaType('image', 'png'),
        ),
      );
    }
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();

    var str = await res.stream.bytesToString();
    final j = json.decode(str);
    print("This is response: " + j["files"][0]["Value"].toString());

    return j["files"][0]["Value"].toString();
  }

  Future<ActivityListModel?> saveImage(id, imageUrl, index) async {
    print(id);
    print(imageUrl);
    print(index);
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var bearerToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $bearerToken',
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var url = Uri.parse(ApiRequest.BASE_URL + '/api/Apsnote/ApsWoundImageSave');
    var request = http.Request('POST', url);
    request.body =
        json.encode({"images": [imageUrl], "leadNumber": id, "woundIndex": index});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      final j = json.decode(str);
      print(str);
      if (j["message"] == null) {
        final loginResp = ActivityListModel.fromJson(j);
        print(str);

        return loginResp;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
