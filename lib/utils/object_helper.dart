import 'package:flutter/cupertino.dart';

class ObjectHelper {
  ObjectHelper._();

  static bool isSnapshotStateLoading(AsyncSnapshot<bool> snapshot) {
    if (!snapshot.hasData || snapshot.data == null || snapshot.data == true) {
      return true;
    }

    return false;
  }

  static List<Map<String, dynamic>> toListMapString(List<dynamic>? list) {
    if (list == null) {
      return List<Map<String, dynamic>>.empty();
    }

    List<Map<String, dynamic>> lm =
        List<Map<String, dynamic>>.empty(growable: true);

    for (int i = 0; i < list.length; i++) {
      lm.add(Map<String, dynamic>.from(list[i]));
    }

    return lm;
  }

  static Map<String, dynamic> toMapString(dynamic? m) {
    if (m == null) {
      return Map<String, dynamic>();
    }

    return Map<String, dynamic>.from(m);
  }
}
