import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

  Rxn<Map> data = Rxn();

  Future<void> getProfileData() async {
    data.value = await FireDbHelper.fireDbHelper.getProfile();
  }
}
