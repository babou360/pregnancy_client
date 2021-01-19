import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/databaseService.dart';
import 'package:path/path.dart' as Path;
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';
import 'package:pregnancy_tracking_app/widget/CustomIconButton.dart';
import 'package:pregnancy_tracking_app/widget/CustomInputField.dart';

class UpdatePersonalInfo extends StatefulWidget {
  User currentUser;
  UpdatePersonalInfo(this.currentUser);
  @override
  _UpdatePersonalInfoState createState() => _UpdatePersonalInfoState();
}

class _UpdatePersonalInfoState extends State<UpdatePersonalInfo> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  DatabaseService _databaseService = DatabaseService();

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  String profileImageURL;
  File _imageFile;

  Future getImage() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _imageFile = image;
        profileImageURL = image.path;
      });
    });
  }

  clearImage() async {
    if (_imageFile == null) {
      bool result = await _databaseService
          .deleteImage(this.widget.currentUser.profileImageURL);
      if (result == true) {
        print("file deleted");
        _databaseService
            .updateWhenDeleteImage(this.widget.currentUser.mobileNumber);
        setState(() {
          _imageFile = null;
          profileImageURL = null;
          this.widget.currentUser.profileImageURL = null;
        });
      } else {
        print("file not deleted");
      }
    } else {
      setState(() {
        print("clear image");
        _imageFile = null;
        profileImageURL = null;
      });
    }
  }

  @override
  void initState() {
    _imageFile = null;
    super.initState();
  }

  onClickCancel() {
    Navigator.of(context).pop();
  }

  onClickSave() {
    if (_formKey.currentState.validate()) {
      this.widget.currentUser.name = this.nameController.text;
      this.widget.currentUser.age = int.parse(this.ageController.text);
      if (_imageFile != null) {
        String imagePath = "users/" +
            this.widget.currentUser.mobileNumber.toString() +
            "-" +
            Path.basename(_imageFile.path).toString();
        _databaseService.uploadImage(
            imagePath, _imageFile, this.widget.currentUser);
      } else {
        _databaseService.createUser(this.widget.currentUser, false);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = this.widget.currentUser.name;
    ageController.text = this.widget.currentUser.age.toString();
    profileImageURL = this.widget.currentUser.profileImageURL;

    return AlertDialog(
      scrollable: true,
      backgroundColor: Colors.lightGreen[50],
      content: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomBannerText(
                title: "Personal Informations",
                size: blockWidth * 5,
                weight: FontWeight.w300,
              ),
              SizedBox(height: blockHeight * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: blockWidth * 30,
                    width: blockWidth * 30,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green[300].withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: CircleAvatar(backgroundImage: loadImage()),
                  ),
                  SizedBox(width: blockWidth * 5),
                  Column(
                    children: <Widget>[
                      CustomIconButton(
                        icon: Icons.add_a_photo,
                        callback: getImage,
                      ),
                      SizedBox(height: blockHeight * 3),
                      (profileImageURL == null && _imageFile == null)
                          ? Container()
                          : CustomIconButton(
                              icon: Icons.delete,
                              callback: clearImage,
                            ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: blockHeight * 4),
              CustomInputField(
                hintText: "Name",
                isPass: false,
                fieldType: "text",
                fieldController: nameController,
                prefixIcon: Icons.person,
                fillColor: Colors.green[100],
              ),
              SizedBox(height: blockHeight * 2),
              CustomInputField(
                hintText: "Age",
                isPass: false,
                fieldType: "text",
                fieldController: ageController,
                prefixIcon: Icons.keyboard,
                inputType: TextInputType.number,
                fillColor: Colors.green[100],
              ),
              SizedBox(height: blockHeight * 2),
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

  loadImage() {
    if (profileImageURL == null && _imageFile == null) {
      return AssetImage("images/defaultProfile.png"); // load defaluld icon
    } else if (_imageFile != null) {
      return AssetImage(_imageFile.path); // load selected image
    } else {
      return NetworkImage(profileImageURL); // load from database
    }
  }
}

