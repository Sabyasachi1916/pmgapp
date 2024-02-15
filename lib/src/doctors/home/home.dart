import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:pmgapp/constants.dart';
import 'package:pmgapp/map/map.dart';
import 'package:pmgapp/src/doctors/home/Calendar.dart';
import 'package:pmgapp/src/doctors/home/dateProvider.dart';
import 'package:pmgapp/src/doctors/home/home_model.dart';
import 'package:pmgapp/src/doctors/home/home_service.dart';
import 'package:pmgapp/src/doctors/info_list/info_type_list.dart';
import 'package:pmgapp/src/doctors/patientInfo/patient_info.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../customsidemenu.dart';
import 'package:table_calendar/table_calendar.dart';

class Doctor_Home_Srceen extends StatefulWidget {
  const Doctor_Home_Srceen({super.key});

  @override
  State<Doctor_Home_Srceen> createState() => _Doctor_Home_SrceenState();
}

class _Doctor_Home_SrceenState extends State<Doctor_Home_Srceen> {
  late LocationSettings locationSettings;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Timer timer;
  var selected = 0;
  DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<DateTime> getWeekDays(DateTime selectedDate) {
  
    print('New selected date2 $selectedDate');
    List<DateTime> dateArray = [];
    for (var i = 0; i < 7; i++) {
      dateArray.add(getDate(
          selectedDate.subtract(Duration(days: selectedDate.weekday - i))));
    }
    
    return dateArray;
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  var dateArr = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  Widget getWeeklyCalendar(List<DateTime> dateArray, DateTime selectedDate) {
    List<Widget> list = [];

    for (var i = 0; i < dateArray.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          width: 40,
          height: 60,
          decoration: BoxDecoration(
              color: dateArray[i] == getDate(today)
                  ? const Color.fromARGB(255, 0, 128, 0)
                  : const Color.fromARGB(255, 4, 104, 105),
              borderRadius: BorderRadius.circular(25)),
          child: InkWell(
            onTap: () {
              setState(
                () {
                 // selectedDate = dateArray[i];
                  today = dateArray[i];
                },
              );
              Provider.of<DateProvider>(context, listen: false).getData(dateArray[i]);
              
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(dateArr[i],
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                ),
                Text(
                  '${dateArray[i].day}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: list,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ));
  }

  
  bool isLoading = false;
  final DateFormat formatter = DateFormat('MM-dd-yyyy hh:mm a');
  Widget showTaskList(DateProvider dateProviderModel) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.75,
        color: Constants.mainTheme,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: dateProviderModel.followUpList?.list.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
                child: Card(
                  color: Constants.appTheme,
                  child: InkWell(
                    onTap: () async {
                      final SharedPreferences prefs = await _prefs;
                      prefs.setString('PatientID',
                          dateProviderModel.followUpList?.list[index].patientId.toString() ?? "");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoTypeList(
                                user: dateProviderModel.followUpList?.list[index] ??
                                    null)), //PatientInfoScreen(leadNumber: followUpList?.list[index].leadNumber ?? "")
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Patient ID -${dateProviderModel.followUpList?.list[index].patientId != "" ? dateProviderModel.followUpList?.list[index].patientId.toString() ?? "" : ""}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            dateProviderModel.followUpList?.list[index].notes ?? "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ), //'Entry ${entries[index]}'
                ));
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Constants.mainTheme,
          ),
        ));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error: $error");
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    // setUpLocationUpdate();
    //getToken();
    timer = Timer.periodic(Duration(seconds: 60), (Timer t) {
      getCurrentLocation().then(
        (value) {
          homeService().saveLocation(
              value.latitude.toString(), value.longitude.toString());
        },
      );
    });
   Provider.of<DateProvider>(context, listen: false).getData(today);
  }

  

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // getToken() async {
  //   messaging.getToken().then((value) => {
  //         print('Device token - ${value.toString()}'),
  //         homeService().saveDeviceToken(value.toString())
  //       });
  // }

  setUpLocationUpdate() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          //(Optional) Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "POW app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
      if (position != null) {
        homeService().saveLocation(
            position.latitude.toString(), position.longitude.toString());
      }
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
      appBar: appbar(scaffoldKey: _scaffoldKey),
      body: SafeArea(
        child: Consumer<DateProvider>(
          builder: (BuildContext context, DateProvider dateProviderModel,
                  Widget? child) =>
              Stack(children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getWeeklyCalendar(
                        getWeekDays(dateProviderModel.selectedDate), dateProviderModel.selectedDate),
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      child: Text('Select other date'),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Calendar()),
                      ),
                    ),
                    (dateProviderModel.followUpList?.list != null &&
                            dateProviderModel.followUpList!.list.isNotEmpty)
                        ? showTaskList(dateProviderModel)
                        : Center(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text("No data available for now."),
                          )),
                  ],
                ),
              ),
            ),
            if (isLoading == true)
              Center(child: Container(child: CircularProgressIndicator()))
          ]),
        ),
      ),
    );
  }
}

class appbar extends StatelessWidget implements PreferredSizeWidget {
  final scaffoldKey;
  appbar({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Constants.appTheme,
      title: Image.asset(
        Images.Z1TEXT_WHITE,
        height: 30,
      ),
      centerTitle: false,
      actions: [
        TextButton(
            onPressed: () {},
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            )),
        InkWell(
          onTap: () => scaffoldKey.currentState?.openEndDrawer(),
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover)),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
