import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isphoneNumberValid() {
    RegExp regex = RegExp( r'^(?:[+0]9)?[0-9]{10}$');
    if (!regex.hasMatch(this))
      return false;
    else
      return true;
  }
}


class UserData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> getUserData() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('token');
  }

  Future<int?> getUserID() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('userId');
  }
  Future<String?> getUserRole() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('role');
  }

  Future<String?> getUserName() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('username');
  }

  Future<String?> getUserFullName() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('name');
  }

  Future<String?> getLoginUserID() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('loginUser');
  }

  Future<String?> getLoginPassword() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('password');
  }

  Future<bool?> getIsRememberMe() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('rememberme');
  }

  
}



