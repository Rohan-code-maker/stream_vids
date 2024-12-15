import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_vids/data/app_exceptions.dart';
import 'package:stream_vids/data/network/base_api_services.dart';

class NetworkApiService extends BaseApiService {
  final dio = Dio();

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
        return throw Exception('Unauthorized');
      case 403:
        return throw Exception('Forbidden');
      case 404:
        throw InvalidUrlException("");
      case 500:
        throw ServerException("");
      default:
        throw FetchDataException(
            'Error occurred while communicating with the server with status code: ${response.statusCode}');
    }
  }

  @override
  Future deleteApi(String url) async{
    if (kDebugMode) {
      print(url);
    }

    dynamic responsejson;
    try {
      final response = await dio.delete(url).timeout(const Duration(seconds: 10));
      responsejson = returnResponse(response);
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioExceptionType.connectionError) {
        throw InternetException("");
      } else if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw RequestTimeout("");
      } else if (e.response != null) {
        // Handle API-related errors
        throw FetchDataException(
            "Server responded with status code ${e.response?.statusCode}: ${e.response?.data}");
      } else {
        // Handle other Dio errors
        throw FetchDataException(e.message);
      }
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
    return responsejson;
  }

  @override
  Future getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responsejson;
    try {
      final response = await dio.get(url).timeout(const Duration(seconds: 10));
      responsejson = returnResponse(response);
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioExceptionType.connectionError) {
        throw InternetException("");
      } else if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw RequestTimeout("");
      } else if (e.response != null) {
        // Handle API-related errors
        throw FetchDataException(
            "Server responded with status code ${e.response?.statusCode}: ${e.response?.data}");
      } else {
        // Handle other Dio errors
        throw FetchDataException(e.message);
      }
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
    return responsejson;
  }

  @override
  Future postApi(data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responsejson;

    try {
      final response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 10));
      responsejson = returnResponse(response);
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioExceptionType.connectionError) {
        throw InternetException("");
      } else if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw RequestTimeout("");
      } else if (e.response != null) {
        // Handle API-related errors
        throw FetchDataException(
            "Server responded with status code ${e.response?.statusCode}: ${e.response?.data}");
      } else {
        // Handle other Dio errors
        throw FetchDataException(e.message);
      }
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
    return responsejson;
  }

  @override
  Future putApi(data, String url) async{
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responsejson;
    try {
      final response = await dio.put(url, data: data).timeout(const Duration(seconds: 10));
      responsejson = returnResponse(response);
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioExceptionType.connectionError) {
        throw InternetException("");
      } else if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw RequestTimeout("");
      } else if (e.response != null) {
        // Handle API-related errors
        throw FetchDataException(
            "Server responded with status code ${e.response?.statusCode}: ${e.response?.data}");
      } else {
        // Handle other Dio errors
        throw FetchDataException(e.message);
      }
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
    return responsejson;
  }
}
