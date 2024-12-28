
class PublishVideoModel {
  final int statusCode;
  final Data data;
  final String message;
  final bool success;

  PublishVideoModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory PublishVideoModel.fromJson(Map<String, dynamic> json) {
    return PublishVideoModel(
      statusCode: json['statusCode'],
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'data': data.toJson(),
      'message': message,
      'success': success,
    };
  }
}

class Data {
  final SavedVideo savedVideo;

  Data({required this.savedVideo});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      savedVideo: SavedVideo.fromJson(json['savedVideo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'savedVideo': savedVideo.toJson(),
    };
  }
}

class SavedVideo {
  final String videoFile;
  final String thumbnail;
  final String title;
  final String description;
  final double duration;
  final int views;
  final bool isPublished;
  final String owner;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int version;

  SavedVideo({
    required this.videoFile,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.duration,
    required this.views,
    required this.isPublished,
    required this.owner,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory SavedVideo.fromJson(Map<String, dynamic> json) {
    return SavedVideo(
      videoFile: json['videoFile'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      description: json['description'],
      duration: (json['duration'] as num).toDouble(),
      views: json['views'],
      isPublished: json['isPublished'],
      owner: json['owner'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoFile': videoFile,
      'thumbnail': thumbnail,
      'title': title,
      'description': description,
      'duration': duration,
      'views': views,
      'isPublished': isPublished,
      'owner': owner,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}