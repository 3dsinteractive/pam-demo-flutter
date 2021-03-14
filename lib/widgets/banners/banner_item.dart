import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/models/banner_model.dart';
import 'package:singh_architecture/widgets/common/cached_image.dart';

class BannerItem extends StatefulWidget {
  final BannerModel? banner;

  BannerItem({
    required this.banner,
  });

  @override
  State<StatefulWidget> createState() {
    return BannerItemState();
  }
}

class BannerItemState extends State<BannerItem> {
  @override
  Widget build(BuildContext context) {
    return widget.banner != null
        ? CachedImage(
            image: widget.banner!.ImageURL,
          )
        : Container();
  }
}
