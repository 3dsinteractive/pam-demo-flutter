import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/models/banner_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/requester.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class BannerRepository extends BaseDataRepository<BannerModel> {
  final IConfig config;
  final IRepositoryOptions options;

  BannerRepository({
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
        await TimeHelper.sleep();
        data = {"items": this.options.getMockItems()};
      } else {
        Response response =
            await Requester.get(this.options.getBaseUrl(), params);
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = js;
      }

      this.items = BannerModel.toList(data["items"]);
      this.itemsSC.add(this.items);

      this.toLoadedStatus();
    } catch (e) {
      this.toErrorStatus(e);
    }
  }
}
