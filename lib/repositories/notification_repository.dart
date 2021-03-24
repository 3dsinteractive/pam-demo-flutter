import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/shared_preferences.dart';
import 'package:singh_architecture/models/notification_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

class NotificationRepository extends BaseDataRepository<NotificationModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  NotificationRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences);

  @override
  List<NotificationModel> transforms(tss) {
    return NotificationModel.toList(tss);
  }

  @override
  NotificationModel? transform(ts) {
    return NotificationModel.fromJson(ts);
  }
}
