// ignore_for_file: non_constant_identifier_names

class ProductModel {
  final String Id;
  final String ThumbnailURL;
  final String Title;
  final String Price;
  final double Rating;
  final String ShortDescription;
  final String Description;

  ProductModel({
    required this.Id,
    required this.ThumbnailURL,
    required this.Title,
    required this.Price,
    required this.Rating,
    required this.ShortDescription,
    required this.Description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> rawJson) {
    return ProductModel(
      Id: rawJson["id"],
      ThumbnailURL: rawJson["thumbnail_url"],
      Title: rawJson["title"],
      Price: rawJson["price"],
      Rating: double.parse(rawJson["rating"]),
      ShortDescription: rawJson["short_description"],
      Description: rawJson["description"],
    );
  }

  static List<ProductModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<ProductModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(ProductModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
