abstract class IService<T> {
  List<T> fromJsonList(List<dynamic> listJson);
  T fromJson(Map<String, dynamic> json);
}
