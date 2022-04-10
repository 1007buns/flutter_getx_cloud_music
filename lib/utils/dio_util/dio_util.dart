import 'package:dio/dio.dart';
import 'package:flutter_getx_cloud_music/config/server.dart';
import 'package:flutter_getx_cloud_music/utils/dio_util/dio_method.dart';

import 'dio_interceptors.dart';

class DioUtil {
  static DioUtil? _instance;
  static Dio _dio = Dio();
  Dio get dio => _dio;

  static const int CONNECT_TIMEOUT = 6 * 1000; // 连接超时时间
  static const int RECELIVE_TIMEOUT = 6 * 1000; // 响应超时时间

  DioUtil.internal() {
    _instance = this;
    _instance!._init();
  }
  factory DioUtil() => _instance ?? DioUtil.internal();

  /// 初始化
  _init() {
    // 初始化基本选项
    BaseOptions options = BaseOptions(
      baseUrl: SERVER_API_URL,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECELIVE_TIMEOUT,

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      /// 默认值是 `JSON`, 当响应头中content-type为'application/json'时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.plain,

      /// 请求的Content-Type，默认值是'application/json; charset=utf-8'.
      /// 如果您想以'application/x-www-form-urlencoded'格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'Headers.formUrlEncodedContentType',
    );

    // 初始化Dio
    _dio = Dio(options);

    /// 添加拦截器
    _dio.interceptors.add(DioInterceptors());
  }

  /// 取消请求token
  final CancelToken _cancelToken = CancelToken();

  void cancelRequest({CancelToken? token}) {
    token ?? _cancelToken.cancel('cancelled');
  }

  Future<T> request<T>(
    String path, {
    DioMethod method = DioMethod.get,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.head: 'head',
    };
    options ??= Options(method: _methodValues[method]);

    try {
      Response response;
      response = await _dio.request(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (e) {
      rethrow;
    }
  }
}
