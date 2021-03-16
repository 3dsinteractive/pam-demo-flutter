// ignore_for_file: non_constant_identifier_names

import 'package:singh_architecture/models/product_model.dart';

class CartProductModel extends ProductModel {
  final String Id;
  final String ThumbnailURL;
  final String Title;
  late double Price;
  final double Rating;
  final String Description;
  final List<String> Galleries;
  late int Quantity;
  late double Total;
  late bool isSelected;

  CartProductModel({
    required this.Id,
    required this.ThumbnailURL,
    required this.Title,
    required this.Price,
    required this.Rating,
    required this.Description,
    required this.Galleries,
    required this.Quantity,
    required this.Total,
    required this.isSelected,
  }) : super(
          Id: Id,
          ThumbnailURL: ThumbnailURL,
          Title: Title,
          Price: Price,
          Rating: Rating,
          Description: Description,
          Galleries: Galleries,
        );

  factory CartProductModel.fromJson(Map<String, dynamic> rawJson) {
    return CartProductModel(
        Id: rawJson["product_id"] ?? "",
        ThumbnailURL: rawJson["thumbnail_url"] ?? "",
        Title: rawJson["title"] ?? "",
        Price: double.parse(rawJson["price_number"] ?? "0"),
        Rating: 4,
        Description: rawJson["description"] ?? "",
        Galleries: ((rawJson["galleries"] ?? []) as List<dynamic>)
            .map((url) => url["image_url"] as String)
            .toList(),
        Quantity: int.parse(rawJson["quantity"] ?? "1"),
        Total: (double.parse((rawJson["quantity"] ?? "1")) *
            (double.parse(rawJson["price_number"] ?? "0"))),
        isSelected: (rawJson["is_selected"] == "true") || false);
  }

  static List<CartProductModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<CartProductModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(CartProductModel.fromJson(rawItems[i]));
    }

    return items;
  }
}

class CartModel {
  final String Id;
  final List<CartProductModel> Products;
  late double Total;

  CartModel({
    required this.Id,
    required this.Products,
    required this.Total,
  });

  factory CartModel.fromJson(Map<String, dynamic> rawJson) {
    return CartModel(
      Id: rawJson["id"] ?? "",
      Products: CartProductModel.toList(rawJson["products"]),
      Total: double.parse(rawJson["total"] ?? "0"),
    );
  }

  static List<CartModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<CartModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(CartModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
