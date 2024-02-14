import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pmgapp/constants.dart';
import 'package:pmgapp/src/doctors/acpnote/note-screen.dart';
import 'package:pmgapp/src/doctors/activities/activities.dart';
import 'package:pmgapp/src/doctors/communication/communication.dart';
import 'package:pmgapp/src/doctors/documents/documents_screen.dart';
import 'package:pmgapp/src/doctors/home/home.dart';
import 'package:pmgapp/src/doctors/home/home_model.dart';
import 'package:pmgapp/src/doctors/patientInfo/patient_info.dart';

class InfoTypeList extends StatefulWidget {
  const InfoTypeList({super.key, required this.user});
  final ListElement? user;

  @override
  State<InfoTypeList> createState() => _InfoTypeListState();
}

class _InfoTypeListState extends State<InfoTypeList> {
  var tag = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.mainTheme,
        appBar: appbar(),
        body: SafeArea(
            child: Stack(alignment: Alignment.bottomRight, children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child:  PatientInfoScreen(leadNumber: widget.user?.patientId.toString() ?? "")
              // Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //       Container(
              //         height: 60,
              //         child: SingleChildScrollView(
                        
              //             child: Row(
              //               children: [
              //                 TopTabButton(
              //                   title: 'Patient Information',
              //                   isSelected: tag==0, 
              //                   onSelect: () {  setState(() {
              //                     tag = 0;
              //                   });},
              //                 ),
              //                 TopTabButton(
              //                   title: 'APS Notes',
              //                   isSelected: tag==1,
              //                   onSelect: () {  setState(() {
              //                     tag = 1;
              //                   });},
              //                 ),
              //                 TopTabButton(
              //                   title: 'Communication',
              //                   isSelected: tag==2,
              //                   onSelect: () {  setState(() {
              //                     tag = 2;
              //                   });},
              //                 ),
              //                 TopTabButton(
              //                   title: 'Activities',
              //                   isSelected: tag==3,
              //                   onSelect: () {  setState(() {
              //                     tag = 3;
              //                   });},
              //                 ),
              //                 TopTabButton(
              //                   title: 'Documents',
              //                   isSelected: tag==4,
              //                   onSelect: () {  setState(() {
              //                     tag = 4;
              //                   });},
              //                 ),
                              
              //               ],
              //             ),
              //             scrollDirection: Axis.horizontal),
              //       ),
              //     ])),
              //    if(tag == 0) Container( height: 630, child: 
              //      PatientInfoScreen(leadNumber: widget.user?.patientId.toString() ?? "")) ,
              //      if(tag == 1) Container( height: 630, child: 
              //      ACPNoteScreen(leadNumber:  widget.user?.patientId.toString() ?? "",)),
              //      if(tag == 2) Container( height: 630, child: 
              //      Communication(leadNumber: widget.user?.patientId.toString() ?? "")),
              //      if(tag == 3) Container( height: 630, child: 
              //      Activities(leadNumber: widget.user?.patientId.toString() ?? "")),
              //      if(tag == 4) Container( height: 630, child: 
              //      DocumentsScreen(leadNumber: widget.user?.patientId.toString() ?? "")
              // 
              )
                  
         ])
        )
        );
  }
}

class TopTabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onSelect;
  const TopTabButton({
    super.key,
    required this.title,
    required this.isSelected, 
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onSelect,
        child: Container(
          decoration: BoxDecoration(
              color: isSelected ? Colors.teal : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(5, 5),
                    blurRadius: 5)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.black),),
          ),
        ));
  }
}
