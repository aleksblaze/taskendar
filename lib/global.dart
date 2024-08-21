import 'package:taskendar/models/task.dart';
import 'package:intl/intl.dart';

shortDateToString(DateTime date) {
  if (date == DateTime(1900, 1, 1)) {
    return '';
  }
  var f = DateFormat('dd.MM.yyyy');
  return (f.format(date).toString());
}

List<Task> taskList = [];
