import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/features/main_feature.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';

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

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ScaffoldMiddleWare(
            context: this.myContext,
            config: this.config,
            child: MainFeature(
              context: myContext,
              config: config,
            ),
          ),
        ),
      );

      widget.launchScreenRepository.toLoadedStatus();
    } catch (e) {
      widget.launchScreenRepository.toErrorStatus(e);
    }
  }

  @override
  void dispose() {
    super.dispose();

    widget.launchScreenRepository.dispose();
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
