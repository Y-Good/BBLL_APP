import 'package:get_storage/get_storage.dart';
import 'package:mvideo/models/public.dart';

class UserUtils {
  UserUtils._();

  static GetStorage _st = GetStorage();

  static User? get getUser {
    return _st.read<User>('user');
  }

  static String? get getToken {
    if (_st.hasData('token')) return _st.read('token');
    return null;
  }

  static saveToken(String token) {
    _st.write('token', token);
  }

  static saveUserInfo(User user) {
    _st.write('user', user);
  }

  static bool get hasToken {
    return _st.hasData('token');
  }
}
