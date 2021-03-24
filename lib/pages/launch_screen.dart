import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:pam_flutter/types.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/features/main_feature.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/pages/product_detail_page.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/services/app_notification_service.dart';

class LaunchScreen extends StatefulWidget {
  final BasePageRepository launchScreenRepository;

  LaunchScreen({
    required this.launchScreenRepository,
  });

  @override
  State<LaunchScreen> createState() {
    return LaunchScreenState();
  }
}

class LaunchScreenState extends State<LaunchScreen> {
  late IContext myContext;
  late IConfig config;
  ProductRepository? productRepository;

  @override
  void initState() {
    super.initState();

    this.config = Config();
    this.myContext = Context(
      buildCtx: this.context,
      config: config,
    );

    widget.launchScreenRepository.toLoadingStatus();
    this.initialConfig();
  }

  Future<void> initialConfig() async {
    try {
      await this.config.initial();
      await this.myContext.initial();
      await this.myContext.localeRepository().loadLocale();

      await AppNotificationService.initial();
      // await Pam.consentRequestView(this.context, Pam.trackingConsentId());

      Pam.appReady(
        context: context,
        initialMessage:
        (await FirebaseMessaging.instance.getInitialMessage())?.data,
        productProductDetail: (id) =>
            ProductDetailPage(
                context: this.myContext, config: this.config, id: id),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ScaffoldMiddleWare(
                context: this.myContext,
                config: this.config,
                child: MainFeature(
                  context: myContext,
                  config: config,
                ),
              ),
        ),
      );

      Pam.listen(PamStandardCallback.on_token, (ms) {
        // handler your logic here on pam token
        print("token receive = $ms");
      });
      Pam.listen(PamStandardCallback.on_message, (ms) {
        // handler your logic here on pam message when app is openning
      });
      Pam.listen(PamStandardCallback.on_message_opened, (ms) {
        // handler your logic here on pam message when app is opened after tap on notification
        String productId = ms["id"];
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ScaffoldMiddleWare(
                  context: this.myContext,
                  config: this.config,
                  child: ProductDetailPage(
                    context: myContext,
                    config: config,
                    id: productId,
                  ),
                ),
          ),
        );
      });

      await Pam.askNotificationPermission();

      widget.launchScreenRepository.toLoadedStatus();
    } catch (e) {
      widget.launchScreenRepository.toErrorStatus(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: widget.launchScreenRepository.isLoadingSC.stream,
        builder: (BuildContext context, snapshot) {
          return Center(
            child: Container(
              child: Icon(Icons.favorite),
            ),
          );
        },
      ),
    );
  }
}
