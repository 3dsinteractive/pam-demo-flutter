import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/product_repository.dart';

class ProductDetailPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  ProductDetailPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductDetailPageState();
  }
}

class ProductDetailPageState extends State<ProductDetailPage> {
  late ProductRepository productRepository;

  @override
  void initState() {
    super.initState();

    productRepository =
        widget.context.repositories().productRepository(widget.config);
    productRepository.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Product Detail"),
      ),
    );
  }
}
