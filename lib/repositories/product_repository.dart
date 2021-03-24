import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/shared_preferences.dart';
import 'package:singh_architecture/models/product_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

class ProductRepository extends BaseDataRepository<ProductModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  ProductRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences);

  @override
  List<ProductModel> transforms(tss) {
    return ProductModel.toList(tss);
  }

  @override
  ProductModel? transform(ts) {
    return ProductModel.fromJson(ts);
  }
}
