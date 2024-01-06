import 'package:intl/intl.dart';

String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = dateTime.difference(now);

  if (difference.isNegative) {
    // If dateTime is in the past
    if (difference.inDays.abs() > 7) {
      return DateFormat('dd-MMM-yyyy').format(dateTime);
    } else if (difference.inDays.abs() > 0) {
      return '${difference.inDays.abs()} ${difference.inDays.abs() == 1 ? "day" : "days"} ago';
    } else if (difference.inHours.abs() > 0) {
      return '${difference.inHours.abs()} ${difference.inHours.abs() == 1 ? "hour" : "hours"} ago';
    } else if (difference.inMinutes.abs() > 0) {
      return '${difference.inMinutes.abs()} ${difference.inMinutes.abs() == 1 ? "minute" : "minutes"} ago';
    } else {
      return 'Just now';
    }
  } else {
    // If dateTime is in the future, show the date in the format "22-sep-2023"
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }
}

String formatTime(DateTime dateTime) {
  return DateFormat('h:mm a').format(dateTime);
}
