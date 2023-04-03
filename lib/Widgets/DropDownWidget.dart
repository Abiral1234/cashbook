import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final TextEditingController option;

  DropDownWidget({required this.option});
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  List<String> options = ["Tunai", "BCA", "BNI", "BRI", "Lainnya"];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            // buttonWidth: 150,
            iconSize: 35,
            icon: Icon(Icons.arrow_drop_down_sharp),
            value: widget.option.text,
            isExpanded: true,
            style: TextStyle(fontSize: 14, color: Colors.black),
            items: options.map(buildMenuItem2).toList(),
            onChanged: (value) {
              setState(() {
                widget.option.text = value.toString();
                print(value);
              });
            }),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem2(String subCategory) {
  return DropdownMenuItem(
      value: subCategory,
      child: Text(
        subCategory,
      ));
}
