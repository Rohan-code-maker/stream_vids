class AppUrl {
  static const String baseUrl = "http://localhost:8000/api/v1";
  static const String loginUrl = "$baseUrl/users/login";
  static const String registerUrl = "$baseUrl/users/register";
  static const String logoutUrl = "$baseUrl/users/logout";
  static const String changePasswordUrl = "$baseUrl/users/change-password";
  static const String forgotPasswordUrl = "$baseUrl/users/forgot-password";
  static const String addVideoUrl = "$baseUrl/videos";
  static const String getAllVideoUrl = "$baseUrl/videos?query=";
  static const String getVideoByIdUrl = "$baseUrl/videos/?videoId=";
  static const String addWatchHistoryUrl = "$baseUrl/users/history/:videoId";
  static const String getWatchHistoryUrl = "$baseUrl/users/history";
  static const String getChannelProfileUrl = "$baseUrl/users/channel";
  static const String refreshTokenUrl = "$baseUrl/users/refresh-token";
  static const String updateAccountUrl = "$baseUrl/users/update-account";
  static const String updateAvatarUrl = "$baseUrl/users/avatar";
  static const String updateCoverImageUrl = "$baseUrl/users/cover-image";
}
