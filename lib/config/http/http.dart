import 'package:dio/dio.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/base/base_response.dart';
import 'package:mvideo/utils/common/common_utils.dart';
import 'package:mvideo/utils/user_utils.dart';

class HttpUtil {
  HttpUtil._();
  static Dio _dio = Dio();
  static void initDio() async {
    String? token = UserUtils.getToken;
    _dio.options.baseUrl = Server.host;
    // xprint(token);
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
      CommonUtils.toast(error.response?.data['message'] ?? '请求失败');
    }
  }

  static Future post(String path,
      {dynamic data, dynamic queryParameters, Options? options}) async {
    try {
      initDio();
      var response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return BaseResponse.fromJson(response.data).data;
    } on DioError catch (error) {
      if (error.response != null) {
        return CommonUtils.toast(error.response?.data['message']);
      }
      throw error;
    }
  }
}
