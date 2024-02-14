import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pmgapp/login/login.dart';
import 'package:pmgapp/src/doctors/activities/activities.dart';
import 'package:pmgapp/src/doctors/home/dateProvider.dart';
import 'package:pmgapp/src/doctors/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pmgapp/src/doctors/info_list/info_type_list.dart';
import 'package:provider/provider.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   print('User granted permission');
  // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //   print('User granted provisional permission');
  // } else {
  //   print('User declined or has not accepted permission');
  // }
  // messaging.requestPermission();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context)=>DateProvider())],
      child: MaterialApp(
        title: 'PMG',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  LogIn(),
      ),
    );
  }
}

