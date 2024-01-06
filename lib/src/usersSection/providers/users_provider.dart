import 'package:flutter/cupertino.dart';
import 'package:saluwell_admin_panel/src/usersSection/services/userServices.dart';

class UsersProvider extends ChangeNotifier {
  UserServices userServices = UserServices();

  /// get Patient users
  getPatientUsers() async {
  //  pendingAppointmentList = await userServices.streamAllUsers();
  }
}
