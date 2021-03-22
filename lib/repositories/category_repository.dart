
import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/models/category_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

class CategoryRepository extends BaseDataRepository<CategoryModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;

  CategoryRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
  }) : super(buildCtx, config, options);

  @override
  List<CategoryModel> transforms(tss) {
    return CategoryModel.toList(tss);
  }

  @override
  CategoryModel? transform(ts) {
    return CategoryModel.fromJson(ts);
  }
}
