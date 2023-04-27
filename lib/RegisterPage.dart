import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/ITSupport.dart';
import 'package:project2/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'Widgets/DefaultTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController ownerName = new TextEditingController();
  TextEditingController businessName = new TextEditingController();
  TextEditingController phoneno = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  bool failed = false;
  bool hidePassword = true;
  bool incomplete = false;
  bool loading = false;
  bool success = false;
  bool duplicatephone = false;

  initState() {
    print("Hello");
  }

  checkPhoneNumber() async {}

  register() async {
    //VALIDATION
    if (phoneno.text == "" ||
        otp.text == "" ||
        ownerName.text == "" ||
        businessName.text == "") {
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
      // // Verification of admin

      try {
        String body2 =
            //     "INSERT INTO tb_cashbook(id_receipt,date_transaction,cash_code,balance,explanation,from_to_name) VALUES ('1','2023/04/02','BNI','2200','transfer','abiral')";
            "SELECT * FROM tb_user";

        response = await http.post(
          Uri.parse("http://api4test.my.id:5000/api/v1/opensql"),
          headers: {'accept': 'application/json', 'Content-Type': 'text/plain'},
          body: body2,
        );
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body.toString());
          print(data.length);
          var phones = [];
          for (int i = 0; i < data.length; i++) {
            phones.add(data[i]['phone']);
          }

          for (String phone in phones) {
            setState(() {
              duplicatephone = false;
            });
            if (phone.toString().contains(phoneno.text.toString())) {
              setState(() {
                duplicatephone = true;
              });

              break;
            }
          }

          // for (int i = 0; i < data.length; i++) {
          //   print(data[i]['phone']);
          //   print(phoneno.text);
          //   if (phoneno.text == data[i]['phone']) {
          //     print("already registered");
          //     setState(() {
          //       duplicatephone = true;
          //     });
          //   }
          // }
        } else {}
      } catch (e) {
        print(e);
      }
      print(duplicatephone);
      print("Hello");

      var bytes = utf8.encode(otp.text); // convert to bytes
      var md5Hash = md5.convert(bytes); // calculate the hash
      String hashedPassword = md5Hash.toString();
      try {
        if (duplicatephone == false) {
          var body = json.encode({
            "name": ownerName.text,
            "phone": phoneno.text,
            "otp": hashedPassword,
            "business_name": businessName.text
          });
//         String sql = '''INSERT INTO tb_user (name,phone,otp,business_name)
// VALUES ('\'${ownerName.text}'\'', '\'${phoneno.text}\'','\'${hashedPassword}\'','\'${businessName.text}'\'')''';
          String body2 =
              "INSERT INTO tb_user (name,phone,otp,business_name) VALUES ('${ownerName.text}','${phoneno.text}','${hashedPassword}','${businessName.text}');";

          response = await http.post(
              Uri.parse("http://api4test.my.id:5000/api/v1/exesql"),
              headers: {
                'accept': 'application/json',
                'Content-Type': 'text/plain',
              },
              body: body2);
          print("Your response status code is");
          print(response.statusCode);

          if (response.statusCode == 200) {
            print("User Registerd ");
            var data = jsonDecode(response.body.toString());
            print(data);
            setState(() {
              success = true;
            });

            Get.offAll(LoginPage());
          } else {
            setState(() {
              failed = true;
              success = false;
              incomplete = false;
              loading = false;
            });
          }
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
            Container(
              height: 800,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profile",
                                style: TextStyle(fontSize: 25),
                              ),
                              Text("Owner Name"),
                              DefaultTextField("Owner Name", ownerName),
                              Text("Business Name"),
                              DefaultTextField("Business Name", businessName),
                              Text("no. phone"),
                              DefaultTextField("no. phone", phoneno),
                              Text("otp"),
                              DefaultTextField("otp", otp),
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
                                      "RegisterSuccessfull",
                                      style: TextStyle(color: Colors.green),
                                    )
                                  : Container(),
                              failed == true
                                  ? Text(
                                      "Register failed",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Container(),
                              duplicatephone == true
                                  ? Text(
                                      "Already registered",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Container(),
                              Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        register();
                                      },
                                      child: Text("register")))
                            ]),
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.to(ITSupport());
                          },
                          child: Text("Wa IT support"))
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
