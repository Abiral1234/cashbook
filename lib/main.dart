import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/CashInPage.dart';
import 'package:project2/HomePage.dart';
import 'package:project2/ITSupport.dart';
import 'package:project2/Receipt.dart';
import 'package:project2/TransferBetweenCash.dart';
import 'CashMovement.dart';
import 'CashOutPage.dart';
import 'FirstScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirstScreen());
  }
}
// [
//   "tb_table_1",
//   "tb_table_2",
//   "tb_table_3",
//   "tb_table_4",
//   "tb_table_5",
//   "tb_table_6",
//   "tb_table_7",
//   "tb_medicinal_items",
//   "tb_employee",
//   "tb_user",
//   "tb_emp_fj",
//   "tb_patient",
//   "tb_register_consultation",
//   "tb_identity_card",
//   "tb_unit",
//   "tb_divisi",
//   "tbl_desa",
//   "tb_daily_schedule",
//   "tb_monthly_schedule",
//   "tb_weekly_schedule",
//   "tbl_agama",
//   "tbl_golongan_darah",
//   "tb_emp_profil",
//   "tbl_kabupaten",
//   "tb_invoice",
//   "tb_invoicedetail",
//   "tb_electronicmedicalrecords",
//   "tbl_pasien",
//   "tbl_pegawai",
//   "tbl_pegawai_type",
//   "tbl_kecamatan",
//   "tbl_pegawai_category",
//   "tbl_pegawai_group",
//   "tbl_pekerjaan",
//   "tbl_poli",
//   "tbl_poli_tindakan",
//   "tbl_provinsi",
//   "tbl_golongan"
// ]