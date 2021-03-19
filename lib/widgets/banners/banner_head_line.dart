import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/banner_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/utils/object_helper.dart';
import 'package:singh_architecture/widgets/banners/banner_item.dart';

class BannerHeadLine extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final EdgeInsets? margin;
  final BannerRepository bannerRepository;

  BannerHeadLine({
    required this.context,
    required this.config,
    required this.bannerRepository,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return BannerHeadLineState();
  }
}

class BannerHeadLineState extends State<BannerHeadLine> {
  late StreamController<int> currentPageSC;

  @override
  void initState() {
    super.initState();

    this.currentPageSC = StreamController<int>();
    this.currentPageSC.add(0);

    widget.bannerRepository.fetch(isMock: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.bannerRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        if (ObjectHelper.isSnapshotStateLoading(snapshot)) {
          return Container(
            margin: widget.margin,
            height: MediaQuery.of(context).size.width / 1.777777778,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorPrimaryLighter,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CircularProgressIndicator(),
            // child: BannerItemLoading(),
          );
        }

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: widget.margin,
              height: MediaQuery.of(context).size.width / 1.777777778,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PageView.builder(
                  onPageChanged: (currentPage) {
                    this.currentPageSC.add(currentPage);
                  },
                  itemCount: widget.bannerRepository.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return BannerItem(
                      banner: widget.bannerRepository.items?[index],
                    );
                  },
                ),
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
                      children: List.generate(
                          widget.bannerRepository.items?.length ?? 0, (index) {
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
                            color: index == snapshot.data
                                ? colorPrimary
                                : colorGray,
                          ),
                        );
                      }),
                    ),
                  );
                })
          ],
        );
      },
    );
  }
}
