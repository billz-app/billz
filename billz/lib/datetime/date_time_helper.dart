// convert date-time obj to string of format YYYY:MM:DD
String convertDateTimeToString(DateTime dateTime) {
  // year -> yyyy
  String year = dateTime.year.toString();

  // month -> mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month'; // to get 01 -> Jan
  }

  // day -> dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day'; // to get 01 -> Mon
  }

  //overall format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
