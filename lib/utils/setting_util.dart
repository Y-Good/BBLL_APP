import 'package:get_storage/get_storage.dart';

class SettingUtil {
  SettingUtil._();

  static GetStorage _st = GetStorage();

  static void autoPlay(bool auto) {
    _st.write('auto', auto);
  }

  static bool getAutoPlay() {
    return _st.read('auto');
  }
}
