import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class BannerItemLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BannerItemLoadingState();
  }
}

class BannerItemLoadingState extends State<BannerItemLoading> {
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
    return StreamBuilder<bool>(
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
                  ? [colorPrimaryLight, colorPrimaryLighter]
                  : [colorPrimaryLighter, colorPrimaryLight],
            ),
          ),
        );
      }
    );
  }
}
