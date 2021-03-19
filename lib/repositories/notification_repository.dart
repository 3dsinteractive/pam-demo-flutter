import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/models/notification_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/requester.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class NotificationRepository extends BaseDataRepository<NotificationModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;

  NotificationRepository({
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

      this.items = NotificationModel.toList(data["items"]);
      this.itemsSC.add(this.items);

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }
}
