import 'package:dio/dio.dart';
import 'package:namer_app/models/event_log_model.dart';
import 'package:namer_app/services/api_endpoints.dart';
import 'package:namer_app/services/dio_client.dart';

class EventLogService {
  static final DioClient dioClient = DioClient();

  static Future<EventLogModel?> fetchEventLog(
      int startTime, int endTime) async {
    try {
      Response response = await dioClient
          .getRequest('${ApiEndpoints.EVENT_LOG}/$startTime/$endTime');
      if (response.statusCode == 200) {
        return EventLogModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load event log');
      }
    } catch (e) {
      print('Error fetching event log: $e');
      return null;
    }
  }

  static Future<bool> addEventLog(EventLogModel eventLog) async {
    try {
      Response response =
          await dioClient.postRequest(ApiEndpoints.EVENT_LOG, {});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Error adding event log: $err');
      throw Exception(err);
    }
  }

  static Future<bool> updatePlanStatus(int id, bool state) async {
    try {
      Response response = await dioClient.putRequest(
        '${ApiEndpoints.UPDATE_MEAL_PLAN}/$id',
        {'state': state},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error updating plan status: $e');
      return false;
    }
  }
}
