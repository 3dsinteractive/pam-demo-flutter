import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/pages/base_page.dart';
import 'package:singh_architecture/pages/product_detail_page.dart';
import 'package:singh_architecture/pages/product_page.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/styles/fonts.dart';

class ProductFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  ProductFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductFeatureState();
  }
}

class ProductFeatureState extends State<ProductFeature> {
  late PageRepository pageRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.white,
          ),
          Container(
            height: 60,
            color: Colors.white,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 0.5),
                    color: Colors.black12
                  )
                ],
              ),
              child: Text(
                "Product",
                style: TextStyle(
                  fontSize: h6,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: BasePage(
                pageRepository: PageRepository(),
                widgets: [
                  ProductPage(
                    context: widget.context,
                    config: widget.config,
                  ),
                  ProductDetailPage(
                    context: widget.context,
                    config: widget.config,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
