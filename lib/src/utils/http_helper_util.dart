import 'package:common_utils_v2/common_utils_v2.dart';

class HttpHelperUtil {
  static String _baseurl = "https://475f3f65.cpolar.io";
  static String _baseWsUrl = "ws://6d944e11.cpolar.io/ws";

  late final Dio _dio = initDio();
  static final HttpHelperUtil _instance = HttpHelperUtil();

  static String get baseurl => _baseurl;

  static String get baseWsUrl => _baseWsUrl;

  static HttpHelperUtil get instance => _instance;

  static updateBaseUrl({String? baseurl, String? baseWsUrl}) {
    _baseurl = baseurl ?? "https://common-utils-v2.io";
    _baseWsUrl = baseWsUrl ?? "ws://common-utils-v2.io";
  }

  Dio initDio() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: _baseurl,
      sendTimeout: 5000,
      receiveTimeout: 5000,
    );
    Dio dio = Dio(baseOptions);
    // 添加拦截器
    dio.interceptors.add(DioInterceptor());
    return dio;
  }

  Future<Map<String, dynamic>> get(String url, {queryParameters, CancelToken? cancelToken}) {
    return _baseRequest("get", url, queryParameters: queryParameters);
  }

  Future<Map<String, dynamic>> post(String url, {queryParameters, data, CancelToken? cancelToken}) {
    return _baseRequest("post", url, queryParameters: queryParameters, data: data);
  }

  Future<Map<String, dynamic>> put(String url, {queryParameters, data, CancelToken? cancelToken}) {
    return _baseRequest("put", url, queryParameters: queryParameters, data: data);
  }

  Future<Map<String, dynamic>> delete(String url, {queryParameters, data, CancelToken? cancelToken}) {
    return _baseRequest("delete", url, queryParameters: queryParameters, data: data);
  }

  Future<Map<String, dynamic>> _baseRequest(String method, String url, {queryParameters, data, CancelToken? cancelToken}) async {
    Response<dynamic> response = await _dio.request(url, data: data, cancelToken: cancelToken, queryParameters: queryParameters, options: Options(method: method));
    return response.data as Map<String, dynamic>;
  }
}

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 添加token
    if (!options.path.contains("/login")) {
      String token = SpUtil.getValue("token") as String;
      Map<String, String> headers = {"Authorization": "Bearer " + token};
      options.headers.addAll(headers);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// 处理调用第三方API的异常情况(高德地图)
    if (response.requestOptions.path.contains(LocationUtil.gaoDeMapBaseUrl)) {
      handler.next(response);
      return;
    }

    ///  处理调用自己项目API的异常情况
    if (response.data["code"] != 200) {
      ToastUtil.show(response.data["message"]);
      return;
    }
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.e(err.toString(), err.error, err.stackTrace);
  }
}