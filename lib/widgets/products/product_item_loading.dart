import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class ProductItemLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductItemLoadingState();
  }
}

class ProductItemLoadingState extends State<ProductItemLoading> {
  bool animationFlag = false;
  late StreamController<bool> animationFlagSC;

  @override
  void initState() {
    super.initState();

    this.animationFlagSC = StreamController.broadcast();
    Timer.periodic(new Duration(milliseconds: 750), (timer) {
      if (!this.animationFlagSC.isClosed) {
        this.animationFlag = !this.animationFlag;
        this.animationFlagSC.add(this.animationFlag);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    this.animationFlagSC.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 8,
            ),
            height: 125,
            width: 125,
            child: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
          StreamBuilder<bool>(
              stream: this.animationFlagSC.stream,
              builder: (context, snapshot) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: (snapshot.data != null && snapshot.data == true)
                          ? [colorPrimaryLight, colorPrimaryLighter]
                          : [colorPrimaryLighter, colorPrimaryLight],
                      // colors: [colorSecondaryLight, colorSecondary],
                    ),
                  ),
                  height: 45,
                  width: 125,
                  child: Text(
                    "กำลังโหลด",
                    style: TextStyle(
                      color: Colors.transparent,
                      fontSize: h6,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
          StreamBuilder<bool>(
            stream: this.animationFlagSC.stream,
            builder: (context, snapshot) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: (snapshot.data != null && snapshot.data == true)
                        ? [colorSecondaryLight, colorSecondaryLighter]
                        : [colorSecondaryLighter, colorSecondaryLight],
                    // colors: [colorSecondaryLight, colorSecondary],
                  ),
                ),
                width: 125,
                child: Text(
                  "กำลังโหลด",
                  style: TextStyle(
                    color: Colors.transparent,
                    fontSize: p,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
