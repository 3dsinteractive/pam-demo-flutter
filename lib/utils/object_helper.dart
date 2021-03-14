import 'package:flutter/cupertino.dart';

class ObjectHelper {
  ObjectHelper._();

  static bool isSnapshotStateLoading(AsyncSnapshot<bool> snapshot) {
    if (!snapshot.hasData || snapshot.data == null || snapshot.data == true) {
      return true;
    }

    return false;
  }
}
