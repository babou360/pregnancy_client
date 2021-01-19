import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/globals.dart';

class CustomInputField extends StatefulWidget {
  final String hintText, fieldType;
  final TextEditingController
      fieldController; // fieldType should be "mobile" or "text"
  final bool isPass;
  final IconData prefixIcon;
  final TextInputType inputType;
  final Color fillColor;

  CustomInputField(
      {@required this.hintText,
      @required this.isPass,
      @required this.fieldType,
      @required this.fieldController,
      @required this.prefixIcon,
      this.fillColor,
      this.inputType});

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  double blockHeight = Globals.blockHeight;
  double blockWidth = Globals.blockWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: this.widget.isPass,
        controller: this.widget.fieldController,
        validator: validateField,
        keyboardType: (this.widget.inputType == null)
            ? TextInputType.text
            : this.widget.inputType,
        decoration: InputDecoration(
          // prefixText: (this.widget.fieldType == 'mobile') ? '+94' : null,
          contentPadding: EdgeInsets.all(10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50.0),
          ),
          prefixIcon: Icon(this.widget.prefixIcon),
          hintText: this.widget.hintText,
          filled: true,
          fillColor: (this.widget.fillColor == null)
              ? Colors.green[50]
              : this.widget.fillColor,
          border: InputBorder.none,
        ),
      ),
    );
  }

  String validateField(String value) {
    switch (this.widget.fieldType) {
      case "mobile":
        return validateMobile(value);
        break;
      case "text":
        return validateEmpty(value);
        break;
      case "weight":
        return validateWeight(value);
        break;
      case "bCount":
        return validateBCount(value);
        break;
    }
  }

  String validateEmpty(String value) {
    if (value.isEmpty) {
      return "This field can't be empty";
    } else {
      return null;
    }
  }

  String validateMobile(String value) {
    if (value.isEmpty) {
      return 'Phone Number is required';
      // } else if () {
// mobile lnght validate
    } else {
      return null;
    }
  }

  String validateWeight(String value) {
    if (double.tryParse(value) == null ||
        double.parse(value) < 15 ||
        double.parse(value) > 500) {
      return 'Invalid Weight';
    } else {
      return null;
    }
  }

  String validateBCount(String value) {
    if (double.tryParse(value) == null ||
        double.parse(value) < 8.0 ||
        double.parse(value) > 15.0) {
      return "Invalid Blood count";
    } else {
      return null;
    }
  }
}
