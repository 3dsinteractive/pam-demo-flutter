import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pam_flutter/models/consent_message_model.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/middlewares/scaffold_middle_ware.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/commons/loading_stack.dart';
import 'package:singh_architecture/widgets/commons/primary_button.dart';
import 'package:singh_architecture/widgets/commons/top_bar.dart';
import 'package:singh_architecture/widgets/commons/top_bar_customize.dart';

import 'launch_screen.dart';

class RegisterPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  RegisterPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  late bool? isAgree;
  ConsentMessageSettingModel? consentSetting;

  @override
  void initState() {
    super.initState();

    this.isAgree = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: LoadingStack(
        localeRepository: widget.context.localeRepository(),
        isLoadingSCs: [
          widget.context.repositories().authenticationRepository().isLoadingSC,
        ],
        children: () => [
          Container(
            margin: EdgeInsets.only(
              top: 16,
            ),
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
                  padding: EdgeInsets.only(
                    top: 48,
                    bottom: 48,
                    left: 24,
                    right: 24,
                  ),
                  decoration: BoxDecoration(
                    color: colorGrayLighter,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.context
                              .localeRepository()
                              .getString("user_name"),
                          style: TextStyle(
                            fontSize: h6,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: widget.context
                                .localeRepository()
                                .getString("user_name"),
                            errorStyle: TextStyle(height: 0),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 16, right: 16),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.context.localeRepository().getString("email"),
                          style: TextStyle(
                            fontSize: h6,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: widget.context
                                .localeRepository()
                                .getString("email"),
                            errorStyle: TextStyle(height: 0),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 16, right: 16),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.context
                              .localeRepository()
                              .getString("password"),
                          style: TextStyle(
                            fontSize: h6,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: widget.context
                                .localeRepository()
                                .getString("password"),
                            errorStyle: TextStyle(height: 0),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 16, right: 16),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ชื่อจริง",
                          style: TextStyle(
                            fontSize: h6,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "ชื่อจริง",
                            errorStyle: TextStyle(height: 0),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 16, right: 16),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "นามสกุล",
                          style: TextStyle(
                            fontSize: h6,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "นามสกุล",
                            errorStyle: TextStyle(height: 0),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 16, right: 16),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "เบอร์โทร",
                          style: TextStyle(
                            fontSize: h6,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 32,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "เบอร์โทร",
                            errorStyle: TextStyle(height: 0),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorGrayLight,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 16, right: 16),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: this.isAgree,
                              onChanged: (value) async {
                                if(value == true) {
                                  this.consentSetting =
                                      await Pam.consentRequestView(
                                    context,
                                    Pam.contactingConsentId() ?? "",
                                    isSubmitTracking: false,
                                  );

                                  if (this.consentSetting != null) {
                                    if (this.consentSetting!.TermsAndConditions.IsAllowed == true && this.consentSetting!.PrivacyOverview.IsAllowed == true) {
                                      this.isAgree = true;
                                      widget.context
                                          .repositories()
                                          .authenticationRepository()
                                          .forceValueNotify();
                                    } else {
                                      this.isAgree = false;
                                      widget.context
                                          .repositories()
                                          .authenticationRepository()
                                          .forceValueNotify();
                                    }
                                  }
                                }else{
                                  this.isAgree = value;
                                  widget.context.repositories().authenticationRepository().forceValueNotify();
                                }
                              },
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  "I Agree to Privacy Policy.settings",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: s,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                this.consentSetting =
                                    await Pam.consentRequestView(
                                  context,
                                  Pam.contactingConsentId() ?? "",
                                  isSubmitTracking: false,
                                );

                                if (this.consentSetting != null) {
                                  if (this.consentSetting!.TermsAndConditions.IsAllowed == true && this.consentSetting!.PrivacyOverview.IsAllowed == true) {
                                    this.isAgree = true;
                                    widget.context
                                        .repositories()
                                        .authenticationRepository()
                                        .forceValueNotify();
                                  } else {
                                    this.isAgree = false;
                                    widget.context
                                        .repositories()
                                        .authenticationRepository()
                                        .forceValueNotify();
                                  }
                                }
                              },
                              child: Container(
                                child: Text(
                                  "Settings",
                                  style: TextStyle(
                                      color: colorPrimary,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PrimaryButton(
                        onClick: () async {
                          await widget.context.repositories().authenticationRepository().mockLogin();
                          await Pam.pdpaRepository(context).sendAllowConsentSettingWithConsentSetting(Pam.contactingConsentId() ?? "", this.consentSetting);

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
                        isDisabled: !(this.isAgree ?? false),
                        width: double.infinity,
                        textColor: Colors.white,
                        title: widget.context
                            .localeRepository()
                            .getString("register"),
                      ),
                    ],
                  ),
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
            title: widget.context.localeRepository().getString("register"),
          ),
        ],
      ),
    );
  }
}
