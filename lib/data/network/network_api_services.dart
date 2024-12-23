import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_vids/data/app_exceptions.dart';
import 'package:stream_vids/data/network/base_api_services.dart';
import 'package:stream_vids/view_models/controller/user_preferences/user_preferences.dart';

class NetworkApiService extends BaseApiService {
  final dio = Dio();
  UserPreferences userPreferences = UserPreferences();

  dynamic returnResponse(Response response) {
    if (response.data is! Map<String, dynamic>) {
      throw FetchDataException('Unexpected response format: ${response.data}');
    }

    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:
        throw InvalidUrlException("Invalid URL");
      case 500:
        throw ServerException("Internal Server Error");
      default:
        throw FetchDataException(
            'Error occurred while communicating with the server with status code: ${response.statusCode}');
    }
  }

  @override
  Future deleteApi(String url) async {
    dynamic responsejson;
    try {
      final response =
          await dio.delete(url).timeout(const Duration(seconds: 10));
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
  Future getApi(String url, {bool requiresAuth = false}) async {
    dynamic responseJson;
    var headers = {
      'accept': '*/*',
    };

    try {
      if (requiresAuth) {
        final user = await userPreferences.getUser();
        final accessToken = user.accessToken;
        if (accessToken == null) {
          throw FetchDataException(
              "Authentication token is missing or invalid.");
        }
        headers.addAll({
          'Authorization': 'Bearer $accessToken',
        });
      }

      final response = await dio
          .get(
            url,
            options: Options(
              headers: headers,
              responseType: ResponseType.json,
            ),
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw InternetException("No internet connection.");
      } else if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw RequestTimeout("Request timed out. Please try again.");
      } else if (e.response != null) {
        throw FetchDataException(
            "Error ${e.response?.statusCode}: ${e.response?.data}");
      } else {
        throw FetchDataException("Unexpected error occurred: ${e.message}");
      }
    } catch (e) {
      if (kIsWeb) {
        throw Exception("An unexpected error occurred in the web app: $e");
      } else {
        throw Exception("An unexpected error occurred in the mobile app: $e");
      }
    }
    return responseJson;
  }

  @override
  Future postApi(dynamic data, String url, {bool requiresAuth = false}) async {
    dynamic responseJson;

    try {
      // Prepare headers
      Map<String, dynamic> headers = {
        'accept': '*/*',
        'response-type': ResponseType.json,
        'Content-Type':
            data is FormData ? 'multipart/form-data' : 'application/json',
      };

      // Include Authorization header only if required
      if (requiresAuth) {
        final user = await userPreferences.getUser();
        final accessToken = user.accessToken;
        headers['Authorization'] = 'Bearer $accessToken';
      }

      // Configure options
      Options options = Options(headers: headers);

      // Make the POST request
      final response = await dio
          .post(url, data: data, options: options)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioExceptionType.connectionError) {
        throw InternetException("Connection Error");
      } else if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw RequestTimeout("Request Timeout");
      } else if (e.response != null) {
        throw FetchDataException(
            "API Error: Status Code ${e.response?.statusCode}, Data: ${e.response?.data}");
      } else {
        throw FetchDataException(e.message);
      }
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }

    return responseJson;
  }

  @override
  Future putApi(data, String url) async {
    dynamic responsejson;
    try {
      final response =
          await dio.put(url, data: data).timeout(const Duration(seconds: 10));
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
