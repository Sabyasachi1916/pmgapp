import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pmgapp/utilities/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../login/login.dart';
import 'forgotpass_model.dart';
import 'forgotpassword_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController userIDCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  bool isLoading = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool userLoggedIn = false;  
  GetPasswordResetLinkResp resp =  GetPasswordResetLinkResp(message: '');
  bool showResp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(alignment: AlignmentDirectional.center, children: [
        Container(
          child: SingleChildScrollView(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 60),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(Images.BEE, height: 70,),
                        padding: const EdgeInsets.all(10),
    
                      ),
                     // SizedBox(height: 50,)
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Constants.mainTheme,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: [
                          Text('FORGOT PASSWORD', style:  GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            searchCtrl: userIDCon,
                            hint: "Enter email",
                            type: TextInputType.emailAddress,
                            obscureText: false,
                          ),
                          
                          const SizedBox(
                            height: 20,
                          ),
                         
                          CustomButton(
                            method: () => {
                              if (userIDCon.text.isValidEmail())
                                {
                                  setState(() => {isLoading = true}),
                                  ForgotPassword_Service()
                                      .submitEmail(userIDCon.text)
                                      .then((value) => {
                                            
                                            if (value != null){
                                              setState(() => {isLoading = false, resp = value, showResp = true}),
                                            },
                                            setState(() => {isLoading = false}),
                                          })
                                }
                              else
                                {
                                  alert(context, "Invalid email",
                                      "Please enter a valid email"),
                                }
                            },
                            title: 'SUBMIT',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Go back to',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LogIn()));
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.yellow,
                                        decoration: TextDecoration.underline),
                                  ))
                            ],
                          ),
                           const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have a z1Wireless ID?',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              
                            ],
                          ),
                          const Spacer(),
                          const Text(
                            '© 2023 z1Wireless | All Rights Reserved',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (isLoading == true) LoadingView(),
         if (showResp == true) Container(
        decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5)
              ),
          child: Center(
           
            child: Container(
              height: MediaQuery.of(context).size.width* 0.6,
              width: MediaQuery.of(context).size.width* 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    Text(resp.message, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'rubik', color: Colors.black),),
                    CustomButton(
                            method: () => {
                              setState(() => {
                                showResp = false
                              },)
                            },
                            title: 'OK',
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]
      )
    );
  }
}
 AlertDialog alert(BuildContext context, String title, String description) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
