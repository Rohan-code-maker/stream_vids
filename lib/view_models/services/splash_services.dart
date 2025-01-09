import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_vids/repository/user/refresh_token/refresh_token_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';
import 'package:stream_vids/view_models/services/language_service.dart';

class SplashServices {
  final UserPreferences userPreferences = UserPreferences();
  final LanguageService languageService = LanguageService();
  final _api = RefreshTokenRepository();

  Future<void> handleAppNavigation() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
      Duration splashDelay = isFirstTime
          ? const Duration(seconds: 2)
          : const Duration(milliseconds: 500);
      await Future.delayed(splashDelay);

      if (isFirstTime) {
        Get.toNamed(RouteName.languageScreen);
        prefs.setBool('isFirstTime', false);
      } else {
        await _checkLoginStatus();
      }
    } catch (error) {
      Utils.snackBar("Error", "An error occurred: $error");
    }
  }

  Future<void> _checkLoginStatus() async {
    final userData = await userPreferences.getUser();

    if (userData.accessToken == null || userData.accessToken!.isEmpty) {
      Get.toNamed(RouteName.loginScreen);
    } else {
      final isAccessTokenValid = _isTokenValid(userData.accessToken!);
      final isRefreshTokenValid = _isTokenValid(userData.refreshToken!);

      if (isAccessTokenValid) {
        // Token is valid, navigate to HomeScreen
        Get.toNamed(RouteName.navBarScreen);
      } else if (isRefreshTokenValid) {
        // Access token expired, but refresh token is valid. Refresh it.
        await _refreshAccessToken(userData.refreshToken!);
      } else {
        // Both tokens are invalid, navigate to LoginScreen
        Get.toNamed(RouteName.loginScreen);
      }
    }
  }

  bool _isTokenValid(String token) {
    // Decode the token and check its expiry
    final payload = _decodeJWT(token);
    if (payload == null || !payload.containsKey('exp')) return false;

    final expiryDate =
        DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
    return expiryDate.isAfter(DateTime.now());
  }

  Map<String, dynamic>? _decodeJWT(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final decoded =
          String.fromCharCodes(base64Url.decode(base64Url.normalize(payload)));
      return jsonDecode(decoded);
    } catch (e) {
      return null;
    }
  }

  Future<void> _refreshAccessToken(String refreshToken) async {
    try {
      final response =
          await _api.refreshTokenApi(refreshToken);

      if (response['statusCode'] == 200) {
        final newId = response['data']['_id'];
        final newAccessToken = response['data']['accessToken'];
        final newRefreshToken = response['data']['refreshToken'];

        // Update tokens in user preferences
        final updatedUser = await userPreferences.getUser();
        updatedUser.user!.sId = newId;
        updatedUser.accessToken = newAccessToken;
        updatedUser.refreshToken = newRefreshToken;
        await userPreferences.saveUser(updatedUser);

        Get.toNamed(RouteName.navBarScreen);
      } else {
        // Refresh failed, navigate to LoginScreen
        Get.toNamed(RouteName.loginScreen);
        Utils.snackBar("Error", "Session expired. Please log in again.");
      }
    } catch (error) {
      Utils.snackBar("Error", "Failed to refresh access token: $error");
      Get.toNamed(RouteName.loginScreen);
    }
  }
}
