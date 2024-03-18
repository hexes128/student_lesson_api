class LessonResponse {
  final List<Lesson>? lessonList;
  final String? msg;
  final bool? success;

  LessonResponse({
    this.lessonList,
    this.msg,
    this.success,
  });

  LessonResponse.fromJson(Map<String, dynamic> json)
      : lessonList = (json['data'] as List?)?.map((dynamic e) => Lesson.fromJson(e as Map<String,dynamic>)).toList(),
        msg = json['msg'] as String?,
        success = json['success'] as bool?;

  Map<String, dynamic> toJson() => {
    'data' : lessonList?.map((e) => e.toJson()).toList(),
    'msg' : msg,
    'success' : success
  };
}

class Lesson {
  final String? id;
  final Lecturer? lecturer;
  final String? name;
  final String? desc;
  final String? weekDay;
  final String? startAt;
  final String? endAt;

  Lesson({
    this.id,
    this.lecturer,
    this.name,
    this.desc,
    this.weekDay,
    this.startAt,
    this.endAt,
  });

  Lesson.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        lecturer = (json['lecturer'] as Map<String,dynamic>?) != null ? Lecturer.fromJson(json['lecturer'] as Map<String,dynamic>) : null,
        name = json['name'] as String?,
        desc = json['desc'] as String?,
        weekDay = json['week_day'] as String?,
        startAt = json['start_at'] as String?,
        endAt = json['end_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'lecturer' : lecturer?.toJson(),
    'name' : name,
    'desc' : desc,
    'week_day' : weekDay,
    'start_at' : startAt,
    'end_at' : endAt
  };
}

class Lecturer {
  final String? id;
  final String? name;

  Lecturer({
    this.id,
    this.name,
  });

  Lecturer.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}