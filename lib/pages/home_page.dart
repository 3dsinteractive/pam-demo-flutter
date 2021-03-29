import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/mocks/banners/banners.dart';
import 'package:singh_architecture/mocks/categories/categories.dart';
import 'package:singh_architecture/mocks/products/best_seller_products.dart';
import 'package:singh_architecture/mocks/products/new_arrival_products.dart';
import 'package:singh_architecture/pages/cookies_page.dart';
import 'package:singh_architecture/repositories/banner_repository.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/widgets/banners/banner_head_line.dart';
import 'package:singh_architecture/widgets/categories/category_head_line.dart';
import 'package:singh_architecture/widgets/commons/top_bar_search.dart';
import 'package:singh_architecture/widgets/products/product_head_line.dart';

class HomePage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final EdgeInsets? padding;

  HomePage({
    required this.context,
    required this.config,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late PageRepository pageRepository;
  late BannerRepository bannerRepository;
  late CategoryRepository categoryRepository;
  late ProductRepository newArrivalProductRepository;
  late ProductRepository bestSellerProductRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();

    Pam.trackPageView(
        url: "3dsflutter//home",
        title: widget.context.localeRepository().getString("home"));
    this.initialRepositories();
  }

  void initialRepositories() {
    try {
      this.bannerRepository = BannerRepository(
        buildCtx: this.context,
        config: widget.config,
        sharedPreferences: widget.context.sharedPreferences(),
        options: NewRepositoryOptions(
          baseUrl: "${widget.config.baseAPI()}/banners",
          mockItems: mockBanners,
        ),
      );
      this.categoryRepository = CategoryRepository(
        buildCtx: this.context,
        config: widget.config,
        sharedPreferences: widget.context.sharedPreferences(),
        options: NewRepositoryOptions(
          baseUrl: "${widget.config.baseAPI()}/categories",
          mockItems: mockCategories,
        ),
      );
      this.newArrivalProductRepository = ProductRepository(
        buildCtx: this.context,
        config: widget.config,
        sharedPreferences: widget.context.sharedPreferences(),
        options: NewRepositoryOptions(
          baseUrl: "${widget.config.baseAPI()}/products",
          mockItems: mockNewArrivalProducts,
        ),
      );
      this.bestSellerProductRepository = ProductRepository(
        buildCtx: this.context,
        config: widget.config,
        sharedPreferences: widget.context.sharedPreferences(),
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
    bool isTablet = MediaQuery.of(context).size.width >= 768;

    return Stack(
      children: [
        Container(
          padding: widget.padding,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              BannerHeadLine(
                margin: EdgeInsets.only(
                  top: (isTablet ? 125 : 85) +
                      MediaQuery.of(context).padding.top,
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
                title: widget.context
                    .localeRepository()
                    .getString("product_new_arrival"),
                productRepository: this.newArrivalProductRepository,
              ),
              ProductHeadLine(
                margin: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                context: widget.context,
                config: widget.config,
                title: widget.context
                    .localeRepository()
                    .getString("product_best_seller"),
                productRepository: this.bestSellerProductRepository,
              ),
            ],
          ),
        ),
        TopBarSearch(
          onSearch: (q) {},
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ScaffoldMiddleWare(
                  context: widget.context,
                  config: widget.config,
                  child: CookiesPage(
                    context: widget.context,
                    config: widget.config,
                  ),
                );
              }));
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: colorPrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
