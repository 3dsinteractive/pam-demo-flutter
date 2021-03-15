import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/utils/array_helper.dart';

class LoadingStack extends StatefulWidget {
  final List<Widget> Function() children;
  final List<StreamController<bool>> isLoadingSCs;

  LoadingStack({
    required this.children,
    required this.isLoadingSCs,
  });

  @override
  State<StatefulWidget> createState() {
    return LoadingStackState();
  }
}

class LoadingStackState extends State<LoadingStack> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: Rx.combineLatest(widget.isLoadingSCs.map((s) => s.stream),
          (List<bool> values) => ArrayHelper.isAllFalse(values)),
      builder: (context, snapshot) {
        return Stack(
          children: [
            ...widget.children(),
            IgnorePointer(
              ignoring: snapshot.data == true,
              child: snapshot.data == false
                  ? Container(
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.25),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 100,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 16,
                              ),
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    colorSecondary),
                              ),
                            ),
                            Container(
                              child: Text("Loading"),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}
