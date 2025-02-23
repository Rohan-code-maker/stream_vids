import 'package:flutter/foundation.dart';

class AppUrl {
  static const String baseUrl = kIsWeb
      ? "http://localhost:8000/api/v1"
      : "http://192.168.1.5:8000/api/v1";
  static const String loginUrl = "$baseUrl/users/login";
  static const String registerUrl = "$baseUrl/users/register";
  static const String logoutUrl = "$baseUrl/users/logout";
  static const String changePasswordUrl = "$baseUrl/users/change-password";
  static const String forgotPasswordUrl = "$baseUrl/users/forgot-password";
  static const String addVideoUrl = "$baseUrl/videos";
  static const String getAllVideoUrl = "$baseUrl/videos?query=";
  static const String getVideoByIdUrl = "$baseUrl/videos/:videoId";
  static const String getMyVideoUrl = "$baseUrl/videos/my-video";
  static const String addWatchHistoryUrl = "$baseUrl/users/history/:videoId";
  static const String getWatchHistoryUrl = "$baseUrl/users/history";
  static const String getChannelProfileUrl = "$baseUrl/users/channel";
  static const String updateAccountUrl = "$baseUrl/users/update-account";
  static const String updateAvatarUrl = "$baseUrl/users/avatar";
  static const String updateCoverImageUrl = "$baseUrl/users/cover-image";
  static const String updateVideoUrl = "$baseUrl/videos/:videoId";
  static const String likeVideoUrl = "$baseUrl/likes/toggle/v/:videoId";
  static const String likeVideoCountUrl = "$baseUrl/likes/count/:videoId";
  static const String getlikeVideoUrl = "$baseUrl/likes/videos";
  static const String subscribeUrl = "$baseUrl/subscriptions/c/:channelId";
  static const String commentUrl = "$baseUrl/comments/:videoId";
  static const String toggleCommentLikeUrl = "$baseUrl/likes/toggle/c/:commentId";
  static const String commentLikeCountUrl = "$baseUrl/likes/like-count/:commentId";
  static const String updateCommentUrl = "$baseUrl/comments/c/:commentId";
  static const String viewsCountUrl = "$baseUrl/videos/views/:videoId";
  static const String getUser = "$baseUrl/users/profile/:userId";
  static const String getUserVideos = "$baseUrl/videos/user/:userId";
  static const String getAllChats = "$baseUrl/chats";
}
