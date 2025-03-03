import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Map<String, String> createMapDate(DateTime datetime) {
  return {
    "year": datetime.year.toString(),
    "month": datetime.month.toString().padLeft(2, '0'),
    "day": datetime.day.toString().padLeft(2, '0'),
    "hour": datetime.hour.toString().padLeft(2, '0'),
    "minute": datetime.minute.toString().padLeft(2, '0'),
  };
}

String calculateDate(Map<String, String> upload, Map<String, String> now) {
  DateTime uploadDate = DateTime(
    int.parse(upload["year"]!),
    int.parse(upload["month"]!),
    int.parse(upload["day"]!),
    int.parse(upload["hour"]!),
    int.parse(upload["minute"]!),
  );
  
  DateTime nowDate = DateTime(
    int.parse(now["year"]!),
    int.parse(now["month"]!),
    int.parse(now["day"]!),
    int.parse(now["hour"]!),
    int.parse(now["minute"]!),
  );
  
  Duration difference = nowDate.difference(uploadDate);
  
  if (difference.inMinutes < 1) {
    return "Just now";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes}m ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours}h ago";
  } else if (difference.inDays <= 7) {
    return "${difference.inDays}d ago";
  } else {
    String month = DateFormat.MMMM().format(uploadDate);
    return "${upload["day"]} $month ${upload["year"]}";
  }
}

String formatTimestamp(Timestamp timestamp) {
  DateTime date = timestamp.toDate();
  DateTime now = DateTime.now();

  var uploadDate = createMapDate(date);
  var nowDate = createMapDate(now);

  return calculateDate(uploadDate, nowDate);
}
