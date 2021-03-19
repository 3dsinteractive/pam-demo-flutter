import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/pages/setting_page.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/accounts/account_list_tile.dart';
import 'package:singh_architecture/widgets/accounts/order_controller.dart';
import 'package:singh_architecture/widgets/commons/loading_stack.dart';
import 'package:singh_architecture/widgets/commons/top_bar_customize.dart';

class AccountPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  AccountPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return AccountPageState();
  }
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [],
        children: () => [
          Container(
            padding: EdgeInsets.only(
              top: 100 + MediaQuery.of(context).padding.top,
            ),
            child: ListView(
              padding: EdgeInsets.only(
                top: 40,
                left: 16,
                right: 16,
              ),
              children: [
                OrderController(
                  margin: EdgeInsets.only(
                    bottom: 48,
                  ),
                ),
                AccountListTile(
                    margin: EdgeInsets.only(
                      bottom: 6,
                    ),
                    icon: Icons.favorite_outline,
                    title: "รายการโปรด",
                    onClick: () {}),
                AccountListTile(
                    margin: EdgeInsets.only(
                      bottom: 6,
                    ),
                    icon: Icons.location_on_outlined,
                    title: "จัดการที่อยู่จัดส่ง",
                    onClick: () {}),
                AccountListTile(
                    margin: EdgeInsets.only(
                      bottom: 6,
                    ),
                    icon: Icons.question_answer_outlined,
                    title: "คำถามที่พบบ่อย",
                    onClick: () {}),
                AccountListTile(
                    margin: EdgeInsets.only(
                      bottom: 6,
                    ),
                    icon: Icons.rate_review_outlined,
                    title: "รีวิวของฉัน",
                    onClick: () {}),
              ],
            ),
          ),
          TopBarCustomize(
            height: 100,
            prefixWidget: Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(
                        right: 16,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "Singh",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: p,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            postfixWidget: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ScaffoldMiddleWare(
                      context: widget.context,
                      config: widget.config,
                      child: SettingPage(
                        context: widget.context,
                        config: widget.config,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(
                  right: 16,
                ),
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
