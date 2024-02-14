import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmgapp/constants.dart';
import 'package:pmgapp/customsidemenu.dart';
import 'package:pmgapp/login/login.dart';
import 'package:pmgapp/src/doctors/communication/communication_model.dart';
import 'package:pmgapp/src/doctors/communication/communication_service.dart';
import 'package:pmgapp/src/doctors/home/home.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Communication extends StatefulWidget {
  final String leadNumber;


  const Communication({super.key, required this.leadNumber});

  @override
  State<Communication> createState() => _CommunicationState();
}

class _CommunicationState extends State<Communication> {

   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<CommunicationListElement>? activitylist;
  final DateFormat formatter = DateFormat('MM-dd-yyyy HH:mm');

  @override
  void initState() {
    super.initState();
    setState(
      () {
        isLoading = true;
      },
    );
    Communication_service().getCommunication(widget.leadNumber).then((value) => {
          setState((){
            isLoading = false;
            activitylist = value?.list;
          } )
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomSideMenu(
        globalKey: _scaffoldKey,
      ),
      backgroundColor: Constants.mainTheme,
      // appBar: appbar(),
      body: SafeArea(
        child: Stack(children: [
          
               
                  (activitylist != null)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: activitylist?.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                           Container(width: 30, height: 30, child: Icon(Icons.person), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15), ),),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width *0.75,
                                              child: HtmlWidget( activitylist?[index].messageContent ?? ""
                                               
                                                
                                              ),
                                            ),
                                          ),
                                          
                                          
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon( activitylist?[index].messageType == "Email" ? Icons.mail : Icons.message),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                formatter.format(
                                                    activitylist![index]
                                                        .sentOn),
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey)),
                                          )
                                        ],
                                      ) 
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Text("No data available for now."),
                        )),
                
            
         
          if (isLoading == true) LoadingView(),
        ]),
      ),
    );
  }
}