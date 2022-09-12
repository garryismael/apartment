import 'package:prestation/constants/service.dart';
import 'package:prestation/interfaces/service.dart';

class User implements IService<User> {
  late int id;
  late String firstName;
  late String lastName;
  late String image;
  late String email;
  late String phone;
  late bool isAdmin;

  User(this.id, this.firstName, this.lastName, this.image, this.email,
      this.phone, this.isAdmin);

  User.init();

  static User getInstance(Map<String, dynamic> data) {
    return User(data['id'], data['first_name'], data['last_name'],
        data['image'], data['email'], data['phone'], data['is_admin']);
  }

  static List<User> getListInstance(List<dynamic> jsonList) {
    return jsonList.map((json) => User.getInstance(json)).toList();
  }

  String getImageUrl() {
    return "https://$baseUrl/users/images/$image";
  }

  @override
  User fromJson(Map<String, dynamic> json) {
    return getInstance(json);
  }

  @override
  List<User> fromJsonList(List listJson) {
    return User.getListInstance(listJson);
  }
}
