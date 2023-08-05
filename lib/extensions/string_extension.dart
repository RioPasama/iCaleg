extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension StringToDateTime on String {
  DateTime toDateTime({String format = 'dd/MM/yyyy HH:mm'}) {
    try {
      final parsedDate = DateTime.parse(this);
      final formattedDate = '${parsedDate.day.toString().padLeft(2, '0')}/'
          '${parsedDate.month.toString().padLeft(2, '0')}/'
          '${parsedDate.year} ${parsedDate.hour.toString().padLeft(2, '0')}:'
          '${parsedDate.minute.toString().padLeft(2, '0')}';
      return DateTime.parse(formattedDate);
    } catch (e) {
      throw const FormatException('Invalid date format');
    }
  }
}
