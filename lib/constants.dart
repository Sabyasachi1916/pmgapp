import 'package:flutter/material.dart';

class Constants {
  static const themeBlue = Color(0xff335CA2);
  static const themeRed = Color(0xffE92F57);
  static const themeYellow = Color(0xffFFD82E);
  static const mainTheme = Color.fromARGB(255, 239, 243, 247);
  static const appTheme = Color.fromARGB(255, 255, 255, 255);
  static const textColor = Color.fromARGB(255, 23, 38, 67);
  static var background = const LinearGradient(
          colors: [Color(0xff2b83c5), Color(0xffffffff)],
          stops: [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
  static var textFieldBackground = const LinearGradient(
          colors: [Color(0xff2b83c5), Color(0xffffffff)],
          stops: [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
  static var buttonGradient = const LinearGradient(
          colors: [Color(0xff016ec8), Color(0xff5ac3fd)],
          stops: [0, 1],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
}

class Images {
  static var BEE = './assets/images/logo_2.png';
  static var Z1TEXT = 'assets/images/z1Wireless.png';
  static var Z1TEXT_WHITE = './assets/images/united.png';
  static var MENU = 'assets/images/menu.png';
  static var TITLE_LOGO = 'assets/images/logo_2.png';
  static var BG = 'assets/images/bg.png';
}

class ApiRequest {
  //BASE
  static var BASE_URL = 'https://pmg.octdaily.com/api';
  //static var BASE_URL = 'https://atlas.unitedapi.octdaily.com/api'; //Production

  //ENDPOINTS
  static var LOGIN_ENDPIONT = '/api/token';
  static var PERSONALINFO_ENDPIONT = '/api/user/get/';
  static var SALE_INFO_ENDPIONT = '/api/Sale/info';
  static var CHNGE_PASSWORD_ENDPOINT = '/api/user/changepassword';
  static var FORGOT_PASSWORD_ENDPOINT = '/api/User/GetPasswordResetLink';
  static var SAVE_DEVICE_TOKEN = '/api/Firebase/device/register';
   static var REMOVE_DEVICE_TOKEN = '/api/Firebase/device/unregister';
   
      
}
