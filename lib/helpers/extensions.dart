extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }

  static DateTime today() {
    DateTime current = DateTime.now();
    return DateTime(current.year, current.month, current.day);
  }

  DateTime get onlyDate => DateTime(this.year, this.month, this.day);
}
