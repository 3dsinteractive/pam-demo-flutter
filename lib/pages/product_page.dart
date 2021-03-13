import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/product_repository.dart';

class ProductPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  ProductPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return PagePageState();
  }
}

class PagePageState extends State<ProductPage> {
  late ProductRepository productRepository;

  @override
  void initState() {
    super.initState();

    productRepository = widget.context.repositories().productRepository(widget.config);
    productRepository.fetch(isMock: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: productRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == true) {
          return Container();
        }

        return Center(
          child: Container(
            child: ListView.builder(
              itemCount: productRepository.items!.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.blueAccent,
                  height: 100,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Text(productRepository.items![index].Title),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
