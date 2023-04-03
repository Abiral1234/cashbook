import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/LoginPage.dart';
import 'package:project2/Widgets/DatePickerTextField.dart';
import 'package:project2/Widgets/DropDownWidget.dart';
import 'Widgets/DefaultTextField.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CashMovement extends StatefulWidget {
  const CashMovement({super.key});

  @override
  State<CashMovement> createState() => _CashMovementState();
}

class _CashMovementState extends State<CashMovement> {
  int _selectedValue = 0;
  int _selectedIndex = 0;
  TextEditingController ket = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController nominal = new TextEditingController();
  TextEditingController bca = new TextEditingController();
  TextEditingController date1 = new TextEditingController();
  TextEditingController date2 = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nama.text = "Tunai";
  }

  bool hidePassword = true;
  bool incomplete = false;
  bool loading = false;
  bool success = true;
  List requiredData = [];
  bool nodata = false;
  //////////////////////////////API TO VERIFY ADMIN\\\\\\\\\\\\\\\\\\\\\\

  getData() async {
    // // Verification of admin
    requiredData = [];
    var response;
    setState(() {
      loading = true;
    });
    print("Hello");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    print("The user access_token is");
    String? phone = prefs.getString('phone');
    print(access_token);
    try {
      // var body = json.encode({
      //   "id_receipt": no.text,
      //   "date_transaction": date.text,
      //   "cash_code": nama.text,
      //   "balance": jumlah.text,
      //   "explanation": kete.text,
      //   "from_to_name": dari.text
      // });
      // print(body);
      String body2 =
          //     "INSERT INTO tb_cashbook(id_receipt,date_transaction,cash_code,balance,explanation,from_to_name) VALUES ('1','2023/04/02','BNI','2200','transfer','abiral')";
          "select * from tb_cashbook Where id_user=$phone";

      response = await http.post(
          Uri.parse("http://api4test.my.id:5000/api/v1/opensql"),
          headers: {
            'authorization': 'Bearer $access_token',
            'accept': 'application/json',
            'Content-Type': 'text/plain'
          },
          body: body2);
      print("Your response status code is");
      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        print("Receipt accepted successfully");
        var data = jsonDecode(response.body.toString());
        bool isDateInRange(
            String startDateStr, String endDateStr, String dateToCheckStr) {
          // Parse the start date, end date, and date to check from strings
          DateTime startDate =
              DateTime.parse(startDateStr.replaceAll("/", "-"));
          DateTime endDate = DateTime.parse(endDateStr.replaceAll("/", "-"));
          DateTime dateToCheck = DateTime.parse(dateToCheckStr);

          // Check if the date to check falls between the start and end dates
          return dateToCheck.isAtSameMomentAs(startDate) ||
              dateToCheck.isAtSameMomentAs(endDate) ||
              (dateToCheck.isAfter(startDate) && dateToCheck.isBefore(endDate));
        }

        print(data.length);
        for (int i = 0; i < data.length; i++) {
          print("Selected date");
          print(date1.text);
          print(date2.text);
          print("transaction date");
          print(data[i]['date_transaction']);
          bool isInRange = isDateInRange(
              date1.text, date2.text, data[i]['date_transaction']);

          if (isInRange && data[i]['cash_code'] == nama.text) {
            requiredData.add(data[i]);
          }
        }
        print("The valid data are :");
        print(requiredData);
        if (requiredData.isEmpty) {
          setState(() {
            nodata = true;
          });
        }
        setState(() {
          success = true;
        });
      } else {
        setState(() {
          success = false;
          incomplete = false;
          loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      "Laporan Mutasi Kas",
                      style: TextStyle(fontSize: 25),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Dari Nama Kas",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropDownWidget(option: nama),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: _selectedIndex == 0
                    //           ? null
                    //           : () {
                    //               setState(() {
                    //                 _selectedIndex = 0;
                    //               });
                    //             },
                    //       child: Text('Hari ini'),
                    //       style: ElevatedButton.styleFrom(
                    //         primary: _selectedIndex == 0
                    //             ? Colors.blueGrey[900]
                    //             : Colors.blueGrey[50],
                    //         onPrimary:
                    //             _selectedIndex == 0 ? Colors.white : Colors.black,
                    //       ),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: _selectedIndex == 1
                    //           ? null
                    //           : () {
                    //               setState(() {
                    //                 _selectedIndex = 1;
                    //               });
                    //             },
                    //       child: Text('1 Minggu'),
                    //       style: ElevatedButton.styleFrom(
                    //         primary: _selectedIndex == 1
                    //             ? Colors.blueGrey[900]
                    //             : Colors.blueGrey[50],
                    //         onPrimary:
                    //             _selectedIndex == 1 ? Colors.white : Colors.black,
                    //       ),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: _selectedIndex == 2
                    //           ? null
                    //           : () {
                    //               setState(() {
                    //                 _selectedIndex = 2;
                    //               });
                    //             },
                    //       child: Text('1 Bulan'),
                    //       style: ElevatedButton.styleFrom(
                    //         primary: _selectedIndex == 2
                    //             ? Colors.blueGrey[900]
                    //             : Colors.blueGrey[50],
                    //         onPrimary:
                    //             _selectedIndex == 2 ? Colors.white : Colors.black,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Jangka Waktu"),
                    Text("Tanggal"),
                    DatePickerTextField(date: date1),
                    SizedBox(
                      height: 10,
                    ),
                    Text("s/d"),
                    DatePickerTextField(date: date2),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          getData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: Get.width,
                              child: Center(
                                  child: Text(
                                "Export ke Excel",
                                style: TextStyle(fontSize: 18),
                              ))),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          getData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: Get.width,
                              child: Center(
                                  child: Text(
                                "Selanjutnya",
                                style: TextStyle(fontSize: 18),
                              ))),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    nodata == true ? Text("No data to show") : Container(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: requiredData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(requiredData[index]['cash_code'] +
                                        '  '),
                                    Text('RP. ' +
                                        '${requiredData[index]['amount_mutation'].toString()}'),
                                  ],
                                ),
                                Text('Explanation: ' +
                                    requiredData[index]['explanation']),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            trailing: Text(
                                '${requiredData[index]['id_amount_mutation']}'),
                            subtitle: Text(
                                '${requiredData[index]['date_transaction']}'),
                          ),
                        );
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
