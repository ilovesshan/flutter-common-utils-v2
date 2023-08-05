import 'package:common_utils_v2/common_utils_v2.dart';

class HttpHelperUtil {
  static String _baseurl = "https://github.com/ilovesshan/flutter-common-utils-v2";
  static String _baseWsUrl = "ws://github.com/ilovesshan/flutter-common-utils-v2/ws";

  late final Dio _dio = initDio();
  static final HttpHelperUtil _instance = HttpHelperUtil();

  static String get baseurl => _baseurl;

  static String get baseWsUrl => _baseWsUrl;

  static HttpHelperUtil get instance => _instance;

  static updateBaseUrl({String? baseurl, String? baseWsUrl}) {
    _baseurl = baseurl ?? _baseurl;
    _baseWsUrl = baseWsUrl ?? _baseWsUrl;
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

  Future<BaseModel> get(String url, {queryParameters, CancelToken? cancelToken, bool needToken = false}) {
    return _baseRequest("get", url, queryParameters: queryParameters, needToken: needToken);
  }

  Future<BaseModel> post(String url, {queryParameters, data, CancelToken? cancelToken, bool needToken = false}) {
    return _baseRequest("post", url, queryParameters: queryParameters, data: data, needToken: needToken);
  }

  Future<BaseModel> put(String url, {queryParameters, data, CancelToken? cancelToken, bool needToken = false}) {
    return _baseRequest("put", url, queryParameters: queryParameters, data: data, needToken: needToken);
  }

  Future<BaseModel> delete(String url, {queryParameters, data, CancelToken? cancelToken, bool needToken = false}) {
    return _baseRequest("delete", url, queryParameters: queryParameters, data: data, needToken: needToken);
  }

  Future<BaseModel> _baseRequest(String method, String url, {queryParameters, data, CancelToken? cancelToken, bool needToken = false}) async {
    Map<String, dynamic> extra = { "needToken": needToken};
    Response<dynamic> response = await _dio.request(url, data: data, cancelToken: cancelToken, queryParameters: queryParameters, options: Options(method: method, extra: extra));
    BaseModel baseModel;
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.requestOptions.path.contains(LocationUtil.gaoDeMapBaseUrl)) {
        /// 处理调用第三方API的响应(高德地图)
        if(response.data != null){
          baseModel = BaseModel(code: 200, message: "请求成功", data: response.data);
        }else{
          baseModel = BaseModel(code: -1, message: "HttpError");
        }
      }else{
        /// 处理本项目API的响应
        try {
          baseModel = BaseModel.fromJson(response.data!);
        } catch (e) {
          Log.e(e);
          baseModel = BaseModel(code: -1, message: "HttpError");
        }
      }
    } else {
      baseModel = BaseModel(code: -1, message: "HttpError");
    }
    return baseModel;
  }
}

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if(options.extra["extra"] ?? false){
      // 添加token
      String token = SpUtil.getValue("token");
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
      ToastUtil.showToast(response.data["message"]);
      return;
    }
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.e(err.toString(), err.error, err.stackTrace);
  }
}
