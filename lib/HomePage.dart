import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/CashInPage.dart';
import 'package:project2/CashMovement.dart';
import 'package:project2/LoginPage.dart';
import 'package:project2/Receipt.dart';
import 'package:project2/TransferBetweenCash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CashOutPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Buku Kas\nPT. AI Ikhlas",
                  style: TextStyle(fontSize: 30),
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

// Remove the preference with the key 'myPreferenceKey'
                    prefs.remove('access_token');
                    Get.offAll(LoginPage());
                  },
                  child: Text(
                    "logout",
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.to(CashInPage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "kiwitansi\nmasuk\nkas",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          )),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(CashOutPage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "kiwitansi\nKeluar\nkas",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          )),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(TransferBetweenCash());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Transfer\nantarkas\n",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          )),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.to(CashMovement());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Laporan\nMutasi\nkas",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          )),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(Receipt());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Resume\nSaldo\nkas",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          )),
                        )),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
