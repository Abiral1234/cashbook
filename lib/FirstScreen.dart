import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/HomePage.dart';
import 'package:project2/ITSupport.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NavigatePage();
  }

  NavigatePage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    if (access_token != null) {
      Get.offAll(HomePage());
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
                    Get.to(LoginPage());
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Center(
                    child: Text(
                  "Cash Book \n (Buku kas)",
                  style: TextStyle(fontSize: 40),
                )),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Free untuk kas Mesjid/keagamaan",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ITSupport());
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Wa IT support",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
