import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../constants.dart';
import '../login/login.dart';

class CustomSideMenu extends StatefulWidget {
  const CustomSideMenu({
    super.key,
    required this.globalKey,
  });
  final GlobalKey<ScaffoldState> globalKey;
  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<CustomSideMenu> {
  String name = "";
  String email = "x";

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      name = prefs.getString('name') ?? '';
      email = prefs.getString('username') ?? '';
    });

    return prefs.getString('name') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
      child: Center(
        child: Column(children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: const BoxDecoration(
                color: Constants.themeBlue,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Image.asset('assets/images/profile.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    name,
                    style: GoogleFonts.rubik(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Constants.themeYellow,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    email,
                    style: GoogleFonts.rubik(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
          // ListTile(
          //   onTap: () => {
          //     widget.globalKey.currentState!.closeEndDrawer(),
          //     // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     //     builder: (ctx) => const PersonalInfoScreen()))
          //   },
          //   title: Row(
          //     children: [
          //       Image.asset('assets/images/IconProfile.png'),
          //       const Padding(
          //         padding: EdgeInsets.only(left: 8.0),
          //         child: Text(
          //           'Personal info',
          //           style: TextStyle(
          //               fontFamily: 'brandon grotesque',
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //               color: Constants.themeRed),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // const Text('-------------------------'),
          // ListTile(
          //   onTap: () => {
          //     widget.globalKey.currentState!.closeEndDrawer(),
          //     // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     //     builder: (ctx) => const ChangePasswordScreen()))
          //   },
          //   title: Row(
          //     children: [
          //       Image.asset('assets/images/changepassword.png'),
          //       const Padding(
          //         padding: EdgeInsets.only(left: 8.0),
          //         child: Text(
          //           'Change Password',
          //           style: TextStyle(
          //               fontFamily: 'brandon grotesque',
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //               color: Constants.themeBlue),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // const Text('-------------------------'),
          // ListTile(
          //   onTap: () => {
          //     widget.globalKey.currentState!.closeEndDrawer(),
          //     // Navigator.pushReplacement(context,
          //     //     MaterialPageRoute(builder: (context) => MyHomePage()))
          //   },
          //   title: Row(
          //     children: [
          //       Image.asset('assets/images/planDetails.png'),
          //       const Padding(
          //         padding: EdgeInsets.only(left: 8.0),
          //         child: Text(
          //           'Plan Details',
          //           style: TextStyle(
          //               fontFamily: 'brandon grotesque',
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //               color: Constants.themeBlue),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // const Text('-------------------------'),
          // ListTile(
          //   onTap: () => {
          //     widget.globalKey.currentState!.closeEndDrawer(),
          //     // Navigator.of(context).pushReplacement(
          //     //     MaterialPageRoute(builder: (ctx) => const InvoiceScreen()))
          //   },
          //   title: Row(
          //     children: [
          //       Image.asset('assets/images/bill.png'),
          //       const Padding(
          //         padding: EdgeInsets.only(left: 8.0),
          //         child: Text(
          //           'Bill Details',
          //           style: TextStyle(
          //               fontFamily: 'brandon grotesque',
          //               fontWeight: FontWeight.w500,
          //               fontSize: 14,
          //               color: Constants.themeBlue),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // const Text('-------------------------'),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextButton(
                onPressed: () {
                  removeUserData();
                  
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LogIn()));
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Constants.themeRed,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'Log Out',
                    style:
                        TextStyle(fontSize: 16, color: Constants.themeYellow),
                  ),
                )),
          ),
          const Spacer()
        ]),
      ),
    );
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  removeUserData() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('token');
    prefs.remove('userId');
    prefs.remove('username');
    prefs.remove('name');
  }
}
