class TimeHelper {
  TimeHelper._();

  static Future<void> sleep() {
    return Future.delayed(Duration(milliseconds: 500), () {});
  }
}
