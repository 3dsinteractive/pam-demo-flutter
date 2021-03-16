// ignore_for_file: non_constant_identifier_names

class PamStandardSharePreferenceKey {
  PamStandardSharePreferenceKey._();

  static String get customer_id => "@pam_customer_id";

  static String get contact_id => "@_pam_contact_id";

  static String get login_contact_id => "@_pam_login_contact_id";

  static String get push_key => "@_pam_push_key";
}

class PamStandardEvent {
  PamStandardEvent._();

  static String get app_launch => "app_launch";

  static String get login => "login";

  static String get logout => "logout";

  static String get page_view => "page_view";

  static String get add_to_cart => "add_to_cart";

  static String get purchase_success => "purchase_success";

  static String get favourite => "favourite";

  static String get save_push => "save_push";

  static String get open_push => "open_push";
}

class PamStandardCallback {
  PamStandardCallback._();

  static String get on_token => "ontoken";

  static String get on_message => "onmessage";
}

class ITrackingQueue {
  final String eventName;
  final Map<String, dynamic> payload;
  final bool deleteLoginContactAfterPost;

  ITrackingQueue({
    required this.eventName,
    required this.payload,
    required this.deleteLoginContactAfterPost,
  });
}

class IPamResponse {
  final String? Code;
  final String? Message;
  final String? ContactId;

  IPamResponse({
    required this.Code,
    required this.Message,
    required this.ContactId,
  });

  factory IPamResponse.fromJson(Map<String, dynamic> rawJson) {
    return IPamResponse(
      Code: rawJson["code"],
      Message: rawJson["message"],
      ContactId: rawJson["contact_id"],
    );
  }
}
