import 'package:cloud_firestore/cloud_firestore.dart';

class Calculator {
  /// DateTime zaman biçimini --> Stringe formatlayıp çeviren
  static String dateTimeToString(DateTime dateTime) {
    String formattedDate = "aa";
    return formattedDate;
  }

  /// DateTime --> TimeStamp
  static Timestamp datetimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch);
  }

  /// TimeStamp --> DateTime
  static DateTime datetimeFromTimestamp(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  }
}
