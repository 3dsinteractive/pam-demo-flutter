import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/pages/launch_screen.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
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
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        localeRepository: widget.context.localeRepository(),
        isLoadingSCs: [
          widget.context.repositories().authenticationRepository().isLoadingSC,
        ],
        children: () => [
          Padding(
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
                          widget.context.localeRepository().getString("edit"),
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
                  title:
                      widget.context.localeRepository().getString("user_name"),
                  hintText: "vincenzo",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 24,
                  ),
                ),
                AccountListTile(
                  title: widget.context.localeRepository().getString("gender"),
                  hintText: "ชาย",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                ),
                AccountListTile(
                  title:
                      widget.context.localeRepository().getString("telephone"),
                  hintText: "0999993333",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                ),
                AccountListTile(
                  title: widget.context
                      .localeRepository()
                      .getString("birth_of_date"),
                  hintText: "01-01-2540",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                ),
                AccountListTile(
                  title: widget.context.localeRepository().getString("email"),
                  hintText: "vincenzo@gmail.com",
                  onClick: () {},
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                ),
                AccountListTile(
                  title: widget.context
                      .localeRepository()
                      .getString("change_password"),
                  onClick: () {},
                  margin: EdgeInsets.only(
                    top: 24,
                    bottom: 48,
                  ),
                ),
                PrimaryButton(
                  title: widget.context.localeRepository().getString("logout"),
                  backgroundColor: Colors.white,
                  borderColor: colorPrimary,
                  textColor: colorPrimary,
                  onClick: () async {
                    await widget.context
                        .repositories()
                        .authenticationRepository()
                        .mockLogout();

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => ScaffoldMiddleWare(
                            context: widget.context,
                            config: widget.config,
                            child: LaunchScreen(
                              launchScreenRepository: PageRepository(),
                            ),
                          ),
                        ),
                        (route) => false);
                  },
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
            title: widget.context.localeRepository().getString("setting"),
          ),
        ],
      ),
    );
  }
}
