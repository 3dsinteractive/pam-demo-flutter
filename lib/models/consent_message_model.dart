// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class ConsentMessageLanguageModel {
  final String TH;
  final String EN;

  ConsentMessageLanguageModel({
    required this.TH,
    required this.EN,
  });

  factory ConsentMessageLanguageModel.fromJson(Map<String, dynamic> rawJson) {
    return ConsentMessageLanguageModel(
      TH: rawJson["th"] ?? "",
      EN: rawJson["en"] ?? "",
    );
  }
}

class ConsentMessageSettingConsentDetailModel {
  final ConsentMessageLanguageModel BriefDescription;
  final ConsentMessageLanguageModel FullDescription;
  final bool IsEnabled;
  final bool IsFullDescriptionEnabled;
  // final dynamic TrackingCollection;

  ConsentMessageSettingConsentDetailModel({
    required this.BriefDescription,
    required this.FullDescription,
    required this.IsEnabled,
    required this.IsFullDescriptionEnabled,
    // required this.TrackingCollection,
  });

  factory ConsentMessageSettingConsentDetailModel.fromJson(
      Map<String, dynamic>? rawJson) {
    return ConsentMessageSettingConsentDetailModel(
      BriefDescription: ConsentMessageLanguageModel.fromJson(
          Map<String, dynamic>.from(rawJson?["brief_description"] ?? {})),
      FullDescription: ConsentMessageLanguageModel.fromJson(
          Map<String, dynamic>.from(rawJson?["full_description"] ?? {})),
      IsEnabled: rawJson?["is_enabled"] ?? false,
      IsFullDescriptionEnabled: rawJson?["is_enabled"] ?? false,
      // TrackingCollection: {},
    );
  }
}

class ConsentMessageSettingMoreInfoModel {
  final ConsentMessageLanguageModel CustomURL;
  final ConsentMessageLanguageModel DisplayText;
  final bool IsCustomURLEnabled;

  ConsentMessageSettingMoreInfoModel({
    required this.CustomURL,
    required this.DisplayText,
    required this.IsCustomURLEnabled,
  });

  factory ConsentMessageSettingMoreInfoModel.fromJson(
      Map<String, dynamic> rawJson) {
    return ConsentMessageSettingMoreInfoModel(
      CustomURL: ConsentMessageLanguageModel.fromJson(
          Map<String, dynamic>.from(rawJson["custom_url"] ?? {})),
      DisplayText: ConsentMessageLanguageModel.fromJson(
          Map<String, dynamic>.from(rawJson["display_text"] ?? {})),
      IsCustomURLEnabled: rawJson["is_custom_url_enabled"],
    );
  }
}

class ConsentMessageSettingModel {
  final ConsentMessageLanguageModel AcceptButtonText;
  final ConsentMessageSettingConsentDetailModel AnalyticsCookies;
  final List<String> AvailableLanguages;
  final ConsentMessageLanguageModel ConsentDetailTitle;
  final String DefaultLanguage;
  final ConsentMessageLanguageModel DisplayText;
  final ConsentMessageSettingConsentDetailModel Email;
  final ConsentMessageSettingConsentDetailModel FacebookMessenger;
  final ConsentMessageSettingConsentDetailModel Line;
  final ConsentMessageSettingConsentDetailModel MarketingCookies;
  final ConsentMessageSettingConsentDetailModel MobileNotification;
  final ConsentMessageSettingMoreInfoModel MoreInfo;
  final ConsentMessageSettingConsentDetailModel NecessaryCookies;
  final ConsentMessageSettingConsentDetailModel PreferencesCookies;
  final ConsentMessageSettingConsentDetailModel PrivacyOverview;
  final double Revision;
  final ConsentMessageSettingConsentDetailModel SMS;
  final ConsentMessageSettingConsentDetailModel SocialMediaCookies;
  final ConsentMessageSettingConsentDetailModel TermsAndConditions;
  final double Version;

  ConsentMessageSettingModel({
    required this.AcceptButtonText,
    required this.AnalyticsCookies,
    required this.AvailableLanguages,
    required this.ConsentDetailTitle,
    required this.DefaultLanguage,
    required this.DisplayText,
    required this.Email,
    required this.FacebookMessenger,
    required this.Line,
    required this.MarketingCookies,
    required this.MobileNotification,
    required this.MoreInfo,
    required this.NecessaryCookies,
    required this.PreferencesCookies,
    required this.PrivacyOverview,
    required this.Revision,
    required this.SMS,
    required this.SocialMediaCookies,
    required this.TermsAndConditions,
    required this.Version,
  });

  factory ConsentMessageSettingModel.fromJson(Map<String, dynamic> rawJson) {
    return ConsentMessageSettingModel(
      AcceptButtonText:
          ConsentMessageLanguageModel.fromJson(Map<String, dynamic>.from(rawJson["accept_button_text"] ?? {})),
      AnalyticsCookies: ConsentMessageSettingConsentDetailModel.fromJson(
          rawJson["analytics_cookies"]),
      AvailableLanguages: rawJson["available_languages"],
      ConsentDetailTitle:
          ConsentMessageLanguageModel.fromJson(Map<String, dynamic>.from(rawJson["consent_detail_title"] ?? {})),
      DefaultLanguage: rawJson["default_language"],
      DisplayText:
          ConsentMessageLanguageModel.fromJson(Map<String, dynamic>.from(rawJson["display_text"] ?? {})),
      Email: ConsentMessageSettingConsentDetailModel.fromJson(rawJson["email"]),
      FacebookMessenger: ConsentMessageSettingConsentDetailModel.fromJson(
          rawJson["facebook_messenger"]),
      Line: ConsentMessageSettingConsentDetailModel.fromJson(rawJson["line"]),
      MarketingCookies: ConsentMessageSettingConsentDetailModel.fromJson(
          rawJson["marketing_cookies"]),
      MobileNotification: ConsentMessageSettingConsentDetailModel.fromJson(
          rawJson["mobile_notification"]),
      MoreInfo:
          ConsentMessageSettingMoreInfoModel.fromJson(rawJson["more_info"]),
      NecessaryCookies: ConsentMessageSettingConsentDetailModel.fromJson(
          rawJson["necessary_cookies"]),
      PreferencesCookies: ConsentMessageSettingConsentDetailModel.fromJson(
          rawJson["preferences_cookies"]),
      PrivacyOverview: ConsentMessageSettingConsentDetailModel.fromJson(
          rawJson["privacy_overview"]),
      Revision: double.parse(rawJson["revision"].toString()),
      SMS: ConsentMessageSettingConsentDetailModel.fromJson(rawJson["sms"]),
      SocialMediaCookies: ConsentMessageSettingConsentDetailModel.fromJson(
          rawJson["social_media_cookies"]),
      TermsAndConditions: ConsentMessageSettingConsentDetailModel.fromJson(
          rawJson["terms_and_conditions"]),
      Version: double.parse(rawJson["version"].toString()),
    );
  }
}

class ConsentMessageStyleConfigurationConsentDetailModel {
  final Color ButtonTextColor;
  final String PopupMainIcon;
  final Color PrimaryColor;
  final Color SecondaryColor;
  final Color TextColor;

  ConsentMessageStyleConfigurationConsentDetailModel({
    required this.ButtonTextColor,
    required this.PopupMainIcon,
    required this.PrimaryColor,
    required this.SecondaryColor,
    required this.TextColor,
  });

  factory ConsentMessageStyleConfigurationConsentDetailModel.fromJson(
      Map<String, dynamic> rawJson) {
    return ConsentMessageStyleConfigurationConsentDetailModel(
      ButtonTextColor: Color(int.parse(rawJson["button_text_color"].toString().replaceAll("#", "0xFF"))),
      PopupMainIcon: rawJson["primary_color"],
      PrimaryColor: Color(int.parse(rawJson["primary_color"].toString().replaceAll("#", "0xFF"))),
      SecondaryColor: Color(int.parse(rawJson["secondary_color"].toString().replaceAll("#", "0xFF"))),
      TextColor: Color(int.parse(rawJson["text_color"].toString().replaceAll("#", "0xFF"))),
    );
  }
}

class ConsentMessageStyleConfigurationModel {
  final Color BarBackgroundColor;
  final double BarBackgroundOpacityPercentage;
  final Color BarTextColor;
  final Color ButtonBackgroundColor;
  final Color ButtonTextColor;
  final ConsentMessageStyleConfigurationConsentDetailModel ConsentDetail;

  ConsentMessageStyleConfigurationModel({
    required this.BarBackgroundColor,
    required this.BarBackgroundOpacityPercentage,
    required this.BarTextColor,
    required this.ButtonBackgroundColor,
    required this.ButtonTextColor,
    required this.ConsentDetail,
  });

  factory ConsentMessageStyleConfigurationModel.fromJson(
      Map<String, dynamic> rawJson) {
    return ConsentMessageStyleConfigurationModel(
      BarBackgroundColor: Color(int.parse(rawJson["bar_background_color"].toString().replaceAll("#", "0xFF"))),
      BarBackgroundOpacityPercentage: double.parse(rawJson["bar_background_opacity_percentage"].toString()),
      BarTextColor: Color(int.parse(rawJson["bar_text_color"].toString().replaceAll("#", "0xFF"))),
      ButtonBackgroundColor: Color(int.parse(rawJson["button_background_color"].toString().replaceAll("#", "0xFF"))),
      ButtonTextColor: Color(int.parse(rawJson["button_text_color"].toString().replaceAll("#", "0xFF"))),
      ConsentDetail: ConsentMessageStyleConfigurationConsentDetailModel.fromJson(rawJson["consent_detail"]),
    );
  }
}

class ConsentMessageModel {
  final String Id;
  final String Type;
  final String Name;
  final String Description;
  final ConsentMessageSettingModel Setting;
  final ConsentMessageStyleConfigurationModel StyleConfiguration;
  final String CreatedDate;
  final String UpdatedDate;

  ConsentMessageModel({
    required this.Id,
    required this.Type,
    required this.Name,
    required this.Description,
    required this.Setting,
    required this.StyleConfiguration,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  factory ConsentMessageModel.fromJson(Map<String, dynamic> rawJson) {
    return ConsentMessageModel(
      Id: rawJson["consent_message_id"],
      Type: rawJson["consent_message_type"],
      Name: rawJson["name"],
      Description: rawJson["description"],
      Setting: ConsentMessageSettingModel.fromJson(rawJson["setting"]),
      StyleConfiguration: ConsentMessageStyleConfigurationModel.fromJson(rawJson["style_configuration"]),
      CreatedDate: rawJson["created_at"],
      UpdatedDate: rawJson["updated_at"],
    );
  }
}
