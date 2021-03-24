import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/utils/object_helper.dart';
import 'package:singh_architecture/widgets/categories/category_item.dart';
import 'package:singh_architecture/widgets/categories/category_item_loading.dart';

class CategoryHeadLine extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final CategoryRepository categoryRepository;
  final EdgeInsets? margin;

  CategoryHeadLine({
    required this.context,
    required this.config,
    required this.categoryRepository,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return CategoryHeadLineState();
  }
}

class CategoryHeadLineState extends State<CategoryHeadLine> {
  @override
  void initState() {
    super.initState();

    widget.categoryRepository.toLoadingStatus();

    widget.categoryRepository.fetch(isMock: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.categoryRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        bool isTablet = MediaQuery.of(context).size.width >= 768;

        if (ObjectHelper.isSnapshotStateLoading(snapshot)) {
          return Container(
            alignment: Alignment.center,
            margin: widget.margin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate((isTablet ? 8 : 5), (index) {
                  return CategoryItemLoading(
                    localeRepository: widget.context.localeRepository(),
                  );
                },
              ),
            ),
          );
        }

        return Container(
          alignment: Alignment.center,
          margin: widget.margin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              ((widget.categoryRepository.items.length) < (isTablet ? 8 : 5)
                  ? widget.categoryRepository.items.length
                  : (isTablet ? 8 : 5)),
              (index) {
                return CategoryItem(
                  category: widget.categoryRepository.items[index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
