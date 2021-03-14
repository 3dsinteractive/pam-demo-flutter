import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/constants.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/pages/base_page.dart';
import 'package:singh_architecture/pages/product_page.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/common/top_bar_search.dart';

class MainFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  MainFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return MainFeatureState();
  }
}

class MainFeatureState extends State<MainFeature> {
  late PageRepository pageRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();
  }

  @override
  void dispose() {
    super.dispose();

    this.pageRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: colorPrimary,
          ),
          TopBarSearch(onSearch: (q) {}),
          Expanded(
            child: Container(
              child: BasePage(
                pageRepository: this.pageRepository,
                widgets: [
                  ProductPage(
                    context: widget.context,
                    config: widget.config,
                  ),
                  Container(
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: colorPrimary,
            padding: EdgeInsets.only(
              top: 12,
              bottom: 12 + MediaQuery.of(context).padding.bottom,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.context.localeRepository().getString(Locales.home),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: s,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.context.localeRepository().getString(Locales.cart),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: s,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.context.localeRepository().getString(Locales.notification),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: s,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.account_box_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.context.localeRepository().getString(Locales.account),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: s,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
