import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String convertTimeStampToString(Timestamp time){
  DateTime newTime = time.toDate();
//  final dateFormat = DateFormat.jm();
  final dateFormat = DateFormat.yMd().add_jm();
  final dateTime = dateFormat.format(newTime);
  return (time != null) ? dateTime.toString() : "";
}

///
/// return 7/10/1996
///
String formatDateTimeOfHealth (DateTime time){
  final dateFormat = DateFormat.yMd();
  final formattedTime = dateFormat.format(time);
  return formattedTime.toString();

}

String formatTimeStampOfHealth (Timestamp time){
  DateTime newTime = time.toDate();
  final format = DateFormat.yMd();
  return format.format(newTime).toString();

}

String offerTimeHandler(Timestamp time){
  DateTime newTime = time.toDate();
  final format = DateFormat.yMd().add_jm();
  return format.format(newTime).toString();
}



