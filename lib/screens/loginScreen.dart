import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letsdo/screens/HomeScreen.dart';
import 'package:letsdo/screens/createAccountScreen.dart';
import 'package:letsdo/widgets/InputFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  loginAccount(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uName = prefs.getString('uName');
    String pass = prefs.getString('pass');
    await prefs.setBool('log', true);

    if (userNameController.text != '' &&
        passwordController.text != '' &&
        uName == userNameController.text &&
        pass == passwordController.text) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      print(prefs.getString('uName'));
    } else {
      return Fluttertoast.showToast(
          msg: "UserName or Password Wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Let's Do",
                style: GoogleFonts.dancingScript(
                  fontSize: 50.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Login",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              InputFromField(
                tController: userNameController,
                hintText: 'User Name',
                fIcon: Icons.person,
              ),
              InputFromField(
                tController: passwordController,
                isPass: true,
                hintText: 'Password',
                fIcon: Icons.lock,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(''),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateAccountScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  loginAccount(context);
                },
                child: Container(
                  height: 40.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
