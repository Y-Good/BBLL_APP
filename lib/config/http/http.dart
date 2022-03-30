import 'package:dio/dio.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/base/base_response.dart';
import 'package:mvideo/utils/common_utils.dart';
import 'package:mvideo/utils/loading_util.dart';
import 'package:mvideo/utils/user_utils.dart';

class HttpUtil {
  HttpUtil._();
  static Dio _dio = Dio();
  static void initDio() async {
    String? token = UserUtils.getToken;
    _dio.options.baseUrl = Server.host;
    // xprint(token);
    _dio.options.connectTimeout = 8000;
    _dio.options.headers.addAll({
      'Accept': 'application/json',
      'Authorization': UserUtils.hasToken ? 'Bearer $token' : null
    });
  }

  /// restful get 操作
  static Future get(String path,
      {dynamic queryParameters, Options? options}) async {
    try {
      initDio();
      var response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return BaseResponse.fromJson(response.data).data;
    } on DioError catch (error) {
      if (error.response?.statusCode != 403) {
        LoadingUtil.dismissLoading();
        CommonUtils.toast(error.response?.data['message'] ?? '请求失败');
      }
      LoadingUtil.dismissLoading();
    }
  }

  static Future post(String path,
      {dynamic data, dynamic queryParameters, bool upload = false}) async {
    try {
      initDio();
      var response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          onSendProgress: upload
              ? (int progress, int total) {
                  Future.delayed(Duration(milliseconds: 1000)).then((value) {
                    final currentProgress = (progress / total);
                    LoadingUtil.progressLoading(currentProgress);
                  });
                }
              : null);
      return BaseResponse.fromJson(response.data).data;
    } on DioError catch (error) {
      if (error.response != null) {
        LoadingUtil.dismissLoading();
        return CommonUtils.toast(error.response?.data['message']);
      }
      throw error;
    }
  }
}
