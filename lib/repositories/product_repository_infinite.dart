import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/shared_preferences.dart';
import 'package:singh_architecture/models/product_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/object_helper.dart';

class ProductRepositoryInfinite extends BaseDataRepository<ProductModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  ProductRepositoryInfinite({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences);

  @override
  List<ProductModel> transforms(tss) {
    return ProductModel.toList(ObjectHelper.toListMapString(tss));
  }

  @override
  ProductModel? transform(ts) {
    return ProductModel.fromJson(ObjectHelper.toMapString(ts));
  }
}
