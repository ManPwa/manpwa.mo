import 'dart:ui';

import 'package:date_field/date_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/requests/user_api.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = 'auth/register';
  static const routePath = 'register';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 250,
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                alignment: Alignment.center,
              ),
            ),
          ),
          SignupPageContent(),
        ],
      ),
    );
  }
}

class SignupPageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupPageContent();
}

class _SignupPageContent extends State<SignupPageContent> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  late String dateOfBirth;
  bool gender = true;
  bool _isVisible = false;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  String returnVisibilityString = "";

  bool returnVisibility(
      String password1, String password2, String username, String email) {
    if (password1 != password2) {
      returnVisibilityString = "Passwords do not match!";
    } else if (username == "") {
      returnVisibilityString = "Username cannot be empty!";
    } else if (email == "") {
      returnVisibilityString = "Email cannot be empty!";
    } else if (password1 == "" || password2 == "") {
      returnVisibilityString = "Password fields cant be empty!";
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Sized Box
          SizedBox(
            height: 100,
            width: 400,
          ),

          // Signup Text
          Center(
            child: Container(
              height: 100,
              width: 400,
              alignment: Alignment.center,
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Wrong password text
          Visibility(
            visible: _isVisible,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: Text(
                returnVisibilityString,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          ),

          // Signup Info
          Container(
            height: 490,
            width: 530,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                TextFormField(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                  style: TextStyle(fontSize: 14),
                  controller: usernameController, // Controller for Username
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Username",
                      contentPadding: EdgeInsets.all(20),
                      hintStyle: TextStyle(fontSize: 14)),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
                Divider(
                  thickness: 3,
                ),
                TextFormField(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                  style: TextStyle(fontSize: 14),
                  controller: emailController, // Controller for Username
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      contentPadding: EdgeInsets.all(20),
                      hintStyle: TextStyle(fontSize: 14)),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
                Divider(
                  thickness: 3,
                ),
                SizedBox(
                  height: 68,
                  child: Row(children: [
                    Radio(
                      value: true,
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text(
                      "Male",
                      style: TextStyle(fontSize: 14),
                    ),
                    Radio(
                      value: false,
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text(
                      "Female",
                      style: TextStyle(fontSize: 14),
                    ),
                  ]),
                ),
                Divider(
                  thickness: 3,
                ),
                DateTimeFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Date of birth",
                      hintStyle: TextStyle(fontSize: 14),
                      contentPadding: EdgeInsets.all(20)
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  onDateSelected: (DateTime value) {
                    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
                    dateOfBirth = formatter.format(value);
                  },
                ),
                Divider(
                  thickness: 3,
                ),
                TextFormField(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                  style: TextStyle(fontSize: 14),
                  controller: passwordController1, // Controller for Password
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(20),
                      hintStyle: TextStyle(fontSize: 14),
                      // Adding the visibility icon to toggle visibility of the password field
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure1
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure1 = !_isObscure1;
                          });
                        },
                      )),
                  obscureText: _isObscure1,
                ),
                Divider(
                  thickness: 3,
                ),
                TextFormField(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                  style: TextStyle(fontSize: 14),
                  controller: passwordController2, // Controller for Password
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Re-enter Password",
                      contentPadding: EdgeInsets.all(20),
                      hintStyle: TextStyle(fontSize: 14),
                      // Adding the visibility icon to toggle visibility of the password field
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure2
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                        },
                      )),
                  obscureText: _isObscure2,
                ),
              ],
            ),
          ),

          // Signup Submit button
          Container(
            width: 570,
            height: 70,
            padding: EdgeInsets.only(top: 20),
            child: ElevatedButton(
                child: Text("Submit", style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  if (usernameController.text != "" &&
                      passwordController1.text == passwordController2.text &&
                      passwordController2.text != "" &&
                      emailController.text != "") {
                    setState(() {
                      _isVisible = false;
                    });
                    try {
                      final userApi = GetIt.I.get<UserApi>();
                      await userApi.register(
                          username: usernameController.text,
                          email: emailController.text,
                          password: passwordController1.text,
                          date_of_birth: dateOfBirth,
                          gender: gender);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "Register successfull",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color.fromARGB(166, 0, 0, 0),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } catch (e) {
                      setState(() {
                        returnVisibilityString = e.toString();
                        _isVisible = true;
                      });
                    }
                  } else {
                    setState(() {
                      _isVisible = returnVisibility(
                          passwordController1.text,
                          passwordController2.text,
                          usernameController.text,
                          emailController.text);
                    });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
