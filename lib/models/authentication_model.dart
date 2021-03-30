// ignore_for_file: non_constant_identifier_names

class LoginResponseModel {
  final String CustomerId;

  LoginResponseModel({
    required this.CustomerId,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic>? rawJson) {
    return LoginResponseModel(
      CustomerId: rawJson?["customer_id"] ?? "",
    );
  }

  static List<LoginResponseModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<LoginResponseModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(LoginResponseModel.fromJson(rawItems[i]));
    }

    return items;
  }
}

class RegisterResponseModel {
  final String CustomerId;
  final String Email;

  RegisterResponseModel({
    required this.CustomerId,
    required this.Email,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic>? rawJson) {
    return RegisterResponseModel(
      CustomerId: rawJson?["customer_id"] ?? "",
      Email: rawJson?["email"] ?? "",
    );
  }

  static List<RegisterResponseModel> toList(
      List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<RegisterResponseModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(RegisterResponseModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
