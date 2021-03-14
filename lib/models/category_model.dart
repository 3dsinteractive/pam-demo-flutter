// ignore_for_file: non_constant_identifier_names

class CategoryModel {
  final String Id;
  final String Title;
  final String ImageURL;

  CategoryModel({
    required this.Id,
    required this.Title,
    required this.ImageURL,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> rawJson) {
    return CategoryModel(
      Id: rawJson["id"],
      Title: rawJson["title"],
      ImageURL: rawJson["image_url"],
    );
  }

  static List<CategoryModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<CategoryModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(CategoryModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
