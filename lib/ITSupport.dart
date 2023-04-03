import 'package:flutter/material.dart';

class ITSupport extends StatefulWidget {
  const ITSupport({super.key});

  @override
  State<ITSupport> createState() => _ITSupportState();
}

class _ITSupportState extends State<ITSupport> {
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
              "IT Support\nNiftra Multi Jasa",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                style: TextStyle(fontSize: 18),
                "Lingkup layanan :\n(1). Jasa Rancang Bangun software Multi OS \n(2), Jasa Perbaikan/maintenance software.\n(3). Pelatihan Pembuatan dan Perbaikan softwand"),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Wa: CS: Fani"),
                Text("Wa: IT Support"),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
