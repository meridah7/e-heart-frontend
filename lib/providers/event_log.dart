import 'package:namer_app/services/event_log_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:namer_app/models/event_log_model.dart';

part 'event_log.g.dart';

@Riverpod(keepAlive: true)
class EventLog extends _$EventLog {
  @override
  FutureOr<EventLogModel?> build() async {
    return null;
  }

  Future<EventLogModel?> fetchEventLog() async {
    final now = DateTime.now();
    // final now = DateTime.fromMillisecondsSinceEpoch(1733702400000);
    int startTime =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    // 当天 23:59:59 的时间戳
    int endTime = DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
        .millisecondsSinceEpoch;
    EventLogModel? res =
        await EventLogService.fetchEventLog(startTime, endTime);
    state = AsyncData(res);
    return res;
  }

  Future<bool> updatePlanStatus(int id, bool status) async {
    bool res = await EventLogService.updatePlanStatus(id, status);
    if (res) {
      fetchEventLog();
    }
    return res;
  }
}
