// ignore_for_file: non_constant_identifier_names

class BannerModel {
  final String Id;
  final String ImageURL;

  BannerModel({
    required this.Id,
    required this.ImageURL,
  });

  factory BannerModel.fromJson(Map<String, dynamic> rawJson) {
    return BannerModel(
      Id: rawJson["banner_id"],
      ImageURL: rawJson["cover_image_mobile_url"],
    );
  }

  static List<BannerModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<BannerModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(BannerModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
