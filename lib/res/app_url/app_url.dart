class AppUrl {
  static const String baseUrl = "http://localhost:8000/api/v1";
  static const String loginUrl = "$baseUrl/users/login";
  static const String registerUrl = "$baseUrl/users/register";
  static const String logoutUrl = "$baseUrl/users/logout";
  static const String changePasswordUrl = "$baseUrl/users/change-password";
  static const String forgotPasswordUrl = "$baseUrl/users/forgot-password";
  static const String getAllVideoUrl = "$baseUrl/videos?query=";
  static const String getVideoByIdUrl = "$baseUrl/videos/?videoId=";
  static const String getCurrentUserUrl = "$baseUrl/users/current-user";
}
