import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_forum_app/home_page.dart';
import 'dart:convert';

import 'package:simple_forum_app/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State createState() =>  RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final host = "http://127.0.0.1:8000";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body:  Stack(fit: StackFit.expand, children: <Widget>[
         Theme(
          data:  ThemeData(
              inputDecorationTheme:  InputDecorationTheme(
            labelStyle:  TextStyle(color: Colors.blue, fontSize: 25.0),
          )),
          isMaterialAppTheme: true,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Container(
                padding: const EdgeInsets.all(40.0),
                child:  Form(
                  autovalidate: true,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                       TextFormField(
                        decoration:  InputDecoration(
                            labelText: "Enter Username",
                            fillColor: Colors.white),
                        keyboardType: TextInputType.text,
                        controller: usernameController,
                      ),
                       TextFormField(
                        decoration:  InputDecoration(
                          labelText: "Enter Password",
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                      ),
                       Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                      ),
                       MaterialButton(
                        height: 50.0,
                        minWidth: 150.0,
                        color: Colors.blue,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
                        child: Text("Register"),
                        onPressed: () {
                          try {
                          String username = usernameController.text;
                          String password = passwordController.text;
                          if (username != "" && password != "") {
                            http.post(host + "/api/register",
                                body: json.encode({
                                  "username": username,
                                  "password": password
                                }));
                            // 2do: Send user info to login page
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                          }} catch (Exception) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()), (Route<dynamic> route) => false);
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
