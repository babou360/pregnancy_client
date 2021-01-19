class TimeCalculate {
  countDates(DateTime dateFrom, DateTime dateTo) {
    return dateFrom.difference(dateTo).inDays;
  }

  countWeeks(DateTime dateFrom, DateTime dateTo) {
    int dates = dateFrom.difference(dateTo).inDays;
    int weeks;
    if (dates % 7 == 0) {
      weeks = (dates / 7).toInt();
    } else {
      weeks = (dates / 7).toInt() + 1;
    }
    return weeks;
  }

  countMonths(DateTime dateFrom, DateTime dateTo) {
    int dates = dateFrom.difference(dateTo).inDays;
    int months;
    if (dates % 30 == 0) {
      months = (dates / 30).toInt();
    } else {
      months = (dates / 30).toInt() + 1;
    }
    return months;
  }
}
