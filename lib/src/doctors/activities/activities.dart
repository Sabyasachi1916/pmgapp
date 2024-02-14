import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmgapp/constants.dart';
import 'package:pmgapp/customsidemenu.dart';
import 'package:pmgapp/login/login.dart';
import 'package:pmgapp/src/doctors/activities/activity_service.dart';
import 'package:pmgapp/src/doctors/home/home.dart';

import 'activity_model.dart';

class Activities extends StatefulWidget {
  final String leadNumber;

  const Activities({super.key, required this.leadNumber});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<Activity> activitylist = [];
  final DateFormat formatter = DateFormat('MM-dd-yyyy HH:mm');
  var page = 0;
  var receivedAll = false;
  @override
  void initState() {
    super.initState();
    setState(
      () {
        isLoading = true;
      },
      
    );
    getData();
  }

  void getData() {
    ActivityService().getActivityList(widget.leadNumber, page).then((value) => {
          setState(() {
            if ((value?.list.length ?? 0) > 0) {
              activitylist.addAll(value?.list ?? []);
            } else {
              receivedAll = true;
            }
            isLoading = false;
          })
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
                    itemCount: activitylist.length,
                    itemBuilder: (context, index) {
                      if (index == (activitylist.length - 1)) {
                        if (receivedAll == false) {
                          page = page + 10;
                          getData();
                        }
                      }
                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.red),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.person),
                                  Text(
                                    activitylist?[index].username ?? "",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                      formatter.format(
                                          activitylist![index].createdOn),
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    activitylist?[index].description ?? ""),
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
