import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/databaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';
import 'package:pregnancy_tracking_app/widget/CustomInputField.dart';

class UpdatePregCalculation extends StatefulWidget {
  User currentUser;
  UpdatePregCalculation(this.currentUser);
  @override
  _UpdatePregCalculationState createState() => _UpdatePregCalculationState();
}

class _UpdatePregCalculationState extends State<UpdatePregCalculation> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  DatabaseService _databaseService = DatabaseService();

  final _formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final bCountController = TextEditingController();

  onClickCancel() {
    Navigator.of(context).pop();
  }

  onClickSave() {
    if (_formKey.currentState.validate()) {
      this.widget.currentUser.weight = double.parse(this.weightController.text);
      this.widget.currentUser.bloodCount =
          double.parse(this.bCountController.text);
      _databaseService.createUser(this.widget.currentUser, false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    weightController.text = this.widget.currentUser.weight.toString();
    bCountController.text = this.widget.currentUser.bloodCount.toString();
    return AlertDialog(
      scrollable: true,
      backgroundColor: Colors.lightGreen[50],
      content: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomBannerText(
                title: "Pregnancy Calculations",
                size: blockWidth * 5,
                weight: FontWeight.w300,
              ),
              SizedBox(height: 25.0),
              CustomInputField(
                hintText: "Wegiht",
                isPass: false,
                fieldType: "weight",
                fieldController: weightController,
                prefixIcon: Icons.pregnant_woman,
                inputType: TextInputType.number,
                fillColor: Colors.green[100],
              ),
              SizedBox(height: 15.0),
              CustomInputField(
                hintText: "Blood Count",
                isPass: false,
                fieldType: "bCount",
                fieldController: bCountController,
                prefixIcon: Icons.pregnant_woman,
                inputType: TextInputType.number,
                fillColor: Colors.green[100],
              ),
              SizedBox(height: blockHeight * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomButton(
                    title: "Cancel",
                    bgColor: Colors.red[400].withOpacity(0.9),
                    textColor: Colors.white,
                    callback: onClickCancel,
                    width: blockWidth * 22.5,
                    height: blockHeight * 5,
                    fontSize: blockHeight * 2,
                    formKey: _formKey,
                  ),
                  CustomButton(
                    title: "Save",
                    bgColor: Colors.green[600],
                    textColor: Colors.white,
                    callback: onClickSave,
                    width: blockWidth * 22.5,
                    height: blockHeight * 5,
                    fontSize: blockHeight * 2,
                    formKey: _formKey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

