import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pmgapp/constants.dart';
import 'package:pmgapp/login/login.dart';
import 'package:pmgapp/src/doctors/activities/activity_model.dart';
import 'package:pmgapp/upload/UploadService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class SnapshotPreview extends StatefulWidget {
  const SnapshotPreview({
    Key? key,
    required this.imageProvider,
  }) : super(key: key);

  final ImageProvider imageProvider;

  @override
  State<SnapshotPreview> createState() => _SnapshotPreviewState();
}

class _SnapshotPreviewState extends State<SnapshotPreview> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void upload() async {
    print(widget.imageProvider.runtimeType);
    if (widget.imageProvider.runtimeType == MemoryImage) {
      print("Its an asset!!!!");
      MemoryImage memoryImage = widget.imageProvider as MemoryImage;
      final tempDir = await getTemporaryDirectory();
      Uint8List imageInUnit8List = memoryImage.bytes;
      File file = await File("${tempDir.path}/${DateTime.now()}.png").create();
      file.writeAsBytesSync(imageInUnit8List);
      sendFile(file);
    } else if (widget.imageProvider.runtimeType == FileImage) {
      print("Its a file!!!!");
      FileImage fileImage = widget.imageProvider.runtimeType as FileImage;
      File file = fileImage.file;
      sendFile(file);
    }
  }

  sendFile(file) async {
    final SharedPreferences prefs = await _prefs;
    final leadNumber = prefs.getString('leadNumber');
    UploadService().uploadCustomerDocuments(files: [
      file
    ], filename: "wound", recordID: "recordID").then((value) => {
          print(value),
          UploadService()
              .saveImage(leadNumber, value, woundNumberCon.text ?? "1")
              .then((value2) => {
                    Navigator.pop(context),
                    setState(() {
                      isLoading = false;
                    }),
                  }),
        });
  }

  TextEditingController woundNumberCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image(image: widget.imageProvider),
                height: 600,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: CustomTextField(
                  searchCtrl: woundNumberCon,
                  hint: "Enter Wound Number",
                  type: TextInputType.number,
                  obscureText: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                method: () => {
                  FocusScope.of(context).requestFocus(FocusNode()),
                  setState(() {
                    isLoading = true;
                  }),
                  upload()
                },
                title: 'Upload',
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        if (isLoading == true) LoadingView()
      ]),
    );
  }
}
