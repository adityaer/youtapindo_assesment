import 'package:intl/intl.dart';

extension StringDate on String {
  String stringDateToString(String format1, String format2) {
    if (isEmpty) return '';
    DateTime tempDate = DateFormat(format1).parse(this);
    String date = DateFormat(format2).format(tempDate);
    return date;
  }

  String formatAmPmLowercase() {
    if (isEmpty) return '';
    return replaceAll("AM", "am").replaceAll("PM", "pm");
  }

  String formatSimpleAmPm() {
    if (isEmpty) return '';
    if (split("am").length == 3) {
      return replaceFirst("am", "");
    } else if (split("pm").length == 3) {
      return replaceFirst("pm", "");
    } else {
      return this;
    }
  }

  String formatTicketDate() {
    if (isEmpty) return '';
    return DateFormat('dd MMMM yyyy - HH:mm').format(DateTime.parse(this));
  }
}


