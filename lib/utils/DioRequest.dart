import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/stores/tokenManager.dart';

class DioRequest {
  final _dio = Dio();
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstans.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstans.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstans.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstans.TIME_OUT);
    _addInterceptor();
  }
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          if (tokenManager.getToken().isNotEmpty) {
            request.headers = {
              "Authorization": "Bearer ${tokenManager.getToken()}",
            };
          }

          handler.next(request);
        },
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (error, handler) {
          // handler.reject(error);
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data["msg"] ?? " ",
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstans.SUCCESS_CODE) {
        return data["result"];
      }
      // throw Exception(data["msg"] ?? "加载数据异常");
      throw DioException(
        requestOptions: res.requestOptions,
        message: data["msg"] ?? "加载数据失败",
      );
    } catch (e) {
      // throw Exception(e);
      rethrow;
    }
  }
}

final dioRequest = DioRequest();
