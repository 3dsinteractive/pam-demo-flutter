import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/widgets/categories/category_item.dart';

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

    widget.categoryRepository.fetch(isMock: true);
  }

  @override
  void dispose() {
    super.dispose();

    widget.categoryRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.categoryRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == true) {
          return Container();
        }

        return Container(
          alignment: Alignment.center,
          margin: widget.margin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              ((widget.categoryRepository.items?.length ?? 0) < 5
                  ? widget.categoryRepository.items!.length
                  : 5),
              (index) {
                return CategoryItem(
                  category: widget.categoryRepository.items![index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
