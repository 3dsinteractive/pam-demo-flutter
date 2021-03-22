import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/models/banner_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

class BannerRepository extends BaseDataRepository<BannerModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;

  BannerRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
  }) : super(buildCtx, config, options);

  @override
  List<BannerModel> transforms(tss) {
    return BannerModel.toList(tss);
  }

  @override
  BannerModel? transform(ts) {
    return BannerModel.fromJson(ts);
  }
}
