int differenceInMonths(DateTime startDate, DateTime endDate) {
  int yearDiff = endDate.year - startDate.year;
  int monthDiff = endDate.month - startDate.month;

  // Adjust the month difference if end month is before start month
  if (monthDiff < 0) {
    yearDiff--;
    monthDiff += 12;
  }

  return yearDiff * 12 + monthDiff;
}