import 'package:common_utils_v2/common_utils_v2.dart';

class HttpHelperUtil {
  static String _baseurl = "https://github.com/ilovesshan/flutter-common-utils-v2";
  static String _baseWsUrl = "ws://github.com/ilovesshan/flutter-common-utils-v2/ws";

  static String _tokenKey = "Authorization";
  static String _tokenPrefix = "Bearer ";
  static String _tokenSpKey = "token";

  late final Dio _dio = initDio();
  static final HttpHelperUtil _instance = HttpHelperUtil();

  static HttpHelperUtil get instance => _instance;

  static String get baseurl => _baseurl;

  static String get baseWsUrl => _baseWsUrl;

  static String get tokenKey => _tokenKey;

  static String get tokenPrefix => _tokenPrefix;

  static String get tokenSpKey => _tokenSpKey;

  static updateBaseUrl({String? baseurl, String? baseWsUrl}) {
    _baseurl = baseurl ?? _baseurl;
    _baseWsUrl = baseWsUrl ?? _baseWsUrl;
  }

  static updateTokenKey({String? tokenKey, String? tokenPrefix, String? tokenSpKey}) {
    _tokenKey = tokenKey ?? _tokenKey;
    _tokenPrefix = tokenPrefix ?? _tokenPrefix;
    _tokenSpKey = tokenSpKey ?? _tokenSpKey;
  }

  Dio initDio() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: _baseurl,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );
    Dio dio = Dio(baseOptions);
    // 添加拦截器
    dio.interceptors.add(DioInterceptor());
    return dio;
  }

  /// GET
  Future<BaseModel> get(String url, {queryParameters, CancelToken? cancelToken, bool needToken = false, needLoading = false, String? loadingText}) {
    return _baseRequest("get", url, queryParameters: queryParameters, needToken: needToken, needLoading: needLoading, loadingText: loadingText);
  }

  /// POST
  Future<BaseModel> post(String url, {queryParameters, data, CancelToken? cancelToken, bool needToken = false, needLoading = false, String? loadingText}) {
    return _baseRequest(
      "post",
      url,
      queryParameters: queryParameters,
      data: data,
      needToken: needToken,
      needLoading: needLoading,
      loadingText: loadingText,
    );
  }

  /// PUT
  Future<BaseModel> put(String url, {queryParameters, data, CancelToken? cancelToken, bool needToken = false, needLoading = false, String? loadingText}) {
    return _baseRequest(
      "put",
      url,
      queryParameters: queryParameters,
      data: data,
      needToken: needToken,
      needLoading: needLoading,
      loadingText: loadingText,
    );
  }

  /// DELETE
  Future<BaseModel> delete(String url, {queryParameters, data, CancelToken? cancelToken, bool needToken = false, needLoading = false, String? loadingText}) {
    return _baseRequest(
      "delete",
      url,
      queryParameters: queryParameters,
      data: data,
      needToken: needToken,
      needLoading: needLoading,
      loadingText: loadingText,
    );
  }

  Future<BaseModel> _baseRequest(String method, String url, {queryParameters, data, CancelToken? cancelToken, bool needToken = false, bool needLoading = false, String? loadingText}) async {
    Map<String, dynamic> extra = {"needToken": needToken, "needLoading": needLoading, "loadingText": loadingText};
    Response<dynamic> response = await _dio.request(url, data: data, cancelToken: cancelToken, queryParameters: queryParameters, options: Options(method: method, extra: extra));
    BaseModel baseModel;
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.requestOptions.path.contains(LocationUtil.gaoDeMapBaseUrl)) {
        /// 处理调用第三方API的响应(高德地图)
        if (response.data != null) {
          baseModel = BaseModel(code: 200, message: "请求成功", data: response.data);
        } else {
          baseModel = BaseModel(code: -1, message: "HttpError");
        }
      } else {
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
    /// 开启Loading效果
    if (options.extra["needLoading"] ?? false) {
      LoadingUtil.showLoading(msg: options.extra["loadingText"] ?? "加载中...");
    }

    if (options.extra["needToken"] ?? false) {
      /// 添加token
      String token = SpUtil.getString(HttpHelperUtil.tokenSpKey);
      Map<String, String> headers = {HttpHelperUtil.tokenKey: HttpHelperUtil.tokenPrefix + token};
      options.headers.addAll(headers);
    }

    /// 打印请求日志
    Log.v(
        "请求日志：${options.baseUrl}${options.path} | ${options.method} | queryParameters: ${options.queryParameters.toString()} | data: ${options.data.toString()} | headers: ${options.headers
            .toString()}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// 关闭Loading
    if (response.requestOptions.extra["needLoading"] ?? false) {
      LoadingUtil.hideAllLoading();
    }

    /// 打印响应日志
    Log.v("响应日志：${response.requestOptions.baseUrl}${response.requestOptions.path} | data: ${response.data.toString()}");

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
    /// 关闭Loading
    if (err.requestOptions.extra["needLoading"] ?? false) {
      LoadingUtil.hideAllLoading();
    }
    Log.e(err.toString(), err.error, err.stackTrace);
    switch (err.type) {
      case DioErrorType.cancel:
        ToastUtil.showToast("取消请求");
        // return HttpException(code: -1, msg: 'request cancel');
        break;
      case DioErrorType.connectTimeout:
        ToastUtil.showToast("连接超时");
        // return HttpException(code: -1, msg: 'connect timeout');
        break;
      case DioErrorType.sendTimeout:
        ToastUtil.showToast("发送超时");
        // return HttpException(code: -1, msg: 'send timeout');
        break;
      case DioErrorType.receiveTimeout:
        ToastUtil.showToast("响应超时");
        // return HttpException(code: -1, msg: 'receive timeout');
        break;
      case DioErrorType.response:
        try {
          int statusCode = err.response?.statusCode ?? 0;
          switch (statusCode) {
            case 400:
            // return HttpException(code: statusCode, msg: 'Request syntax error');
              break;
            case 401:
              ToastUtil.showToast("暂无操作权限");
              // return HttpException(code: statusCode, msg: 'Without permission');
              break;
            case 403:
            // return HttpException(code: statusCode, msg: 'Server rejects execution');
              break;
            case 404:
              ToastUtil.showToast("404");
              // return HttpException(code: statusCode, msg: 'Unable to connect to server');
              break;
            case 405:
            // return HttpException(code: statusCode, msg: 'The request method is disabled');
              break;
            case 500:
              ToastUtil.showToast("请求失败,请稍后再试");
              // return HttpException(code: statusCode, msg: 'Server internal error');
              break;
            case 502:
              ToastUtil.showToast("请求失败,请稍后再试");
              // return HttpException(code: statusCode, msg: 'Invalid request');
              break;
            case 503:
              ToastUtil.showToast("请求失败,请稍后再试");
              // return HttpException(code: statusCode, msg: 'The server is down.');
              break;
            case 505:
              ToastUtil.showToast("请求失败,请稍后再试");
              // return HttpException(code: statusCode, msg: 'HTTP requests are not supported');
              break;
            default:
          }
        } on Exception catch (_) {
          ToastUtil.showToast("请求失败,请稍后再试");
          // return HttpException(code: -1, msg: 'unknow error');
          break;
        }
        break;
      default:
        ToastUtil.showToast("请求失败,请稍后再试");
        // return HttpException(code: -1, msg: error.message);
        break;
    }
  }
}
