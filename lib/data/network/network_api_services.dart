import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_vids/data/app_exceptions.dart';
import 'package:stream_vids/data/network/base_api_services.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';

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
      case 400: // Bad Request
        throw BadRequestException(response.data.toString());
      case 401: // Unauthorized
        throw UnauthorizedException('Unauthorized: ${response.data}');
      case 403: // Forbidden
        throw ForbiddenException('Forbidden: ${response.data}');
      case 404: // Not Found
        throw InvalidUrlException("Invalid URL: ${response.data}");
      case 405: // Method Not Allowed
        throw MethodNotAllowedException('Method not allowed: ${response.data}');
      case 408: // Request Timeout
        throw RequestTimeoutException('Request timeout: ${response.data}');
      case 409: // Conflict
        throw ConflictException('Conflict: ${response.data}');
      case 422: // Unprocessable Entity
        throw UnprocessableEntityException(
            'Unprocessable entity: ${response.data}');

      // Server errors
      case 500: // Internal Server Error
        throw ServerException("Internal Server Error: ${response.data}");
      case 501: // Not Implemented
        throw NotImplementedException('Not implemented: ${response.data}');
      case 502: // Bad Gateway
        throw BadGatewayException('Bad gateway: ${response.data}');
      case 503: // Service Unavailable
        throw ServiceUnavailableException(
            'Service unavailable: ${response.data}');
      case 504: // Gateway Timeout
        throw GatewayTimeoutException('Gateway timeout: ${response.data}');

      // Other/unhandled cases
      default:
        throw FetchDataException(
            'Unhandled error with status code: ${response.statusCode} and message: ${response.data}');
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
  Future patchApi(data, String url, {bool requiresAuth = false}) async {
    dynamic responsejson;
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
      final response = await dio
          .patch(url, data: data, options: options)
          .timeout(const Duration(seconds: 10));
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
