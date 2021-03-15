// ignore_for_file: non_constant_identifier_names

import 'package:singh_architecture/models/product_model.dart';

class CartProductModel extends ProductModel {
  final String Id;
  final String ThumbnailURL;
  final String Title;
  final String Price;
  final double Rating;
  final String Description;
  final List<String> Galleries;
  late int Quantity;

  CartProductModel({
    required this.Id,
    required this.ThumbnailURL,
    required this.Title,
    required this.Price,
    required this.Rating,
    required this.Description,
    required this.Galleries,
    required this.Quantity,
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
        Price: rawJson["price_number"] ?? "0",
        Rating: 4,
        Description: rawJson["description"] ?? "",
        Galleries: ((rawJson["galleries"] ?? []) as List<dynamic>).map((url) => url["image_url"] as String).toList(),
        Quantity: rawJson["quantity"] ?? 1,
    );
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
  late String Total;
  late double TotalNumber;

  CartModel({
    required this.Id,
    required this.Products,
    required this.Total,
    required this.TotalNumber,
  });

  factory CartModel.fromJson(Map<String, dynamic> rawJson) {
    return CartModel(
      Id: rawJson["id"] ?? "",
      Products: CartProductModel.toList(rawJson["products"]),
      Total: rawJson["total"] ?? "",
      TotalNumber: rawJson["total_number"] ?? 0,
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
