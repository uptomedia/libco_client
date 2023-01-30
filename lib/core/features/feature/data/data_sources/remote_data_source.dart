import 'dart:convert';
import 'dart:io';

import 'package:chegg/core/app/state/appstate.dart';
import 'package:chegg/core/configurations/app_configuration.dart';
import 'package:chegg/core/exceptions/app_exceptions.dart';
import 'package:chegg/core/features/feature/data/models/params/params_model.dart';
import 'package:chegg/core/helper_functions.dart';
import 'package:chegg/injection_container.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

abstract class RemoteDataSource {
  // Client client = Client();
  final baseUrl = AppConfigurations.BaseUrl;
  var token;
  String? refreshToken;
  static final _dio = Dio(BaseOptions(
    receiveTimeout: 20000, // 15 seconds
    connectTimeout: 20000,
    sendTimeout: 20000,
  ));
  static final _tokenDio = Dio(BaseOptions(
    receiveTimeout: 20000, // 15 seconds
    connectTimeout: 20000,
    sendTimeout: 20000,
  ));

  Map<String, String> headers = {};
  Map<String, String> headersRefrsh = {};

  RemoteDataSource() {
    // add base headers
    // headers.addAll(AppConfigurations.BaseHeaders);
    // _dio.interceptors.add(InterceptorsWrapper(onRequest:
    //     (RequestOptions options, RequestInterceptorHandler handler) async {
    //   if (sl<AppStateModel>().userToken != null) {
    //     if (sl<AppStateModel>().isTokenExpired) {
    //       _dio.interceptors.requestLock.lock();
    //       var params = RefreshTokenParams(
    //           body: RefreshTokenParamsBody(
    //               refreshToken: sl<AppStateModel>().refreshToken ?? ""));
    //       // await refresh(params, params.body!).then((response) async {
    //       //   token = response["result"]["accessToken"];
    //       //   refreshToken = response["result"]["refreshToken"];
    //       //   int expiresIn = response["result"]["expiresIn"];
    //       //   await sl<AppStateModel>().refresh(token, refreshToken, expiresIn);
    //       // }).catchError((error, stackTrace) {
    //       //   if (error is DioError) {
    //       //     handler.reject(error, true);
    //       //   } else {
    //       //     throw error;
    //       //   }
    //       // }).whenComplete(() {
    //       //   _dio.interceptors.requestLock.unlock();
    //       // });
    //     }
    //     options.headers["Authorization"] =
    //         "Bearer ${sl<AppStateModel>().userToken}";
    //   }
    //   return handler.next(options);
    // }));
  }

  initTokenAndHeaders(headers) {
    // token header
    token = sl<AppStateModel>().userToken;
    refreshToken = sl<AppStateModel>().refreshToken;
    print('token :$token');
    // if (token != null) headers.addAll({"Authorization": "Bearer $token"});

    // other headers
    // this.headers.addAll(headers ?? {});

    print(headers);
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw new NoInternetException();
    }
  }

  Future<dynamic> get(ParamsModel model) async {
    var responseJson;

    try {
      initTokenAndHeaders(headers);
      await checkConnectivity();
      final url = model.baseUrl ?? baseUrl;
      print('get request url:${url + model.url.toString()}');
      print('get request url:${model.urlParams}');
      final Response response = await _dio.get(
        url + model.url.toString(),
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ),
        queryParameters: model.urlParams,
        //{
        // "MinDateTime": "Sun,25 Jul 2021 00:01:33",/api/Appointment/Update
        // "MaxDateTime": "Sun,25 Jul 2021 22:01:33"
        // }
      );
      responseJson = _returnResponse(response);
      print('get response: $responseJson');
    } on DioError catch (e) {
      print(e);
      if (e.response == null) throw NoInternetException();
      _returnResponse(e.response!);
    } catch (e) {
      throw e;
    }
    return responseJson;
  }


  Future<Map<String, dynamic>> post(ParamsModel model) async {
    var response;
    var responseJson;
    try {
      initTokenAndHeaders(headers);
      await checkConnectivity();
      print('post request body :${json.encode(model.body?.toJson() ?? '')}');
      // var formData = FormData.fromMap(model.body?.toJson() ?? {} );
      final url = model.baseUrl ?? baseUrl;
      response = await _dio.post(
        url + model.url.toString(),
        data: model.body!.toJson(),
        queryParameters: model.urlParams,
        options:
            Options(headers: this.headers, responseType: ResponseType.plain),
      );
      print("post request completed");

      if (response == null) throw FetchDataException();
//      responseJson = json.decode(response.body.toString());
      responseJson = _returnResponse(response);
      print('post response: $responseJson');
    } on DioError catch (e) {
      if (e.response == null) throw NoInternetException();
      _returnResponse(e.response!);
    } on Exception catch (e) {
      throw e;
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> delete(ParamsModel model) async {
    var response;
    var responseJson;
    try {
      initTokenAndHeaders(headers);
      await checkConnectivity();
      print('delete request body :${json.encode(model.body?.toJson() ?? '')}');
      // var formData = FormData.fromMap(model.body?.toJson() ?? {} );
      final url = model.baseUrl ?? baseUrl;
      response = await _dio.delete(
        url + model.url.toString(),
        data: model.body!.toJson(),
        queryParameters: model.urlParams,
        options: Options(
          headers: this.headers,
          //responseType: ResponseType.plain
        ),
      );
      if (response == null) throw FetchDataException();
//      responseJson = json.decode(response.body.toString());
      responseJson = _returnResponse(response);
      print('delete response: $responseJson');
    } on DioError catch (e) {
      if (e.response == null) throw NoInternetException();
      _returnResponse(e.response!);
    } on Exception catch (e) {
      throw e;
    }
    return responseJson;
  }

  _returnResponse(Response response) {
    var responseJson =
        response.toString().isEmpty ? null : json.decode(response.toString());

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseJson;
      case 400:
        if (responseJson["error"]["message"] == "Invalid refresh token.")
          throw SessionTimedOutException();
        throw InvalidInputException(
          message: responseJson["error"]["message"],
          //data: responseJson
        );
      case 409:
        throw InvalidInputException(
          message: responseJson["error"]["message"],
          //data: responseJson
        );

      case 401:
      case 403:
        throw UnauthorisedException(data: responseJson);
      case 404:
        throw NotFoundException(data: responseJson);
      case 400:
        throw BadRequestException(data: responseJson);
      case 500:
        throw ServerErrorException(data: responseJson);
      default:
        throw FetchDataException(
            message: AppHelperFunctions.inReleaseMode
                ? 'Unknown Error'
                : response.data.toString());
    }
  }

  Future<Map<String, dynamic>> uploadProfileUserImage(
      ParamsModel model, File file) async {
    var response;
    var responseJson;
    try {
      initTokenAndHeaders(headers);
      await checkConnectivity();
      // print('post request body :${json.encode(model.body?.toJson() ?? '')}');
      // var formData = FormData.fromMap(model.body?.toJson() ?? {} );
      final url = model.baseUrl ?? baseUrl;

      Map<String, String> headersImage = {};

      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromFileSync(file.path,
            filename: file.path.split("/").last,
            contentType: new MediaType(
                'image', file.path.split("/").last.split(".").last))
      });
      headersImage.addAll(headers);
      headersImage.addAll({"Content-Type": "multipart/form-data"});
      // var dio = new Dio();
      response = await _dio.post(
        url + model.url.toString(),
        data: formData, //model.body!.toJson(),
        //queryParameters: model.urlParams,
        options:
            Options(headers: headersImage, responseType: ResponseType.plain),
      );
//

      if (response == null) throw FetchDataException();
//      responseJson = json.decode(response.body.toString());
      responseJson = _returnResponse(response);
      print('post response: $responseJson');
    } on DioError catch (e) {
      if (e.response == null) throw NoInternetException();
      _returnResponse(e.response!);
    } on Exception catch (e) {
      throw e;
    }
    return responseJson;
  }
}
