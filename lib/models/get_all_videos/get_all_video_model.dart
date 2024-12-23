class GetAllVideoModel {
  final int statusCode;
  final Data data;
  final String message;
  final bool success;

  GetAllVideoModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetAllVideoModel.fromJson(Map<String, dynamic> json) {
    return GetAllVideoModel(
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
  final List<Video> videos;

  Data({required this.videos});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      videos: List<Video>.from(json['videos'].map((x) => Video.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videos': videos.map((x) => x.toJson()).toList(),
    };
  }
}

class Video {
  final String id;
  final String videoFile;
  final String thumbnail;
  final String title;
  final String description;
  final CreatedBy createdBy;

  Video({
    required this.id,
    required this.videoFile,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.createdBy,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['_id'],
      videoFile: json['videoFile'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      description: json['description'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'videoFile': videoFile,
      'thumbnail': thumbnail,
      'title': title,
      'description': description,
      'createdBy': createdBy.toJson(),
    };
  }
}

class CreatedBy {
  final String username;
  final String fullname;
  final String avatar;

  CreatedBy({
    required this.username,
    required this.fullname,
    required this.avatar,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      username: json['username'],
      fullname: json['fullname'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullname': fullname,
      'avatar': avatar,
    };
  }
}