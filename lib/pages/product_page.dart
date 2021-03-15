import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/mocks/banners/banners.dart';
import 'package:singh_architecture/mocks/categories/categories.dart';
import 'package:singh_architecture/mocks/products/best_seller_products.dart';
import 'package:singh_architecture/mocks/products/new_arrival_products.dart';
import 'package:singh_architecture/repositories/banner_repository.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/utils/object_helper.dart';
import 'package:singh_architecture/widgets/banners/banner_head_line.dart';
import 'package:singh_architecture/widgets/categories/category_head_line.dart';
import 'package:singh_architecture/widgets/common/top_bar_search.dart';
import 'package:singh_architecture/widgets/products/product_head_line.dart';

class ProductPage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final EdgeInsets? padding;

  ProductPage({
    required this.context,
    required this.config,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductPageState();
  }
}

class ProductPageState extends State<ProductPage> {
  late PageRepository pageRepository;
  late BannerRepository bannerRepository;
  late CategoryRepository categoryRepository;
  late ProductRepository newArrivalProductRepository;
  late ProductRepository bestSellerProductRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.toLoadingStatus();

    this.initialRepositories();
  }

  @override
  void dispose() {
    super.dispose();

    this.pageRepository.dispose();
    this.bannerRepository.dispose();
    this.categoryRepository.dispose();
    this.newArrivalProductRepository.dispose();
    this.bestSellerProductRepository.dispose();
  }

  void initialRepositories() {
    try {
      this.bannerRepository = BannerRepository(
        config: widget.config,
        options: NewRepositoryOptions(
          baseUrl: "${widget.config.baseAPI()}/banners",
          mockItems: mockBanners,
        ),
      );
      this.categoryRepository = CategoryRepository(
        config: widget.config,
        options: NewRepositoryOptions(
          baseUrl: "${widget.config.baseAPI()}/categories",
          mockItems: mockCategories,
        ),
      );
      this.newArrivalProductRepository = ProductRepository(
        config: widget.config,
        options: NewRepositoryOptions(
          baseUrl: "${widget.config.baseAPI()}/products",
          mockItems: mockNewArrivalProducts,
        ),
      );
      this.bestSellerProductRepository = ProductRepository(
        config: widget.config,
        options: NewRepositoryOptions(
          baseUrl: "${widget.config.baseAPI()}/products",
          mockItems: mockBestSellerProducts,
        ),
      );

      this.pageRepository.toLoadedStatus();
    } catch (e) {
      this.pageRepository.toErrorStatus(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: this.pageRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        if (ObjectHelper.isSnapshotStateLoading(snapshot)) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }

        return Stack(
          children: [
            Container(
              padding: widget.padding,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  BannerHeadLine(
                    margin: EdgeInsets.only(
                      top: 85 + MediaQuery.of(context).padding.top,
                      bottom: 8,
                    ),
                    context: widget.context,
                    config: widget.config,
                    bannerRepository: this.bannerRepository,
                  ),
                  CategoryHeadLine(
                    margin: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    context: widget.context,
                    config: widget.config,
                    categoryRepository: this.categoryRepository,
                  ),
                  ProductHeadLine(
                    margin: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    context: widget.context,
                    config: widget.config,
                    title: "สินค้ามาใหม่",
                    productRepository: this.newArrivalProductRepository,
                  ),
                  ProductHeadLine(
                    margin: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    context: widget.context,
                    config: widget.config,
                    title: "สินค้าขายดี",
                    productRepository: this.bestSellerProductRepository,
                  ),
                ],
              ),
            ),
            TopBarSearch(
              onSearch: (q) {},
            )
          ],
        );
      },
    );
  }
}
