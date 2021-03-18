import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/mocks/pdpa/contacting_consent.dart';
import 'package:singh_architecture/models/consent_message_model.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/commons/primary_button.dart';
import 'package:singh_architecture/pams/widgets/consents/consent_item.dart';

class ConsentPage extends StatefulWidget {
  late final ConsentMessageModel consent;

  ConsentPage() {
    this.consent = ConsentMessageModel.fromJson(mockContactingConsentDetail);
  }

  @override
  State<StatefulWidget> createState() {
    return ConsentPageState();
  }
}

class ConsentPageState extends State<ConsentPage> {
  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom + 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 16,
                bottom: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      widget.consent.Name,
                      style: TextStyle(
                        color: widget.consent.StyleConfiguration.ConsentDetail
                            .PrimaryColor,
                        fontSize: 32,
                        fontWeight: fontWeightBold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Text(
                        isTablet ? widget.consent.Description : "",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                border: Border.all(
                                  color: widget.consent.StyleConfiguration
                                      .ConsentDetail.PrimaryColor,
                                )),
                            padding: EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              left: 8,
                              right: 8,
                            ),
                            child: Text(
                              "TH",
                              style: TextStyle(
                                color: widget.consent.StyleConfiguration
                                    .ConsentDetail.PrimaryColor,
                                fontWeight: fontWeightBold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                )),
                            padding: EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              left: 8,
                              right: 8,
                            ),
                            child: Text(
                              "EN",
                              style: TextStyle(
                                color: widget.consent.StyleConfiguration
                                    .ConsentDetail.PrimaryColor,
                                fontWeight: fontWeightBold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                !isTablet ? widget.consent.Description : "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: fontWeightBold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ConsentItem(
                        title: "Terms & Conditions",
                        setting: widget.consent.Setting.TermsAndConditions,
                      ),
                      ConsentItem(
                        title: "Privacy Overview",
                        setting: widget.consent.Setting.PrivacyOverview,
                      ),
                      ConsentItem(
                        title: "Necessary Cookies",
                        setting: widget.consent.Setting.NecessaryCookies,
                      ),
                      ConsentItem(
                        title: "Preferences Cookies",
                        setting: widget.consent.Setting.PreferencesCookies,
                      ),
                      ConsentItem(
                        title: "Analytics Cookies",
                        setting: widget.consent.Setting.AnalyticsCookies,
                      ),
                      ConsentItem(
                        title: "Marketing Cookies",
                        setting: widget.consent.Setting.MarketingCookies,
                      ),
                      ConsentItem(
                        title: "Social Media Cookies",
                        setting: widget.consent.Setting.SocialMediaCookies,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                    onClick: () {},
                    title: "Save Setting",
                    textColor: Colors.white,
                    backgroundColor: widget
                        .consent.StyleConfiguration.ConsentDetail.PrimaryColor,
                    margin: EdgeInsets.only(right: 12),
                  ),
                  PrimaryButton(
                    onClick: () {},
                    title: "Accept All",
                    icon: Icons.check_circle,
                    textColor: Colors.white,
                    backgroundColor: widget.consent.StyleConfiguration
                        .ConsentDetail.SecondaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
