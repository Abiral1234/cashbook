import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'RegisterPage.dart';
import 'Widgets/DefaultTextField.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneno = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  bool hidePassword = true;
  bool incomplete = false;
  bool loading = false;
  bool success = false;
  bool failed = false;

  //////////////////////////////API TO VERIFY ADMIN\\\\\\\\\\\\\\\\\\\\\\
  ///

  login() async {
    //VALIDATION
    if (phoneno.text == "" || otp.text == "") {
      print("Incomplete");
      setState(() {
        incomplete = true;
      });
      print(incomplete);
    } else {
      // // Verification of admin
      var response;
      setState(() {
        loading = true;
      });
      print("Hello");
      try {
        var body = json.encode({
          "phone": phoneno.text,
          "otp": otp.text,
        });
        print(body);
        response = await http.post(
            Uri.parse("http://api4test.my.id:5000/api/v1/login"),
            headers: {
              'accept': 'application/json',
              'Content-Type': 'application/json'
            },
            body: body);
        print("Your response status code is");
        print(response.statusCode);

        if (response.statusCode == 200) {
          print("User Verified ");
          var data = jsonDecode(response.body.toString());
          print(data);
          setState(() {
            success = true;
            failed = false;
            incomplete = false;
          });
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setString('userid', data['idcounter'].toString());
          prefs.setString('access_token', data['access_token']);
          prefs.setString('phone', phoneno.text);
          String? phone = prefs.getString('phone');
          String? access_token = prefs.getString('access_token');
          print("The user access_token is");
          print(access_token);
          print("The user phone is");
          print(phone);
          Get.offAll(HomePage());
        } else {
          setState(() {
            failed = true;
            success = false;
            incomplete = false;
            loading = false;
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(RegisterPage());
                  },
                  child: Text(
                    "register",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("no. phone"),
                        DefaultTextField("phone", phoneno),
                        Text("otp"),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: otp,
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                hintText: "otp",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text("send otp")),
                        incomplete == true
                            ? Text(
                                "Incomplete",
                                style: TextStyle(color: Colors.red),
                              )
                            : Container(),
                        success == true
                            ? Text(
                                "Login Successfull",
                                style: TextStyle(color: Colors.green),
                              )
                            : Container(),
                        failed == true
                            ? Text(
                                "Login failed",
                                style: TextStyle(color: Colors.red),
                              )
                            : Container(),
                        Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  login();
                                },
                                child: Text("login"))),
                      ]),
                ),
                Text("Wa IT support")
              ]),
        ),
      ),
    );
  }
}
