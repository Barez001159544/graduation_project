import 'package:flutter/material.dart';
import 'package:graduation_project/models/apartments_response.dart';
import 'package:graduation_project/models/houses_response.dart';

class CustomDropDownMenu extends StatelessWidget {
  final String hint;
  final double wid;
  final double height;
  final double radius;
  final Color ddmColor;
  final Color txtColor;
  final List<String>? items;
  final String? value;
  final Function(dynamic) onChange;
  const CustomDropDownMenu(this.hint, this.wid, this.height, this.radius, this.ddmColor, this.txtColor, this.items, this.value, this.onChange);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: wid,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ddmColor,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          dropdownColor: ddmColor,
          focusColor: Colors.transparent,
          isExpanded: true,
          disabledHint: Text(hint, style: TextStyle(fontFamily: "NotoSans", color: Colors.grey),),
          hint: Text(hint, style: TextStyle(fontFamily: "NotoSans", color: Colors.grey),),
          value: value != null ? value : null,
          style: TextStyle(color: txtColor),
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            size: 30,
            color: Colors.grey,
          ),
          items: List<String>.from(items as Iterable)
              .map((String itemss) {
            return DropdownMenuItem(
              value: itemss,
              child: Text(
                itemss,
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: "NotoSans"),
              ),
            );
          }).toList(),
          onChanged: (val) {
            onChange(val);
          },
        ),
      ),
    );
  }
}

class SpecialCustomDropDownMenu extends StatelessWidget {
  final String hint;
  final double wid;
  final double height;
  final double radius;
  final Color ddmColor;
  final Color txtColor;
  final List<HousesResponse>? items;
  final List<ApartmentsResponse>? items2;
  final dynamic? value;
  final Function(dynamic) onChange;
  const SpecialCustomDropDownMenu(this.hint, this.wid, this.height, this.radius, this.ddmColor, this.txtColor, this.items, this.items2, this.value, this.onChange);
  @override
  Widget build(BuildContext context) {
    // print(items);
    // print(items2);
    List<dynamic> combinedItems = [];
    if (items != null) {
      combinedItems.addAll(items!);
    }
    if (items2 != null) {
      combinedItems.addAll(items2!);
    }
    return Container(
      width: wid,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ddmColor,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          dropdownColor: ddmColor,
          focusColor: Colors.transparent,
          isExpanded: true,
          disabledHint: Text(hint, style: TextStyle(fontFamily: "NotoSans", color: Colors.grey),),
          hint: Text(hint, style: TextStyle(fontFamily: "NotoSans", color: Colors.grey),),
          value: value != null ? value : null,
          style: TextStyle(color: txtColor),
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            size: 30,
            color: Colors.grey,
          ),
          items: List<dynamic>.from(combinedItems as Iterable)
              .map((dynamic itemss) {
            return DropdownMenuItem(
              value: "${itemss.toString()=="Instance of 'HousesResponse'"?"Houses-":"Apartments-"}${itemss.name}",
              child: Text(
                "${itemss.toString()=="Instance of 'HousesResponse'"?"Houses-":"Apartments-"}${itemss.name}",
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: "NotoSans"),
              ),
            );
          }).toList(),
          onChanged: (dynamic val) {
            // print("${val.toString()=="Instance of 'HousesResponse'"?"Houses ":"Apartments "}${val.name}",);
            // print(val);
            onChange(val);
            // onChange("${val.toString()=="Instance of 'HousesResponse'"?"Houses-":"Apartments-"}${val.name}");
          },
        ),
      ),
    );
  }
}

