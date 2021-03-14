import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/products/product_item.dart';

class ProductHeadLine extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final EdgeInsets? margin;
  final String title;
  final ProductRepository productRepository;

  ProductHeadLine({
    required this.context,
    required this.config,
    required this.title,
    required this.productRepository,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductHeadLineState();
  }
}

class ProductHeadLineState extends State<ProductHeadLine> {
  @override
  void initState() {
    super.initState();

    widget.productRepository.fetch(isMock: true);
  }

  @override
  void dispose() {
    super.dispose();

    widget.productRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.productRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == true) {
          return Container();
        }

        return Container(
          padding: EdgeInsets.all(16),
          margin: widget.margin,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: h6,
                          color: colorPrimary,
                          fontWeight: fontWeightBold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "ดูเพิ่มเติม >",
                        style: TextStyle(
                          fontSize: s2,
                          color: colorGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.productRepository.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ProductItem(
                      product: widget.productRepository.items![index],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
