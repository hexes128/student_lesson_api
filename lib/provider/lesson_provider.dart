import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api_response_model/lesson_response.dart';
import '../http_service/http_service.dart';

class LessonStateNotifier extends StateNotifier<AsyncValue<LessonResponse>> {
  LessonStateNotifier() : super(const AsyncLoading());

  void getLessonLIst({String? lessonId, String? lecturerId}) async { //課程列表API,和授課講師所開課程列表 API
    // get lesson list,if lecturerId provided,api will return lessons under this lecturer,otherwise return all the lesson list
    state = const AsyncLoading();
    final query = <String, dynamic>{};
    if (lessonId != null) {
      query["lesson_id"] = lessonId;
    }
    if (lecturerId != null) {
      query["lecturer_id"] = lecturerId;
    }
    final result = await AsyncValue.guard(() => HttpService.get(query: query, path: "lesson/get", fromJson: LessonResponse.fromJson));
    if (!mounted) {
      return;
    }
    state = result;
  }

  Future<LessonResponse> createLesson({required Lesson lesson}) async { //建立新課程 API和更新課程內容 API
    // this function contains create lesson and update lesson,depends on whether lesson.id is null,
    // if lesson.id is null, api will create new ,otherwise api will update the exist one

    try {
      final result = await HttpService.post(body: lesson.toJson(), path: "lesson/create", fromJson: LessonResponse.fromJson);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteLesson({required String lessonId}) async { //刪除課程
    // this function deletes lesson by lessonId, the delete result will return true or false by the "success" key
    final body = <String, dynamic>{"lesson_id": lessonId};

    try {
      final result = await HttpService.delete(
        body: body,
        path: "lesson/delete",
      );
      return result["success"];
    } catch (e) {
      rethrow;
    }
  }
}
