import 'package:flutter/material.dart';
import 'package:letsdo/screens/HomeScreen.dart';
import 'package:letsdo/screens/createAccountScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends StatefulWidget {
  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('log') == true) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CreateAccountScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
