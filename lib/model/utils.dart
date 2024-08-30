import 'package:intl/intl.dart';

extension IntExt on int {
  String toDate() {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    return format.format(DateTime.fromMillisecondsSinceEpoch(this));
  }

  String toGB() {
    return "${(this / 1000 / 1000 / 1000.0).toStringAsFixed(2)}GB";
  }
}
