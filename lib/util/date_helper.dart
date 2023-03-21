class DateTimeHelper {
  static String getMonth(int monthNumber) {
    List<String> months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[monthNumber];
  }

  static String getTime(int hour, int minute) {
    String time;
    if (hour < 12) {
      time = '$hour:${minute.toString().padLeft(2, '0')} AM';
    } else if (hour == 12) {
      time = '12:${minute.toString().padLeft(2, '0')} PM';
    } else {
      time = '${hour - 12}:${minute.toString().padLeft(2, '0')} PM';
    }
    return time;
  }

  static String convertDatetime(DateTime? datetime) {
    if (datetime == null) return 'unknown';

    //DateTime datetime = DateTime.parse(datetimeString);
    String month = getMonth(datetime.month);
    String formattedDatetime =
        '${datetime.day} $month ${datetime.year}, ${getTime(datetime.hour, datetime.minute)}';
    return formattedDatetime;
  }
}
