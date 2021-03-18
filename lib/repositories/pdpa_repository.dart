import 'dart:convert';
import 'package:http/http.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/models/consent_message_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/requester.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class PDPARepository extends BaseDataRepository<ConsentMessageModel> {
  final IConfig config;
  final IRepositoryOptions options;

  PDPARepository({
    required this.config,
    required this.options,
  }) : super(config, options);

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
        data = {"data": this.options.getMockItem()};
      } else {
        Response response =
            await Requester.get(this.options.getBaseUrl(), params);
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = js;
      }

      this.data = ConsentMessageModel.fromJson(data["data"]);
      this.dataSC.add(this.data);

      this.toLoadedStatus();
    } catch (e) {
      this.toErrorStatus(e);
    }
  }
}
