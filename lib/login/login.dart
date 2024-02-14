import 'package:flutter/material.dart';
import 'package:pmgapp/forgotpassword/forgotpassword_screen.dart';
import 'package:pmgapp/src/doctors/home/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../utilities/Utilities.dart';
import 'login_service.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController userIDCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  bool isLoading = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool userLoggedIn = false;
  bool isChecked = false;
  bool shouldShowOTPPopup = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserData().getUserData().then((value) => {
          if (value != null)
            {
              // UserData().getUserRole().then((role) => {
              //   if (role != null && role != 'Field Agent' && role != ''){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => Doctor_Home_Srceen()))
              // }else{
              //   Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(builder: (ctx) => Doctor_Home_Srceen()))
              // }
              // }
              // )
            }
        });

    UserData().getLoginUserID().then((value) => {
          setState(() {
            userIDCon.text = value ?? '';
          })
        });
    UserData().getLoginPassword().then((value) => {
          setState(() {
            passCon.text = value ?? '';
          })
        });
    UserData().getIsRememberMe().then((value) => {
          setState(() {
            isChecked = value ?? false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(alignment: AlignmentDirectional.center, children: [
      Image.asset(
        height: MediaQuery.of(context).size.height,
                Images.BG, fit: BoxFit.fitHeight,
             
      ),
      Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(71, 216, 219, 222),
              borderRadius: BorderRadius.all(
                   Radius.circular(40))),
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child:  Column(
                        children: [
                          Image.asset(
                            Images.Z1TEXT_WHITE,
                            height: 40,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            searchCtrl: userIDCon,
                            hint: "Enter email",
                            type: TextInputType.emailAddress,
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            searchCtrl: passCon,
                            hint: "Password",
                            type: TextInputType.emailAddress,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.black,
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Text(
                                'Remember me',
                                style: TextStyle(color: Colors.black),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordScreen()))
                                      },
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'brandon_grotesquemedium',
                                        color: Colors.white),
                                  ))
                            ],
                          ),
                          CustomButton(
                            method: () => {
                              // if (userIDCon.text.isValidEmail())
                              //   {
                                  setState(() => {isLoading = true}),
                                  LoginService()
                                      .getTokenWith(userIDCon.text,
                                          passCon.text, isChecked)
                                      .then((value) => {
                                            setState(() => {isLoading = false}),
                                            if (value != null)
                                              {
                                                //shouldShowOTPPopup = true
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Doctor_Home_Srceen()))
                                              }
                                          })
                                },
                            //   else
                            //     {
                            //       alert(context, "Invalid email",
                            //           "Please enter a valid email"),
                            //     }
                            // },
                            title: 'LOGIN',
                          ),
                          const Spacer(),
                          const Text(
                            '© 2023 United Wounds | All Rights Reserved',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              
      if (isLoading == true) LoadingView(),
      if (shouldShowOTPPopup == true)
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 10)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OTP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Divider(),
                SizedBox(
                  height: 30,
                ),
                Text('Enter the OTP we have sent to your email'),
                Container(
                  child: OTPTextField(
                    length: 5,
                    width: MediaQuery.of(context).size.width * 0.8,
                    fieldWidth: 40,
                    style: TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    },
                    onChanged: (value) {
                      print("value changed: " + value);
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      method: () => {
                        setState(
                          () {
                            shouldShowOTPPopup = false;
                          },
                        )
                      },
                      title: 'Cancel',
                    ),
                    CustomButton(
                      method: () => {
                        setState(
                          () {
                            shouldShowOTPPopup = false;
                          },
                        )
                      },
                      title: 'Done',
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    ])));
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
}

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.black38),
      child: Center(
        child: AlertDialog(
          content: Row(children: [
            const CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Loading...")),
          ]),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.method,
    required this.title,
  });

  final Function() method;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: method,
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(35, 183, 184, 1),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20, top: 8, bottom: 8),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ));
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.searchCtrl,
    required this.hint,
    required this.type,
    required this.obscureText,
  });

  final TextEditingController searchCtrl;
  final String hint;
  final TextInputType type;
  final bool obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      //shadowColor: Colors.black,
      elevation: 2.0,
      child: TextField(
        textAlign: TextAlign.left,
        controller: widget.searchCtrl,
        keyboardType: widget.type,
        decoration: InputDecoration(
          //border: OutlineInputBorder(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            // borderSide: const BorderSide(color: Colors.grey, width: 1.0)
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[600]),
          hintText: widget.hint,
          fillColor: Colors.white,
          suffixIcon: widget.obscureText == true
              ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    !_passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
        ),
        obscureText: _passwordVisible,
        enableSuggestions: false,
        autocorrect: false,
      ),
    );
  }
}
