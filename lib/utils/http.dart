import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvideo/config/server/server.dart';
import 'package:mvideo/utils/utils.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;
  final GetStorage? st = GetStorage();
  late Dio dio;

  HttpUtil._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = new BaseOptions(
      // 请求基地址,可以包含子路径
      // baseUrl: Server.host,
      baseUrl:
          'https://www.fastmock.site/mock/660fba6a82ec2c0d81b0661a3eaacd9f',
      // baseUrl: 'http://192.168.0.174:3000',

      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,

      // Http请求头.
      headers: {
        'Authorization':
            isNotNull(st?.read('token')) ? 'Bearer ${st?.read('token')}' : null
      },

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    dio = new Dio(options);

    // // Cookie管理
    // CookieJar cookieJar = CookieJar();
    // dio.interceptors.add(CookieManager(cookieJar));
  }

  /// restful get 操作
  Future get(
    String path, {
    dynamic queryParameters,
    Options? options,
  }) async {
    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    return response.data;
  }

  // Future post(
  //   String path, {
  //   dynamic queryParameters,
  //   Options? options,
  // }) async {
  //   var response = await dio.post(
  //     path,
  //     queryParameters: queryParameters,
  //     options: options,
  //   );
  //   return response.data;
  // }
}
