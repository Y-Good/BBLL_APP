import 'package:get_storage/get_storage.dart';
import 'package:mvideo/models/public.dart';

class UserUtils {
  UserUtils._();

  static GetStorage _st = GetStorage();

  static User? userInfo() {
    return _st.read<User>('user');
  }
}
