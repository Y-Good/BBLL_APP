import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingUtil {
  static void showLoading({String? msg, bool dismissOnTap = false}) {
    EasyLoading.show(
      status: msg ?? "加载中...",
      dismissOnTap: dismissOnTap,
      maskType: EasyLoadingMaskType.clear,
    );
  }

  static void dismissLoading() {
    EasyLoading.dismiss();
  }

  static void progressLoading(double currentProgress) {
    EasyLoading.showProgress(currentProgress,
        status: '${(currentProgress * 100).toStringAsFixed(0)}%');
    if (currentProgress >= 1) {
      EasyLoading.dismiss();
    }
  }
}
