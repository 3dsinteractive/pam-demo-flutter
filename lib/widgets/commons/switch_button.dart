import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class SwitchButton extends StatefulWidget {
  final void Function(bool value) onChanged;
  final String title;
  final Color? backgroundColor;
  final Color? buttonColor;
  final EdgeInsets? margin;
  final bool? defaultValue;

  SwitchButton({
    required this.onChanged,
    required this.title,
    this.backgroundColor,
    this.buttonColor,
    this.margin,
    this.defaultValue,
  });

  @override
  State<StatefulWidget> createState() {
    return SwitchButtonState();
  }
}

class SwitchButtonState extends State<SwitchButton> {
  late bool innerValue;

  @override
  void initState() {
    super.initState();

    this.innerValue = widget.defaultValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.innerValue = !this.innerValue;
        widget.onChanged(this.innerValue);
      },
      child: Container(
        child: Row(
          children: [
            AnimatedContainer(
              alignment: this.innerValue ? Alignment.centerRight : Alignment.centerLeft,
              duration: Duration(milliseconds: 250),
              margin: EdgeInsets.only(right: 8),
              width: 38,
              height: 25,
              padding: EdgeInsets.only(
                left: 4,
                right: 4,
              ),
              decoration: BoxDecoration(
                  color: this.innerValue ? widget.backgroundColor : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Container(
              width: 46,
              child: Text(
                this.innerValue ? "Accept" : "Decline",
                style: TextStyle(
                  fontSize: s,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
