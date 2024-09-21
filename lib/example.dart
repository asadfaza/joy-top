import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Color firstColor = Color.fromRGBO(255, 0, 77, 1);
Color secondColor = Color.fromRGBO(255, 0, 77, 1);
Color backColor = Color.fromRGBO(239, 239, 239, 1);

void openYandexMaps(String link) async {
  final Uri url = Uri.parse(link);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

ButtonStyle buttonStyle(double screenWidth, Color color) =>
    TextButton.styleFrom(
      //padding: const EdgeInsets.all(10),
      fixedSize: Size(screenWidth * 0.85, 45),
      backgroundColor: color,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
          fontSize: 20,
          fontFamily: 'Roboto Condensed',
          fontWeight: FontWeight.w700),
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );

BoxDecoration decoration() => BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
    );

void confirmMassage({
  required BuildContext context,
  required void Function()? func,
  String title = 'Do something',
  String content = 'Are you sure?',
  String onConfirm = 'Yes',
  String onCancel = 'Cancel',
  bool isNotRed = false,
}) =>
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  onCancel,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  func!();
                },
                child: Text(
                  onConfirm,
                  style: TextStyle(color: isNotRed ? firstColor : Colors.red),
                ),
              )
            ],
          );
        });

InputDecoration fieldDesign(
        {required bool isRound,
        required icon,
        required text,
        required Size size}) =>
    InputDecoration(
        contentPadding: EdgeInsets.only(
            top: size.width * 0.051,
            bottom: size.width * 0.051,
            left: 12,
            right: 15),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black),
          borderRadius: isRound
              ? BorderRadius.all(Radius.circular(10.0))
              : BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey),
          borderRadius: isRound
              ? BorderRadius.all(Radius.circular(10.0))
              : BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(0)),
        ),
        suffixIcon: icon,
        labelText: text,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ));

Widget dropDown(
        {required text,
        required List list,
        required String? value,
        required ValueChanged<String?> onChanged,
        required error,
        required Size size}) =>
    Container(
      height: size.width * 0.153,
      decoration: BoxDecoration(
        borderRadius: (text == 'Type')
            ? BorderRadius.only(
                topLeft: Radius.circular(10), // Left side rounded
                bottomLeft: Radius.circular(10), // Left side rounded
                topRight: Radius.circular(0), // Right side sharp
                bottomRight: Radius.circular(0), // Right side sharp
              )
            : (text == 'Capacity')
                ? BorderRadius.only(
                    topLeft: Radius.circular(0), // Left side rounded
                    bottomLeft: Radius.circular(0), // Left side rounded
                    topRight: Radius.circular(0), // Right side sharp
                    bottomRight: Radius.circular(0), // Right side sharp
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(0), // Left side rounded
                    bottomLeft: Radius.circular(0), // Left side rounded
                    topRight: Radius.circular(10), // Right side sharp
                    bottomRight: Radius.circular(10), // Right side sharp
                  ),
        border: Border.all(
            width: 1, color: (error != null) ? Colors.red : Colors.grey),
      ),
      child: DropdownButton<String>(
        padding: const EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(10),
        hint: Text(text,
            style: TextStyle(
                fontSize: 15,
                color: (error != null) ? Colors.red : Colors.grey)),
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        value: value,
        iconSize: 36,
        isExpanded: true,
        onChanged: onChanged,
        underline: const SizedBox(),
        icon: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: (error != null) ? Colors.red : Colors.grey,
          size: 25,
        ),
        items: list.map((values) {
          return DropdownMenuItem<String>(value: values, child: Text(values));
        }).toList(),
      ),
    );

List typeList = [
  'offices',
  'coworking',
  'studios',
  'conference halls',
  'meeting rooms',
  'art spaces'
];

List capacityList = ['4-7', '7-15', '20-50', '50-100', '100-200', '200+'];

List areaList = [
  '20-50 m^2',
  '50-70 m^2',
  '70-100 m^2',
  '100-200 m^2',
  '200+ m^2'
];
