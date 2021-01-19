import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

class CustomButton extends StatefulWidget {
  double width, height, fontSize;
  String title;
  Color bgColor, textColor;
  final VoidCallback callback;
  GlobalKey<FormState> formKey;

  CustomButton(
      {@required this.title,
      @required this.bgColor,
      @required this.textColor,
      @required this.callback,
      this.formKey,
      this.height,
      this.width,
      this.fontSize});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    double blockHeight = SizeConfig.safeBlockVertical;

    return Container(
      height:
          (this.widget.height != null) ? this.widget.height : blockHeight * 7,
      width: (this.widget.width != null) ? this.widget.width : double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(color: this.widget.bgColor),
        ),
        color: this.widget.bgColor,
        textColor: this.widget.textColor,
        splashColor: Colors.green[200],
        child: Text(
          this.widget.title,
          style: TextStyle(
            fontSize: (this.widget.fontSize != null)
                ? this.widget.fontSize
                : blockHeight * 3,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          this.widget.callback();
        },
      ),
    );
  }
}
