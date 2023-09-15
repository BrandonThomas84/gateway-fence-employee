

  /// Returns the end time of the timer in the format HH:MM:SS.
  String getDateTimeAsString(DateTime date, bool includeTime) {

    final day = date.day.toString().padLeft(2, '0');
    final month = getMonthfromInt(date.month);
    final year = date.year.toString();


    String result = '$month $day, $year';
    if (!includeTime) {
      return result;
    }

    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');
    final seconds = date.second.toString().padLeft(2, '0');
    
    return '$result $hours:$minutes:$seconds UTC';
  }

  String getMonthfromInt(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'Febuary';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7: 
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10: 
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'January';
    }
  }