import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pam_flutter/pam_flutter.dart';
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
import 'package:singh_architecture/widgets/commons/loading_stack.dart';
import 'package:singh_architecture/widgets/commons/top_bar.dart';
import 'package:singh_architecture/widgets/products/product_add_to_cart.dart';
import 'package:singh_architecture/widgets/products/product_buy_now.dart';
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
  late bool addCartExpand;
  late bool buyNowExpand;

  @override
  void initState() {
    super.initState();

    this.productRepository = ProductRepository(
      buildCtx: this.context,
      config: widget.config,
      sharedPreferences: widget.context.sharedPreferences(),
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

    this.productRepository.get(widget.id, isMock: true).then((_) {
      Pam.trackPageView(
          url: "3dsflutter//products?id=${widget.id}",
          title: this.productRepository.data?.Title ??
              widget.context.localeRepository().getString("product_detail"));
    });
    this.addCartExpand = false;
    this.buyNowExpand = false;

    widget.context.repositories().cartRepository().fetch();
  }

  @override
  void dispose() {
    super.dispose();

    this.productRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 768;

    return Container(
      child: LoadingStack(
        localeRepository: widget.context.localeRepository(),
        isLoadingSCs: [
          this.productRepository.isLoadingSC,
          widget.context.repositories().cartRepository().isLoadingSC,
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
                            top: (isTablet ? 125 : 85) + MediaQuery.of(context).padding.top,
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
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: 2,
                                            bottom: 2,
                                            left: 6,
                                            right: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: colorSecondary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Text(
                                            "฿ ${this.productRepository.data?.Price.toString()}",
                                            style: TextStyle(
                                              height: 1,
                                              color: colorSecondary,
                                              fontSize: h6,
                                              fontWeight: fontWeightBold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: GestureDetector(
                                        onTap: () async {
                                          this.productRepository.toLoadingStatus();
                                          if(widget.context.repositories().authenticationRepository().isProductFavourite(widget.id)){
                                            await widget.context
                                                .repositories()
                                                .authenticationRepository()
                                                .mockUnFavourite(widget.id);
                                          }else{
                                            await widget.context
                                                .repositories()
                                                .authenticationRepository()
                                                .mockFavourite(widget.id);
                                          }
                                          this.productRepository.toLoadedStatus();
                                        },
                                        child: Icon(
                                          widget.context
                                                  .repositories()
                                                  .authenticationRepository()
                                                  .isProductFavourite(widget.id)
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
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
                            left: 8,
                            right: 8,
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
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: MediaQuery.of(context).padding.bottom,
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            this.addCartExpand = true;
                            widget.context
                                .repositories()
                                .cartRepository()
                                .forceValueNotify();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 4,
                              bottom: 16,
                            ),
                            padding: EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                            ),
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadius.circular(16),
                            ),
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
                                    widget.context
                                        .localeRepository()
                                        .getString("add_to_cart"),
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
                        child: GestureDetector(
                          onTap: () {
                            this.buyNowExpand = true;
                            widget.context
                                .repositories()
                                .cartRepository()
                                .forceValueNotify();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 4,
                              bottom: 16,
                            ),
                            padding: EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                            ),
                            decoration: BoxDecoration(
                              color: colorSecondary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    widget.context
                                        .localeRepository()
                                        .getString("buy_now"),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            bottom:
                this.addCartExpand ? 0 : (-MediaQuery.of(context).size.height),
            left: 0,
            child: ProductAddToCart(
              product: this.productRepository.data,
              cartRepository: widget.context.repositories().cartRepository(),
              onAddToCart: (id, quantity) {
                widget.context
                    .repositories()
                    .cartRepository()
                    .mockAddToCart(id, quantity: quantity)
                    .then((_) {
                  this.addCartExpand = false;
                  Pam.trackAddToCart(
                    id: this.productRepository.data!.Id,
                    title: this.productRepository.data!.Title,
                    price: this.productRepository.data!.Price,
                    quantity: quantity,
                  );
                });
              },
              dismiss: () {
                this.addCartExpand = false;
                widget.context
                    .repositories()
                    .cartRepository()
                    .forceValueNotify();
              },
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            bottom:
                this.buyNowExpand ? 0 : (-MediaQuery.of(context).size.height),
            left: 0,
            child: ProductBuyNow(
              product: this.productRepository.data,
              cartRepository: widget.context.repositories().cartRepository(),
              onBuyNow: (id, quantity) {
                widget.context
                    .repositories()
                    .cartRepository()
                    .mockBuyNow(id, quantity: quantity)
                    .then((_) {
                  this.buyNowExpand = false;
                  Pam.trackPurchaseSuccess(
                    ids: [id],
                    titles: [this.productRepository.data!.Title],
                    categories: ["c01"],
                    totalPrice: this.productRepository.data!.Price * quantity,
                  );
                });
              },
              dismiss: () {
                this.buyNowExpand = false;
                widget.context
                    .repositories()
                    .cartRepository()
                    .forceValueNotify();
              },
            ),
          ),
          TopBar(
            title: this.productRepository.data?.Title ?? widget.context.localeRepository().getString("product_detail"),
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
                      checkoutPadding: EdgeInsets.only(
                        top: 16,
                        bottom: 16 + MediaQuery.of(context).padding.bottom,
                        left: 24,
                        right: 24,
                      ),
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
