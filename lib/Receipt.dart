import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  double tunia = 0.0;
  double bca = 0.0;
  double bni = 0.0;
  double bri = 0.0;
  double lainnya = 0.0;
  double total = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserReceipt();
  }

  bool hidePassword = true;
  bool incomplete = false;
  bool loading = false;
  bool success = true;

  //////////////////////////////API TO VERIFY ADMIN\\\\\\\\\\\\\\\\\\\\\\

  getUserReceipt() async {
    // // Verification of admin
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
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        print("Receipt accepted successfully");
        var data = jsonDecode(response.body.toString());
        print(data.length);
        for (int i = 0; i < data.length; i++) {
          setState(() {
            if (data[i]['cash_code'] == "Tunai" &&
                data[i]['id_amount_mutation'] == "in ") {
              tunia = tunia + data[i]['amount_mutation'];
            }
            if (data[i]['cash_code'] == "Tunai" &&
                data[i]['id_amount_mutation'] == "out") {
              tunia = tunia - data[i]['amount_mutation'];
            }

            if (data[i]['cash_code'] == "BCA" &&
                data[i]['id_amount_mutation'] == "in ") {
              bca = bca + data[i]['amount_mutation'];
            }
            if (data[i]['cash_code'] == "BCA" &&
                data[i]['id_amount_mutation'] == "out") {
              bca = bca - data[i]['amount_mutation'];
            }

            if (data[i]['cash_code'] == "BNI" &&
                data[i]['id_amount_mutation'] == "in ") {
              bni = bni + data[i]['amount_mutation'];
            }
            if (data[i]['cash_code'] == "BNI" &&
                data[i]['id_amount_mutation'] == "out") {
              bni = bni - data[i]['amount_mutation'];
            }

            if (data[i]['cash_code'] == "BRI" &&
                data[i]['id_amount_mutation'] == "in ") {
              bri = bri + data[i]['amount_mutation'];
            }
            if (data[i]['cash_code'] == "BRI" &&
                data[i]['id_amount_mutation'] == "out") {
              bri = bri - data[i]['amount_mutation'];
            }

            if (data[i]['cash_code'] == "Lainnya" &&
                data[i]['id_amount_mutation'] == "in ") {
              lainnya = lainnya + data[i]['amount_mutation'];
            }
            if (data[i]['cash_code'] == "Lainnya" &&
                data[i]['id_amount_mutation'] == "out") {
              lainnya = lainnya - data[i]['amount_mutation'];
            }
            total = tunia + bca + bni + bri + lainnya;
          });
        }
        print("The tunia balance is");
        print(tunia);
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Resume Saldo Kas \nPT. Angin Ribut",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saldo Tunai",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "$tunia",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saldo BCA",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "$bca",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saldo BNI",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "$bni",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saldo BRI",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "$bri",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saldo Lainnya",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "$lainnya",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "$total",
                style: TextStyle(fontSize: 18),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
