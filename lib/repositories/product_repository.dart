import 'dart:convert';
import 'package:http/http.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/models/product_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/requester.dart';

class ProductRepository extends BaseDataRepository<ProductModel> {
  final IConfig config;
  final IRepositoryOptions options;

  ProductRepository({
    required this.config,
    required this.options,
  }) : super(config, options);

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
        data = {"items": this.options.getMockItems()};
      } else {
        Response response = await Requester.get(this.options.getBaseUrl(), params);
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = js;
      }

      this.items = ProductModel.toList(data["items"]);
      this.itemsSC.add(this.items);

      this.toLoadedStatus();
    } catch (e) {
      this.toErrorStatus(e);
    }
  }
}
