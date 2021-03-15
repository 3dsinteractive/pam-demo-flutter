import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rxdart/rxdart.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/mocks/products/best_seller_products.dart';
import 'package:singh_architecture/mocks/products/new_arrival_products.dart';
import 'package:singh_architecture/mocks/products/product_detail.dart';
import 'package:singh_architecture/mocks/products/products.dart';
import 'package:singh_architecture/pages/cart_page.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/utils/object_helper.dart';
import 'package:singh_architecture/widgets/common/loading_stack.dart';
import 'package:singh_architecture/widgets/common/top_bar.dart';
import 'package:singh_architecture/widgets/products/product_slider.dart';

class ProductDetailPage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final String id;

  ProductDetailPage({
    required this.context,
    required this.config,
    required this.id,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductDetailPageState();
  }
}

class ProductDetailPageState extends State<ProductDetailPage> {
  late final ProductRepository productRepository;

  @override
  void initState() {
    super.initState();

    this.productRepository = ProductRepository(
      config: widget.config,
      options: NewRepositoryOptions(
        baseUrl: "${widget.config.baseAPI()}/products",
        mockItems: [
          ...mockProducts,
          ...mockNewArrivalProducts,
          ...mockBestSellerProducts
        ],
        mockItem: mockProductDetail,
      ),
    );

    this.productRepository.get(widget.id, isMock: true);
    widget.context.repositories().cartRepository().fetch();
  }

  @override
  void dispose() {
    super.dispose();

    this.productRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [
          this.productRepository.isLoadingSC,
          widget.context.repositories().cartRepository().isLoadingSC
        ],
        children: () => [
          Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 85 + MediaQuery.of(context).padding.top,
                          ),
                          child: ProductSlider(
                            imageURLs:
                                (this.productRepository.data?.Galleries ?? []),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 8,
                                ),
                                child: Text(
                                  this.productRepository.data?.Title ?? "",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: h3,
                                    fontWeight: fontWeightBold,
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          this.productRepository.data?.Price ==
                                                  null
                                              ? ""
                                              : "฿ ${this.productRepository.data?.Price}",
                                          style: TextStyle(
                                            fontSize: h5,
                                            fontWeight: fontWeightBold,
                                            color: colorSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Icon(
                                        Icons.favorite_outline,
                                        color: Colors.redAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            left: 16,
                            right: 16,
                          ),
                          child: Html(
                              data: this.productRepository.data?.Description ??
                                  ""),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            widget.context
                                .repositories()
                                .cartRepository()
                                .mockAddToCart(this.productRepository.data!.Id);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                            ),
                            color: colorPrimary,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    right: 8,
                                  ),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "เพิ่มลงรถเข็น",
                                    style: TextStyle(
                                      fontSize: h6,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          color: colorSecondary,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(),
                              Container(
                                child: Text(
                                  "ซื้อสินค้า",
                                  style: TextStyle(
                                    fontSize: h6,
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
          ),
          TopBar(
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
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ScaffoldMiddleWare(
                    context: widget.context,
                    config: widget.config,
                    child: CartPage(
                      context: widget.context,
                      config: widget.config,
                    ),
                  );
                }));
              },
              child: Container(
                height: 85,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        right: 16,
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 5,
                      child: widget.context
                                  .repositories()
                                  .cartRepository()
                                  .data
                                  ?.Products
                                  .length ==
                              0
                          ? Container()
                          : Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: colorSecondary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                widget.context
                                        .repositories()
                                        .cartRepository()
                                        .data
                                        ?.Products
                                        .length
                                        .toString() ??
                                    "0",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
