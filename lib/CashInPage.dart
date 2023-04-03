import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/LoginPage.dart';
import 'package:project2/Widgets/DatePickerTextField.dart';
import 'package:http/http.dart' as http;
import 'package:project2/Widgets/DropDownWidget.dart';
import 'HomePage.dart';
import 'Widgets/DefaultTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CashInPage extends StatefulWidget {
  const CashInPage({super.key});

  @override
  State<CashInPage> createState() => _CashInPageState();
}

class _CashInPageState extends State<CashInPage> {
  TextEditingController no = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController jumlah = new TextEditingController();
  TextEditingController date2 = new TextEditingController();
  TextEditingController kete = new TextEditingController();
  TextEditingController dari = new TextEditingController();
  TextEditingController amount = new TextEditingController();

  bool hidePassword = true;
  bool incomplete = false;
  bool loading = false;
  bool success = false;
  bool failed = false;

  //////////////////////////////API TO VERIFY ADMIN\\\\\\\\\\\\\\\\\\\\\\

  cashin() async {
    //VALIDATION
    if (no.text == "" || date.text == "") {
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? access_token = prefs.getString('access_token');
      String? phone = prefs.getString('phone');
      print("The user access_token is");
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
            "INSERT INTO tb_cashbook (id_user,id_receipt,date_transaction,cash_code,id_amount_mutation,amount_mutation,explanation,from_to_name) VALUES ('$phone','${no.text}','${date.text}','${nama.text}','in ','${jumlah.text}','${kete.text}','${dari.text}');";

        response = await http.post(
            Uri.parse("http://api4test.my.id:5000/api/v1/exesql"),
            headers: {
              'authorization': 'Bearer $access_token',
              'accept': 'application/json',
              'Content-Type': 'text/plain'
            },
            body: body2);
        print("Your response status code is");
        print(response.statusCode);
        print(response.body);

        if (response.statusCode == 200) {
          print("Transaction sucessfull ");
          var data = jsonDecode(response.body.toString());
          print(data);
          setState(() {
            failed = false;
            success = true;
          });
          // registercashin();
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

  registercashin() async {
    //VALIDATION
    if (no.text == "" || date.text == "") {
      print("Incomplete");
      setState(() {
        incomplete = true;
        success = true;
      });
      print(incomplete);
    } else {
      // // Verification of admin
      var response;
      setState(() {
        loading = true;
      });
      print("Hello");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? access_token = prefs.getString('access_token');
      print("The user access_token is");
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
            "INSERT INTO tb_about (text,value) VALUES ('${nama.text}','${jumlah.text}');";

        response = await http.post(
            Uri.parse("http://api4test.my.id:5000/api/v1/exesql"),
            headers: {
              'authorization': 'Bearer $access_token',
              'accept': 'application/json',
              'Content-Type': 'text/plain'
            },
            body: body2);
        print("Your response status code is");
        print(response.statusCode);
        print(response.body);

        if (response.statusCode == 200) {
          print("Transaction sucessfully registered ");
          var data = jsonDecode(response.body.toString());
          print(data);
          setState(() {
            success = true;
            failed = false;
          });

          Get.offAll(HomePage());
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
  }

  int _selectedValue = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nama.text = "Tunai";
  }

  String selectedOption = "Tunai";
  List<String> options = ["Tunai", "BCA", "BNI", "BRI", "Lainnya"];
  var brands = ['-select-'];
  String? value2 = '-select-';
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
                    Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            onTap: () {
                              Get.offAll(LoginPage());
                            },
                            child: Text("Logout"))),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Kwitansi Masuk Kas"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(width: 100, child: Text("No. Kuitnasi")),
                        Container(
                            width: 250, child: DefaultTextField("text", no))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(width: 100, child: Text("Tanggal")),
                        Container(
                            width: 250,
                            child: DatePickerTextField(
                              date: date,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(width: 100, child: Text("Jumlah (Rp)")),
                        Container(
                            width: 250, child: DefaultTextField("text", jumlah))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(width: 100, child: Text("Tanggal")),
                        Container(
                            width: 250,
                            child: DatePickerTextField(
                              date: date2,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(width: 100, child: Text("Keterangan")),
                        Container(
                            width: 250, child: DefaultTextField("text", kete))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("dari"),
                    DefaultTextField("text", dari),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Nama kas"),
                    SizedBox(
                      height: 10,
                    ),
                    DropDownWidget(
                      option: nama,
                    ),
                    incomplete == true
                        ? Text(
                            "Incomplete",
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                    success == true
                        ? Text(
                            "Transaction Successfull",
                            style: TextStyle(color: Colors.green),
                          )
                        : Container(),
                    failed == true
                        ? Text(
                            "Transaction failed",
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            onPressed: () {
                              cashin();
                            },
                            child: Text("Submit")))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

// DropdownMenuItem<String> buildMenuItem2(String subCategory) {
//   return DropdownMenuItem(
//       value: subCategory,
//       child: Text(
//         subCategory,
//       ));
// }
