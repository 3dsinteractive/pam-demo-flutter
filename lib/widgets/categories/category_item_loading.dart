import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/repositories/locale_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class CategoryItemLoading extends StatefulWidget {
  final LocaleRepository localeRepository;

  CategoryItemLoading({
    required this.localeRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return CategoryItemLoadingState();
  }
}

class CategoryItemLoadingState extends State<CategoryItemLoading> {
  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 768;
    final double categoryWidth = ((MediaQuery.of(context).size.width) - 32) / (isTablet ? 8 : 5);

    return Container(
      width: categoryWidth - 8,
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: categoryWidth - 8,
            width: categoryWidth - 8,
            margin: EdgeInsets.only(
              bottom: 4,
            ),
            decoration: BoxDecoration(
              color: colorPrimaryLighter,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            child: Text(
              widget.localeRepository.getString("loading"),
              style: TextStyle(
                fontSize: s3,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
