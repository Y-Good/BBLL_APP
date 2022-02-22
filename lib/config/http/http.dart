import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/public.dart';
import 'package:mvideo/models/base/base_response.dart';
import 'package:mvideo/utils/common/common_utils.dart';
import 'package:mvideo/utils/utils.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;
  final GetStorage? st = GetStorage();
  late Dio dio;

  HttpUtil._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: Server.host,
      // baseUrl: 'http://192.168.0.174:3000',
      connectTimeout: 10000,
      receiveTimeout: 5000,

      // Http请求头.
      headers: {
        'Authorization':
            isNotNull(st?.read('token')) ? 'Bearer ${st?.read('token')}' : null
      },
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
    dio = new Dio(options);
  }

  /// restful get 操作
  Future get(
    String path, {
    dynamic queryParameters,
    Options? options,
  }) async {
    try {
      var response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return BaseResponse.fromJson(response.data);
    } on DioError catch (error) {
      CommonUtils.toast(error.response?.data['message']);
    }
  }

  Future post(
    String path, {
    dynamic data,
    dynamic queryParameters,
    Options? options,
  }) async {
    try {
      var response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
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
