import 'package:intl/intl.dart';

String shortDateToString(DateTime date) {
  if (date == DateTime(1900, 1, 1)) {
    return '';
  }
  var f = DateFormat('dd.MM.yyyy');
  return f.format(date).toString();
}
