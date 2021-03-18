import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/widgets/commons/cached_image.dart';

class ProductSlider extends StatefulWidget {
  final List<String> imageURLs;

  ProductSlider({
    required this.imageURLs,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductSliderState();
  }
}

class ProductSliderState extends State<ProductSlider> {
  late StreamController<int> currentPageSC;

  @override
  void initState() {
    super.initState();

    this.currentPageSC = StreamController<int>();
    this.currentPageSC.add(0);
  }

  @override
  void dispose() {
    super.dispose();
    this.currentPageSC.close();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.width > 300 ? 300 : MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: PageView.builder(
            onPageChanged: (currentPage) {
              this.currentPageSC.add(currentPage);
            },
            itemCount: (widget.imageURLs.length > 7 ? 7 : widget.imageURLs.length),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                child: CachedImage(
                  image: widget.imageURLs[index],
                  fit: BoxFit.scaleDown,
                ),
              );
            },
          ),
        ),
        StreamBuilder<int>(
          stream: this.currentPageSC.stream,
          builder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.only(
                bottom: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate((widget.imageURLs.length > 7 ? 7 : widget.imageURLs.length), (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    margin: EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == snapshot.data ? colorPrimary : colorGray,
                    ),
                  );
                }),
              ),
            );
          },
        )
      ],
    );
  }
}
