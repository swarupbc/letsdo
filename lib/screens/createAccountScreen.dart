import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letsdo/screens/loginScreen.dart';
import 'package:letsdo/widgets/InputFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';

//For Unit Testing

class UsernameValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Username can\'t be empty' : null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}
//For Unit Testing

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController cPasswordController = TextEditingController();
  String _uName;
  String _password;

  createAccount(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uName', userNameController.text.trim());
    await prefs.setString('pass', passwordController.text.trim());

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    print(prefs.getString('uName'));
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
                "Create Account",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              InputFromField(
                valid: UsernameValidator.validate,
                saved: (value) => _uName = value,
                tController: userNameController,
                hintText: 'User Name',
                fIcon: Icons.person,
              ),
              InputFromField(
                valid: PasswordValidator.validate,
                saved: (value) => _password = value,
                tController: passwordController,
                hintText: 'Password',
                fIcon: Icons.lock,
                isPass: true,
              ),
              InputFromField(
                tController: cPasswordController,
                isPass: true,
                hintText: 'Confirm Password',
                fIcon: Icons.lock_clock,
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
                                  LoginScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          'Login to Existing Account',
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
                  if (userNameController.text != '' &&
                      passwordController.text != '' &&
                      passwordController.text.trim() ==
                          cPasswordController.text.trim()) {
                    createAccount(context);
                  } else {
                    return Fluttertoast.showToast(
                        msg: "Password Does Not Match",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Container(
                  height: 40.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: Text(
                      'Create',
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
