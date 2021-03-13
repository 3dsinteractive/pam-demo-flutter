import 'package:singh_architecture/models/types.dart';

class ArrayHelper {
  ArrayHelper._();

  static List<T>? responseToItemsI<T>(Map<String, dynamic> data) {
    List<T> items = [];
    List<Map<String, dynamic>> rawItems = data["items"];

    for (int i = 0; i < rawItems.length; i++) {
      items.add((T as IBaseModel).innerFromJson(rawItems[i]));
    }

    return items;
  }
}
