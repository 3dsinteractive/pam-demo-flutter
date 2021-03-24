import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/shared_preferences.dart';
import 'package:singh_architecture/models/banner_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

class BannerRepository extends BaseDataRepository<BannerModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  BannerRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences);

  @override
  List<BannerModel> transforms(tss) {
    return BannerModel.toList(tss);
  }

  @override
  BannerModel? transform(ts) {
    return BannerModel.fromJson(ts);
  }
}
