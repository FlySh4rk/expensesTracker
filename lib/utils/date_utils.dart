DateTime startOfMonth(DateTime date) => DateTime(date.year, date.month);

DateTime endOfMonth(DateTime date) => DateTime(date.year, date.month + 1);

bool isSameMonth(DateTime a, DateTime b) => a.year == b.year && a.month == b.month;
