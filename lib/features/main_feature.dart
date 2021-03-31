import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/constants.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/pages/account_page.dart';
import 'package:singh_architecture/pages/base_page.dart';
import 'package:singh_architecture/pages/cart_page.dart';
import 'package:singh_architecture/pages/home_page.dart';
import 'package:singh_architecture/pages/launch_screen.dart';
import 'package:singh_architecture/pages/notification_page.dart';
import 'package:singh_architecture/pages/register_page.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/utils/object_helper.dart';

class MainFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final int? initialPage;

  MainFeature({
    required this.context,
    required this.config,
    this.initialPage,
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
    this.pageRepository.jumpTo(widget.initialPage ?? 0);

    widget.context.repositories().cartRepository().fetch();
  }

  Future<void> toRegisterPage() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ScaffoldMiddleWare(
          context: widget.context,
          config: widget.config,
          child: RegisterPage(
            context: widget.context,
            config: widget.config,
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.context.localeRepository().isLoadingSC.stream,
      builder: (context, snapshot) {
        if (ObjectHelper.isSnapshotStateLoading(snapshot)) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(colorSecondary),
              ),
            ),
          );
        }

        return Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: BasePage(
                    pageRepository: this.pageRepository,
                    widgets: [
                      HomePage(
                        context: widget.context,
                        config: widget.config,
                      ),
                      CartPage(
                        onBack: () {
                          this.pageRepository.prevPage();
                        },
                        checkoutPadding: EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                          left: 24,
                          right: 24,
                        ),
                        context: widget.context,
                        config: widget.config,
                      ),
                      NotificationsPage(
                        context: widget.context,
                        config: widget.config,
                      ),
                      AccountPage(
                        context: widget.context,
                        config: widget.config,
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<int>(
                stream: this.pageRepository.pageIndexSC.stream,
                builder: (context, snapshot) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: colorGrayLight,
                              blurRadius: 4,
                              offset: Offset(0, -1))
                        ]),
                    padding: EdgeInsets.only(
                      top: 6,
                      bottom: 12 + MediaQuery.of(context).padding.bottom,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              this.pageRepository.jumpTo(0);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.home_filled,
                                      color:
                                      this.pageRepository.currentPage ==
                                          0
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.context
                                          .localeRepository()
                                          .getString(Locales.home),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: this
                                            .pageRepository
                                            .currentPage ==
                                            0
                                            ? colorPrimary
                                            : colorGrayDark,
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
                              this.pageRepository.jumpTo(1);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 50,
                                          child: Icon(
                                            Icons.shopping_cart,
                                            color: this
                                                .pageRepository
                                                .currentPage ==
                                                1
                                                ? colorPrimary
                                                : colorGrayDark,
                                          ),
                                        ),
                                        Positioned(
                                          top: -3,
                                          right: 1,
                                          child: StreamBuilder<bool>(
                                              stream: widget.context
                                                  .repositories()
                                                  .cartRepository()
                                                  .isLoadingSC
                                                  .stream,
                                              builder: (context, snapshot) {
                                                if (widget.context
                                                    .repositories()
                                                    .cartRepository()
                                                    .data
                                                    ?.Products
                                                    .length ==
                                                    0) {
                                                  return Container();
                                                }

                                                return Container(
                                                  alignment:
                                                  Alignment.center,
                                                  padding:
                                                  EdgeInsets.all(6),
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
                                                );
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.context
                                          .localeRepository()
                                          .getString(Locales.cart),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: this
                                            .pageRepository
                                            .currentPage ==
                                            1
                                            ? colorPrimary
                                            : colorGrayDark,
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
                              if (widget.context
                                  .repositories()
                                  .authenticationRepository()
                                  .isNotAuth) {
                                widget.context
                                    .repositories()
                                    .authenticationRepository()
                                    .showDialogLogin(
                                    localeRepository: widget.context
                                        .localeRepository(),
                                    callbackSuccess: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => ScaffoldMiddleWare(
                                              context: widget.context,
                                              config: widget.config,
                                              child: LaunchScreen(
                                                launchScreenRepository: PageRepository(),
                                              ),
                                            ),
                                          ),
                                              (route) => false);
                                    },
                                    onRegisterClick: () async {
                                      await this.toRegisterPage();
                                    });
                              } else {
                                this.pageRepository.jumpTo(2);
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.notifications,
                                      color:
                                      this.pageRepository.currentPage ==
                                          2
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.context
                                          .localeRepository()
                                          .getString(Locales.notification),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: this
                                            .pageRepository
                                            .currentPage ==
                                            2
                                            ? colorPrimary
                                            : colorGrayDark,
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
                            onTap: () async {
                              if (widget.context
                                  .repositories()
                                  .authenticationRepository()
                                  .isNotAuth) {
                                widget.context
                                    .repositories()
                                    .authenticationRepository()
                                    .showDialogLogin(
                                    localeRepository: widget.context
                                        .localeRepository(),
                                    callbackSuccess: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => ScaffoldMiddleWare(
                                              context: widget.context,
                                              config: widget.config,
                                              child: LaunchScreen(
                                                launchScreenRepository: PageRepository(),
                                              ),
                                            ),
                                          ),
                                              (route) => false);
                                    },
                                    onRegisterClick: () async {
                                      await this.toRegisterPage();
                                    });
                              } else {
                                this.pageRepository.jumpTo(3);
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.account_box,
                                      color:
                                      this.pageRepository.currentPage ==
                                          3
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.context
                                          .localeRepository()
                                          .getString(Locales.account),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: this
                                            .pageRepository
                                            .currentPage ==
                                            3
                                            ? colorPrimary
                                            : colorGrayDark,
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
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
