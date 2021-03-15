class ArrayHelper {
  ArrayHelper._();

  static bool isAllTrue(List<bool> list) {
    bool allTrue = true;

    for (int i = 0; i < list.length; i++) {
      if (!list[i]) {
        allTrue = false;
        break;
      }
    }

    return allTrue;
  }

  static bool isAllFalse(List<bool> list) {
    bool allTrue = true;

    for (int i = 0; i < list.length; i++) {
      if (list[i]) {
        allTrue = false;
        break;
      }
    }

    return allTrue;
  }
}
