import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Column(
          children: [
            Text('Instagram'),
            Text('Whatsapp'),
            Text('Facebook'),
          ],
        ),
      ),
    );
  }
}
