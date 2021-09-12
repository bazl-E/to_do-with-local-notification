import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatedTime(TimeOfDay selectedTime) {
  DateTime tempDate = DateFormat("hh:mm").parse(
      selectedTime.hour.toString() + ":" + selectedTime.minute.toString());
  var dateFormat = DateFormat("h:mm a");
  return (dateFormat.format(tempDate));
}
