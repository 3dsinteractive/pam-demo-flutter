import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:pam_flutter/types.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/pages/launch_screen.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/commons/loading_stack.dart';
import 'package:singh_architecture/widgets/commons/primary_button.dart';
import 'package:singh_architecture/widgets/commons/top_bar.dart';

class CookiesPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  CookiesPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return CookiesPageState();
  }
}

class CookiesPageState extends State<CookiesPage> {
  String getRefreshConsentCoolDown() {
    int? expire = widget.context.sharedPreferences().getInt(
        "${PamStandardSharePreferenceKey.latest_refresh_consent_status}_${Pam.trackingConsentId()}");
    if (expire == null) {
      return "null";
    }

    double coolDown = (Pam.refreshExpireDuration() - (DateTime.now().millisecondsSinceEpoch - expire)) / (1000);
    return "$coolDown seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        localeRepository: widget.context.localeRepository(),
        isLoadingSCs: [
          widget.context.repositories().authenticationRepository().isLoadingSC,
        ],
        children: () => [
          Container(
            padding: EdgeInsets.only(
              top: 85 + MediaQuery.of(context).padding.top,
            ),
            child: ListView(
              padding: EdgeInsets.only(
                top: 16,
                bottom: 64,
                left: 16,
                right: 16,
              ),
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Contact ID : ",
                          style: TextStyle(
                            fontSize: p,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.context.sharedPreferences().getString(
                                    PamStandardSharePreferenceKey.contact_id) ??
                                "null",
                            style: TextStyle(
                              fontSize: p,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Login Contact ID : ",
                          style: TextStyle(
                            fontSize: p,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.context.sharedPreferences().getString(
                                    PamStandardSharePreferenceKey
                                        .login_contact_id) ??
                                "null",
                            style: TextStyle(
                              fontSize: p,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Customer ID : ",
                          style: TextStyle(
                            fontSize: p,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.context.sharedPreferences().getString(
                                    PamStandardSharePreferenceKey
                                        .customer_id) ??
                                "null",
                            style: TextStyle(
                              fontSize: p,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Session ID : ",
                          style: TextStyle(
                            fontSize: p,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.context.sharedPreferences().getString(
                                    PamStandardSharePreferenceKey.session_id) ??
                                "null",
                            style: TextStyle(
                              fontSize: p,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Refresh consent in : ",
                          style: TextStyle(
                            fontSize: p,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            getRefreshConsentCoolDown(),
                            style: TextStyle(
                              fontSize: p,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  margin: EdgeInsets.only(
                    top: 64,
                  ),
                  onClick: () async {
                    // Clear cookies
                    await widget.context
                        .sharedPreferences()
                        .remove(PamStandardSharePreferenceKey.contact_id);
                    await widget.context
                        .sharedPreferences()
                        .remove(PamStandardSharePreferenceKey.login_contact_id);
                    await widget.context
                        .sharedPreferences()
                        .remove(PamStandardSharePreferenceKey.customer_id);
                    await widget.context
                        .sharedPreferences()
                        .remove(PamStandardSharePreferenceKey.session_id);
                    await widget.context.sharedPreferences().remove(
                        PamStandardSharePreferenceKey.session_expire_in_mils);
                    await widget.context.sharedPreferences().remove(
                        "${PamStandardSharePreferenceKey.latest_refresh_consent_status}_${Pam.trackingConsentId()}");
                    await widget.context.sharedPreferences().remove(
                        "${PamStandardSharePreferenceKey.latest_refresh_consent_status}_${Pam.contactingConsentId()}");

                    widget.context.repositories().authenticationRepository().forceValueNotify();

                    // show dialog that delete success
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete Cookies Success."),
                            content: Text("Redirecting to home page."),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return ScaffoldMiddleWare(
                          context: widget.context,
                          config: widget.config,
                          child: LaunchScreen(
                            launchScreenRepository: PageRepository(),
                          ));
                    }), (route) => false);
                  },
                  title: "Delete",
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
            title: "Cookies",
          ),
        ],
      ),
    );
  }
}
