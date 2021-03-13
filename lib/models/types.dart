abstract class IBaseModel<T> {
  T innerFromJson(Map<String, dynamic> rawJson);
}
