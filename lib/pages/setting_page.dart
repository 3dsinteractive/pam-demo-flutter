import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/accounts/account_list_tile.dart';
import 'package:singh_architecture/widgets/commons/loading_stack.dart';
import 'package:singh_architecture/widgets/commons/primary_button.dart';
import 'package:singh_architecture/widgets/commons/top_bar.dart';

class SettingPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  SettingPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [],
        children: () => [
          Container(
            padding: EdgeInsets.only(
              top: 85 + MediaQuery.of(context).padding.top,
            ),
            child: ListView(
              padding: EdgeInsets.only(
                top: 0,
                bottom: 64,
                left: 16,
                right: 16,
              ),
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: 48,
                    bottom: 48,
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(
                          bottom: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorPrimary,
                          ),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.account_circle,
                          color: colorPrimary,
                          size: h1,
                        ),
                      ),
                      Container(
                        child: Text(
                          "แก้ไข",
                          style: TextStyle(
                            fontSize: s,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AccountListTile(
                  title: "ชื่อผู้ใช้",
                  hintText: "vincenzo",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 24,
                  ),
                ),
                AccountListTile(
                  title: "เพศ",
                  hintText: "ชาย",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                ),
                AccountListTile(
                  title: "เบอร์โทร",
                  hintText: "0999993333",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                ),
                AccountListTile(
                  title: "วันเกิด",
                  hintText: "01-01-2540",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                ),
                AccountListTile(
                  title: "อีเมล์",
                  hintText: "vincenzo@gmail.com",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                ),
                AccountListTile(
                  title: "เปลี่ยนรหัสผ่าน",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    top: 24,
                    bottom: 48,
                  ),
                ),
                PrimaryButton(
                  title: "ออกจากระบบ",
                  backgroundColor: Colors.white,
                  borderColor: colorPrimary,
                  textColor: colorPrimary,
                  onClick: () {},
                ),
              ],
            ),
          ),
          TopBar(
            prefixWidget: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            title: "Setting",
          ),
        ],
      ),
    );
  }
}
