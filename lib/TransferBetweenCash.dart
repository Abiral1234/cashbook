import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project2/LoginPage.dart';
import 'package:project2/Widgets/DropDownWidget.dart';

import 'Widgets/DefaultTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TransferBetweenCash extends StatefulWidget {
  const TransferBetweenCash({super.key});

  @override
  State<TransferBetweenCash> createState() => _TransferBetweenCashState();
}

class _TransferBetweenCashState extends State<TransferBetweenCash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cashcode1.text = "Tunai";
    cashcode2.text = "Tunai";
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy/MM/dd').format(now);
    print("The formatted date is");
    print(formattedDate);
  }

  int _selectedValue = 0;
  TextEditingController cashcode1 = new TextEditingController();
  TextEditingController cashcode2 = new TextEditingController();
  TextEditingController ket = new TextEditingController();
  TextEditingController nominal = new TextEditingController();
  bool hidePassword = true;
  bool incomplete = false;
  bool loading = false;
  bool success = false;
  bool failed = false;
  String formattedDate = '';
  //TextEditingController formattedDate = new TextEditingController();

  //////////////////////////////API TO VERIFY ADMIN\\\\\\\\\\\\\\\\\\\\\\

//   cashtransfer() async {
//     //VALIDATION
//     if (cashcode2.text == "" || cashcode1.text == "" || ket.text == "") {
//       print("Incomplete");
//       setState(() {
//         incomplete = true;
//       });
//       print(incomplete);
//     } else {
//       // // Verification of admin
//       var response;
//       setState(() {
//         loading = true;
//       });
//       print("Hello");
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? access_token = prefs.getString('access_token');
//       String? phone = prefs.getString('phone');
//       print("The user access_token is");
//       print(access_token);
//       try {
//         // var body = json.encode({
//         //   "id_receipt": no.text,
//         //   "date_transaction": date.text,
//         //   "cash_code": nama.text,
//         //   "balance": jumlah.text,
//         //   "explanation": kete.text,
//         //   "from_to_name": dari.text
//         // });
//         // print(body);
//         String body2 =
//             //     "INSERT INTO tb_cashbook(id_receipt,date_transaction,cash_code,balance,explanation,from_to_name) VALUES ('1','2023/04/02','BNI','2200','transfer','abiral')";
//             '''UPDATE tb_cashbook
// SET cash_code = '${cashcode2.text}'
// WHERE explanation = '${ket.text}' AND cash_code = '${cashcode1.text}' AND "amount_mutation" = '${nominal.text}' AND "id_user" = $phone ''';
//         response = await http.post(
//             Uri.parse("http://api4test.my.id:5000/api/v1/exesql"),
//             headers: {
//               'authorization': 'Bearer $access_token',
//               'accept': 'application/json',
//               'Content-Type': 'text/plain'
//             },
//             body: body2);
//         print("Your response status code is");
//         print(response.statusCode);
//         print(response.body);

//         if (response.statusCode == 200) {
//           print("Cash Transfered sucessfully ");
//           var data = jsonDecode(response.body.toString());
//           print(data);
//           setState(() {
//             success = true;
//             failed = false;
//           });
//         } else {
//           setState(() {
//             success = false;
//             failed = true;
//             incomplete = false;
//             loading = false;
//           });
//         }
//       } catch (e) {
//         print(e);
//       }
//     }
//   }

  cashtransfer() async {
    //VALIDATION
    if (cashcode2.text == "" || cashcode1.text == "" || ket.text == "") {
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
            "INSERT INTO tb_cashbook (id_user,amount_mutation,cash_code,id_amount_mutation,explanation,date_transaction) VALUES ('$phone','${nominal.text}','${cashcode1.text}','out','${ket.text}','${formattedDate}');";

        response = await http.post(
            Uri.parse("http://api4test.my.id:5000/api/v1/exesql"),
            headers: {
              'authorization': 'Bearer $access_token',
              'accept': 'application/json',
              'Content-Type': 'text/plain'
            },
            body: body2);

        String body3 =
            //     "INSERT INTO tb_cashbook(id_receipt,date_transaction,cash_code,balance,explanation,from_to_name) VALUES ('1','2023/04/02','BNI','2200','transfer','abiral')";
            "INSERT INTO tb_cashbook (id_user,amount_mutation,cash_code,id_amount_mutation,explanation,date_transaction) VALUES ('$phone','${nominal.text}','${cashcode2.text}','in','${ket.text}','${formattedDate}');";

        response = await http.post(
            Uri.parse("http://api4test.my.id:5000/api/v1/exesql"),
            headers: {
              'authorization': 'Bearer $access_token',
              'accept': 'application/json',
              'Content-Type': 'text/plain'
            },
            body: body3);
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
                      "Transfer antar Kas",
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
                    DropDownWidget(
                      option: cashcode1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ke Nama Kas",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropDownWidget(
                      option: cashcode2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Nominal"),
                    DefaultTextField("Nominal", nominal),
                    Text("Keterangan"),
                    DefaultTextField("Ket", ket),
                    SizedBox(
                      height: 10,
                    ),
                    incomplete == true
                        ? Text(
                            "Incomplete",
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                    success == true
                        ? Text(
                            "Transfer Successfull",
                            style: TextStyle(color: Colors.green),
                          )
                        : Container(),
                    failed == true
                        ? Text(
                            "Transfer failed",
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                    ElevatedButton(
                        onPressed: () {
                          cashtransfer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: Get.width,
                              child: Center(
                                  child: Text(
                                "Submit",
                                style: TextStyle(fontSize: 18),
                              ))),
                        ))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
