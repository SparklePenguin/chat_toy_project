extension DateFormatter on DateTime {
  String get short {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$year.$month.$day';
  }

  String get iso {
    String year = this.year.toString();
    String month = this.month.toString().padLeft(2, '0');
    String day = this.day.toString().padLeft(2, '0');
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    String second = this.second.toString().padLeft(2, '0');
    String microsecond = this.microsecond.toString().padLeft(6, '0');
    return '$year-$month-${day}T$hour:$minute:$second.$microsecond';
  }
}
