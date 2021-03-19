import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/mocks/products/best_seller_products.dart';
import 'package:singh_architecture/mocks/products/new_arrival_products.dart';
import 'package:singh_architecture/mocks/products/products.dart';
import 'package:singh_architecture/pages/product_detail_page.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/product_repository_infinite.dart';
import 'package:singh_architecture/widgets/commons/top_bar_search.dart';
import 'package:singh_architecture/widgets/products/product_item.dart';
import 'package:singh_architecture/widgets/products/product_item_loading.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProductsPage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final String? tag;

  ProductsPage({
    required this.context,
    required this.config,
    this.tag,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage> {
  late final ProductRepositoryInfinite productRepository;
  GlobalKey<State> gKey = new GlobalKey();

  @override
  void initState() {
    super.initState();

    this.productRepository = ProductRepositoryInfinite(
      buildCtx: this.context,
      config: widget.config,
      options: NewRepositoryOptions(
        baseUrl: "${widget.config.baseAPI()}/products",
        mockItems: [
          ...mockProducts,
          ...mockNewArrivalProducts,
          ...mockBestSellerProducts
        ],
      ),
    );

    this.productRepository.fetchAfterId("", isMock: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
              padding: EdgeInsets.only(
                top: 85 + MediaQuery.of(context).padding.top + 8,
              ),
              child: ListView(
                children: [
                  StreamBuilder<bool>(
                      stream: this.productRepository.isLoadingSC.stream,
                      builder: (context, snapshot) {
                        return Container(
                          padding: EdgeInsets.only(
                            left: 4,
                            right: 4,
                          ),
                          child: Wrap(
                            children: [
                              ...List.generate(
                                  (this.productRepository.items?.length ?? 0),
                                  (index) {
                                return Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          8,
                                  padding: EdgeInsets.all(4),
                                  height: 250,
                                  child: ProductItem(
                                    height: 150,
                                    width: 150,
                                    product:
                                        this.productRepository.items![index],
                                    onClick: (String id) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (context) {
                                        return ScaffoldMiddleWare(
                                            context: widget.context,
                                            config: widget.config,
                                            child: ProductDetailPage(
                                                context: widget.context,
                                                config: widget.config,
                                                id: id));
                                      }));
                                    },
                                  ),
                                );
                              }),
                              ...List.generate(4, (index) {
                                if (index == 0) {
                                  return Container(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        8,
                                    padding: EdgeInsets.all(4),
                                    height: 250,
                                    child: VisibilityDetector(
                                      key: gKey,
                                      onVisibilityChanged: (info) {
                                        if ((info.visibleFraction * 100) > 75) {
                                          if (this
                                              .productRepository
                                              .isLoaded) {
                                            this.productRepository.fetchAfterId("");
                                          }
                                        }
                                      },
                                      child: ProductItemLoading(
                                        height: 150,
                                        width: 150,
                                      ),
                                    ),
                                  );
                                }

                                return Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          8,
                                  padding: EdgeInsets.all(4),
                                  height: 250,
                                  child: ProductItemLoading(
                                    height: 150,
                                    width: 150,
                                  ),
                                );
                              }),
                            ],
                          ),
                        );
                      }),
                ],
              )),
          TopBarSearch(
            prefixWidget: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            postfixWidget: GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.centerRight,
                height: 85,
                child: Container(
                  padding: EdgeInsets.only(
                    right: 16,
                  ),
                  child: Icon(
                    Icons.filter_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            onSearch: (q) {},
          ),
        ],
      ),
    );
  }
}
