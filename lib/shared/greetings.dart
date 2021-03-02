import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Greetings {
  String welcomeGreetings(BuildContext context) {
    int lTime = 12;
    int eTime = 18;

    int time = 24;
    DateTime current = DateTime.now();
    // DateTime current1 =DateTime.parse(DateFormat.Hm().format(current)) ;
    String greeting;

    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
    String res = timeOfDay.format(context);
    bool is12HoursFormat = res.contains(new RegExp(r'[A-Z]'));
    

    var timeNow = DateTime.now().hour;
       if (timeNow <= 11) {
        return 'Asubuhi Njema';
      } else if ((timeNow >= 12) && (timeNow <= 16)) {
        return 'Mchana Mwema';
      } else if ((timeNow >= 16) && (timeNow <= 20)) {
        return 'Jioni Njema';
      } else {
        return 'Usiku Mwema';
      }
  }
}
