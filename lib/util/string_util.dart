import 'package:intl/intl.dart'; // 导入intl包


class StringUtil {
  /*当前时间字符串*/
  static String currentTimeString() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
  }


}