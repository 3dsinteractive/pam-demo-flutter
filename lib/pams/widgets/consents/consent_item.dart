import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/models/consent_message_model.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/utils/time_helper.dart';
import 'package:singh_architecture/widgets/commons/switch_button.dart';

class ConsentItem extends StatefulWidget {
  final String title;
  final ConsentMessageSettingConsentDetailModel setting;

  ConsentItem({
    required this.title,
    required this.setting,
  });

  @override
  State<StatefulWidget> createState() {
    return ConsentItemState();
  }
}

class ConsentItemState extends State<ConsentItem> {
  late bool _isConsentExpand;
  late StreamController<bool> _isConsentExpandSC;

  late bool _isInnerConsentExpand;
  late StreamController<bool> _isInnerConsentExpandSC;

  @override
  void initState() {
    super.initState();

    _isConsentExpand = false;
    _isInnerConsentExpand = false;
    this._isConsentExpandSC = StreamController<bool>();
    this._isInnerConsentExpandSC = StreamController<bool>();

    this._isConsentExpandSC.add(this._isConsentExpand);
    this._isInnerConsentExpandSC.add(this._isInnerConsentExpand);
  }

  @override
  void dispose() {
    super.dispose();

    this._isConsentExpandSC.close();
    this._isInnerConsentExpandSC.close();
  }

  onConsentExpandClicked() {
    this._isConsentExpand = !this._isConsentExpand;
    this._isConsentExpandSC.add(this._isConsentExpand);

    if (this._isConsentExpand) {
      this.onInnerConsentExpandOpened();
    } else {
      this.onInnerConsentExpandClosed();
    }
  }

  Future<void> onInnerConsentExpandOpened() async {
    this._isInnerConsentExpand = !this._isInnerConsentExpand;
    this._isInnerConsentExpandSC.add(this._isInnerConsentExpand);
  }

  Future<void> onInnerConsentExpandClosed() async {
    await TimeHelper.sleep(milliseconds: 300);
    this._isInnerConsentExpand = !this._isInnerConsentExpand;
    this._isInnerConsentExpandSC.add(this._isInnerConsentExpand);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              this.onConsentExpandClicked();
            },
            child: Container(
              color: Colors.grey.shade300,
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: 16,
                right: 16,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.green,
                      size: 18,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: h6,
                          fontWeight: fontWeightBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<bool>(
            stream: this._isConsentExpandSC.stream,
            builder: (context, snapshot) {
              return AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: snapshot.data == true ? 1 : 0,
                child: StreamBuilder<bool>(
                  stream: this._isInnerConsentExpandSC.stream,
                  builder: (context, snapshot) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      height: snapshot.data == true ? null : 0,
                      child: Column(
                        children: [
                          Container(
                            child: Text(widget.setting.BriefDescription.TH),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Full Version",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: SwitchButton(
                                    title: "Accept",
                                    onChanged: (v){},
                                    buttonColor: Colors.white,
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
