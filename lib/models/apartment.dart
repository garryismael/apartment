import 'package:prestation/constants/service.dart';
import 'package:prestation/interfaces/service.dart';
import 'package:prestation/models/user.dart';

class Apartment implements IService<Apartment> {
  late int id;
  late User owner;
  late int pieces;
  late bool occupied;
  late String image;
  late int price;

  Apartment(
      this.id, this.owner, this.pieces, this.occupied, this.image, this.price);

  Apartment.init();

  @override
  Apartment fromJson(Map<String, dynamic> json) {
    return Apartment.getInstance(json);
  }

  @override
  List<Apartment> fromJsonList(List<dynamic> jsonList) {
    return Apartment.getListInstance(jsonList);
  }

  String getImageUrl() {
    return "https://$baseUrl/apartments/images/$image";
  }

  static Apartment getInstance(Map<String, dynamic> json) {
    User owner = User.getInstance(json['owner']);

    return Apartment(json['id'], owner, json['pieces'], json['occupied'],
        json['image'], json['price']);
  }

  static List<Apartment> getListInstance(List<dynamic> jsonList) {
    return jsonList.map((json) => Apartment.getInstance(json)).toList();
  }
}
