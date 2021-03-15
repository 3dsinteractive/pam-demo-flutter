import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';

class CheckboxCircle extends StatefulWidget {
  final EdgeInsets? margin;

  CheckboxCircle({
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return CheckboxCircleState();
  }
}

class CheckboxCircleState extends State<CheckboxCircle> {
  late bool innerValue;
  late StreamController<bool> innerValueSC;

  @override
  void initState() {
    super.initState();

    this.innerValue = false;
    this.innerValueSC = StreamController();

    this.innerValueSC.add(this.innerValue);
  }

  @override
  void dispose() {
    super.dispose();

    this.innerValueSC.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.innerValue = !this.innerValue;
        this.innerValueSC.add(this.innerValue);
      },
      child: Container(
        margin: widget.margin,
        padding: EdgeInsets.all(4),
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: colorGrayLight),
          shape: BoxShape.circle,
        ),
        child: StreamBuilder<bool>(
          stream: this.innerValueSC.stream,
          builder: (context, snapshot) {
            return AnimatedContainer(
              duration: Duration(
                milliseconds: 100,
              ),
              decoration: BoxDecoration(
                color: (snapshot.data == true) ? colorSecondary : Colors.white,
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
    );
  }
}
