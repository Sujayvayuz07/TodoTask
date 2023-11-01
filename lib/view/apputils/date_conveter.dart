import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime time) {
    return DateFormat('MMM dd, yyyy').format(time);
  }

  static String groupFormator(String date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    DateTime parseDate = DateFormat('MMM dd, yyyy').parse(date);
    var dateToCheck = DateTime.parse(parseDate.toString());
    final Dates =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (Dates == today) {
      return "Today Task";
    } else if (Dates == yesterday) {
      return "Completed Task";
    } else if (Dates == tomorrow) {
      return "Tomorrow Task";
    }
    return "Future Task";
  }

  static DateTime changeStringTodateTime(String date) {
    DateTime parseDate = DateFormat('d MMM yyyy').parse(date);
    var dateTime = DateTime.parse(parseDate.toString());
    return dateTime;
  }
}
