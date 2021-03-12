import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/repositories/page_repository.dart';

class BasePage extends StatefulWidget {
  final BasePageRepository pageRepository;
  final List<Widget> widgets;

  BasePage({
    required this.pageRepository,
    required this.widgets,
  });

  @override
  State<BasePage> createState() {
    return BasePageState();
  }
}

class BasePageState extends State<BasePage> {
  @override
  void initState() {
    super.initState();
    widget.pageRepository.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
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
