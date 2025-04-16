import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/services/api_endpoints.dart';
import 'package:namer_app/utils/helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dio_client.dart';
import 'package:namer_app/models/survey_models.dart';
import 'package:namer_app/models/task_models.dart';
import 'package:namer_app/models/user_progress.dart';

part 'progress_service.g.dart';

@riverpod
ProgressService progressService(ProgressServiceRef ref) {
  return ProgressService();
}

class ProgressService {
  // late Preferences _userPref;
  final DioClient dioClient = DioClient();

  Future<UserProgress?> fetchProgress() async {
    try {
      Response response = await dioClient.getRequest(ApiEndpoints.PROGRESS);
      if (response.statusCode == 200) {
        return UserProgress.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<bool> updateProgress(String taskId, {bool isRequired = true}) async {
    try {
      Response response = await dioClient.postRequest(
          ApiEndpoints.UPDATE_PROGRESS,
          {'task_id': taskId, "is_required_task": isRequired});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error updating user task: $e');
      throw Exception(e);
    }
  }

  Future<UserProgress?> setProgress(int progress) async {
    try {
      Response response = await dioClient.postRequest(ApiEndpoints.PROGRESS, {
        'progress': progress,
      });
      if (response.statusCode == 200) {
        return UserProgress.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to update user task');
      }
    } catch (e) {
      print('Error updating user task: $e');
      throw Exception(e);
    }
  }

  // 获取冲动记录回顾
  Future<List<Task>> fetchImpulseReflectionRecords() async {
    List<Task> impulseRecordTaskList = [];
    try {
      Response response =
          await dioClient.getRequest(ApiEndpoints.IMPULSE_REFLECTION_RECORDS);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        impulseRecordTaskList = data.map((val) {
          DateTime dateTime = DateTime.parse(val['createdAt']).toUtc();
          return Task(
              title: '冲动记录回顾 ${DateFormat('MM月dd日HH时mm分').format(dateTime)}',
              id: 'S1',
              type: TaskType.SURVEY,
              isCompleted: false,
              day: 0,
              survey: Survey(
                  title: '${DateFormat('MM月dd日').format(dateTime)}冲动记录回顾',
                  extra: {
                    'impulse_record_id': Helper.safeParseInt(val['id']),
                  },
                  questions: [
                    TextQuestion('你感觉这次的应对策略怎么样？整个应对过程有什么可以改进的地方呢？', false,
                        alias: 'impulse_response_experience',
                        description:
                            '你的冲动记录时间是：${DateFormat('yyyy年MM月dd日 HH时mm分').format(dateTime)}\n'
                            '你记录的冲动种类是：${val['impulse_type']}\n'
                            '你记录的冲动强度是：${val['intensity']}\n'
                            '你记录的冲动诱因是：${val['trigger']}\n'
                            '针对这次冲动，你制定的应对策略是:${val['plan']}\n'
                            '针对这次冲动，你希望自己坚持冲动冲浪的时间：${val['impulse_duration_min'] ?? 0}分钟\n'),
                    TextQuestion('你这次冲动大约持续了多少分钟？', false,
                        alias: 'impulse_duration_min'),
                  ]));
        }).toList();
      }
    } catch (e) {
      // throw Exception('Error in fetch impulse record list $e');
      print('Error in fetch impulse record list $e');
      return impulseRecordTaskList;
    }
    return impulseRecordTaskList;
  }
}
