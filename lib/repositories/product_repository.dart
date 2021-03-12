import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/utils/requester.dart';

class ProductRepository extends BaseRepository {
  final IConfig? config;

  ProductRepository({
    required this.config,
  });

  List<dynamic>? items = List<dynamic>.empty(growable: true);

  Future<void> fetch() async {
    try {
      this.toLoadingStatus();
      Response response =
          await Requester.get("${this.config!.baseAPI()}/products");
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

      if (data["items"] != null) {
        this.items = data["items"];
      }

      this.toLoadedStatus();
    } catch (e) {
      this.toErrorStatus(e);
    }
  }
}
