import 'package:pigeon/pigeon.dart';

class PersonName {
  String? firstName;
  String? lastName;
}

@HostApi()
abstract class PersonNameManagerApi {
  List<PersonName> getPersonNames();
  bool savePersonName(String firstName, String lastName);
  void clearPersonNames();
}
