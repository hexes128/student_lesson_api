class LecturerResponse {
  final List<Lecturer>? lecturerList;
  final String? msg;
  final bool? success;

  LecturerResponse({
    this.lecturerList,
    this.msg,
    this.success,
  });

  LecturerResponse.fromJson(Map<String, dynamic> json)
      : lecturerList = (json['data'] as List?)?.map((dynamic e) => Lecturer.fromJson(e as Map<String,dynamic>)).toList(),
        msg = json['msg'] as String?,
        success = json['success'] as bool?;

  Map<String, dynamic> toJson() => {
    'data' : lecturerList?.map((e) => e.toJson()).toList(),
    'msg' : msg,
    'success' : success
  };
}

class Lecturer {
  final String? id;
  final String? name;
  final String? jobTitle;
  final String? profilePicture;

  Lecturer({
    this.id,
    this.name,
    this.jobTitle,
    this.profilePicture,
  });

  Lecturer.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        jobTitle = json['job_title'] as String?,
        profilePicture = json['profile_picture'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'job_title' : jobTitle,
    'profile_picture' : profilePicture
  };
}