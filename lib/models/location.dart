import 'package:prestation/models/apartment.dart';
import 'package:prestation/models/user.dart';

class Location {
  int id;
  User renter;
  Apartment apartment;
  DateTime date;
  Location(this.id, this.renter, this.apartment, this.date);
}
