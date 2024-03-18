import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api_response_model/lecturer_response.dart';

import '../http_service/http_service.dart';

class LecturerStateNotifier extends StateNotifier<AsyncValue<LecturerResponse>> {
  LecturerStateNotifier() : super(const AsyncLoading());

  void getLecturerLIst({ String? lecturerId}) async { //授課講師列表 API
    // get lecturer list,if lecturerId provided,api will return this lecturer,otherwise return all lecturer
    state = const AsyncLoading();
    final query = <String, dynamic>{};

    if (lecturerId != null) {
      query["lecturer_id"] = lecturerId;
    }
    final result = await AsyncValue.guard(() => HttpService.get(query: query, path: "lecturer/get", fromJson: LecturerResponse.fromJson));
    if (!mounted) {
      return;
    }
    state = result;
  }

  Future<LecturerResponse> createLecturer({required Lecturer lecturer}) async { //建立新講師 API
    // this function contains create lecturer and update lecturer,depends on whether lecturer.id is null,
    // if lecturer.id is null, api will create new ,otherwise api will update the exist one

    try {
      final result = await HttpService.post(body: lecturer.toJson(), path: "lesson/create", fromJson: LecturerResponse.fromJson);
      return result;
    } catch (e) {
      rethrow;
    }
  }


}
