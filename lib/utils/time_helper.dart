class TimeHelper {
  TimeHelper._();

  static Future<void> sleep() {
    return Future.delayed(Duration(seconds: 2), () {});
  }
}
