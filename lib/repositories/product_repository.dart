import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/models/product_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/requester.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class ProductRepository extends BaseDataRepository<ProductModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;

  ProductRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
  }) : super(buildCtx, config, options);

  @override
  Future<void> fetch(
      {Map<String, dynamic>? params, bool isMock = false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (params == null) {
        params = {};
      }

      if (isMock) {
        await TimeHelper.sleep();
        data = {"items": this.options.getMockItems()};
      } else {
        Response response =
            await Requester.get(this.options.getBaseUrl(), params);
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = js;
      }

      this.items = ProductModel.toList(data["items"]);
      this.itemsSC.add(this.items);

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  Future get(String id,
      {Map<String, dynamic>? params, bool isMock = false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (params == null) {
        params = {};
      }

      if (isMock) {
        await TimeHelper.sleep();
        Map<String, dynamic> mock = this.options.getMockItems()!.firstWhere((element) => id == element["product_id"]);
        data = {"data": mock};
      } else {
        Response response =
            await Requester.get(this.options.getBaseUrl(), params);
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = js;
      }

      this.data = ProductModel.fromJson(data["data"]);
      this.dataSC.add(this.data);

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }
}
