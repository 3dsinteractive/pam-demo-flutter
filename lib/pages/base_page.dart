import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/repositories/page_repository.dart';

class BasePage extends StatefulWidget {
  final BasePageRepository pageRepository;
  final List<Widget> widgets;
  final EdgeInsets? padding;

  BasePage({
    required this.pageRepository,
    required this.widgets,
    this.padding,
  });

  @override
  State<BasePage> createState() {
    return BasePageState();
  }
}

class BasePageState extends State<BasePage> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    this.scrollController = ScrollController();
    widget.pageRepository.pageIndexSC.stream.listen((int index) {
      this.scrollController.animateTo(
            index * MediaQuery.of(context).size.width,
            duration: Duration(milliseconds: 250),
            curve: Curves.ease,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: ListView(
        cacheExtent: MediaQuery.of(context).size.width * 4,
        controller: this.scrollController,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: widget.widgets.map((Widget w) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: w,
          );
        }).toList(),
      ),
    );
  }
}
