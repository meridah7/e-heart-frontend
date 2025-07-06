// ignore_for_file: constant_identifier_names, prefer_function_declarations_over_variables

class ApiEndpoints {
  // static const String BASE_URL = 'http://39.107.57.217:3000/api';
  static const String BASE_URL = 'http://192.168.86.235:3000/api';
  static const String AGENT_BASE_URL = 'http://223.4.25.37:3000/api/agent';

  // 用户认证
  static const String SEND_CODE = '/auth/sendCode';
  static const String VERIFY_CODE = '/auth/verifyCode';
  static const String LOG_OUT = '/auth/logout';

  // 用户信息
  static const String PROFILE = '/users/current';

  // 用户进度
  static const String PROGRESS = '/users/progress';
  // 更新进度
  static const String UPDATE_PROGRESS = '/users/task';

  // 冲动应对 GET-获取策略 PUT-更新策略 POST-添加策略
  static const String IMPULSE_STRATEGIES = '/impulse/impulse-strategies';
  // 冲动应对 卡片排序
  static const String IMPULSE_STRATEGIES_REORDER = '/impulse/strategy-order';

  // 获取所有冲动记录
  static const String IMPULSE_RECORDS = '/impulse/impulse-records';
  //  获取最新的冲动反思对应的所有冲动记录
  static const String IMPULSE_REFLECTION_RECORDS =
      '/impulse/impulse-reflection-records';

  // 饮食计划反思 GET
  static const String MEAL_PLAN_REFLECTIONS =
      '/meal_plan_reflections/reflection_data';
  // 创建饮食计划
  static const String CREATE_MEAL_PLAN = '/meal_plans/create';

  // 更新饮食计划 PUT id
  static const String UPDATE_MEAL_PLAN = '/meal_plans/';

  // 行为记录
  static const String EVENT_LOG = '/diet_logs/todayDiet/';

  // 饮食日志反思 Doc：https://qv13irour75.feishu.cn/docx/ZlAsdd1wQo8r2RxmAEbc0w3cn2d
  //GET 获取所有饮食日志反思 / 或根据ID获取反思
  static const String DIET_LOG_REFLECTIONS = '/diet_log_reflections';

  //GET 获取当前饮食日志反思
  static const String CURRENT_DIET_LOG_REFLECTIONS =
      '/diet_log_reflections/latest';

  // PUT 提交当前饮食记录反思
  static const String SUBMIT_LATEST_DIET_LOG_REFLECTIONS =
      'diet_log_reflections/latest/submit';

  // PUT 根据ID更新饮食记录反思
  final SUBMIT_DIET_LOG_REFLECTIONS_BY_ID =
      (String id) => '/diet_log_reflections/$id/submit';

  // DELETE 删除饮食记录反思
  static const String DELETE_DIET_LOG_REFLECTION_BY_ID =
      '/diet_log_reflections/';

  // GET 获取暴食发生的星期分布
  final BINGE_DAY_OF_WEEK =
      (String id) => 'diet_log_reflections/$id/binge/day-of-week';

  // GET 获取暴食发生的时间段分布
  final BINGE_TIME_OF_DAY =
      (String id) => 'diet_log_reflections/$id/binge/time-of-day';

  // GET 获取暴食发生的地点
  final BINGE_LOCATION =
      (String id) => 'diet_log_reflections/$id/binge/location';

  // GET 获取暴食发生的情绪强度
  final BINGE_EMOTION_INTENSITY =
      (String id) => 'diet_log_reflections/$id/binge/emotion-intensity';

  // GET 获取暴食发生的情绪类型
  final BINGE_EMOTION_TYPE =
      (String id) => 'diet_log_reflections/$id/binge/emotion-type';
  // GET 获取暴食发生的食物详细信息
  final BINGE_FOOD_DETAILS =
      (String id) => '/diet_log_reflections/$id/binge/food-details';

  // GET 获取诱因识别成功率
  final BINGE_TRIGGER_IDENTIFY_RATE = (String id) =>
      '/diet_log_reflections/:id/binge/trigger-identification-success';

  // GET 获取暴食发生的具体诱因
  final BINGE_TRIGGER_SPECIFIC =
      (String id) => '/diet_log_reflections/$id/binge/specific-trigger';

  // GET 节食与周几的关系
  final DIET_DAY_OF_WEEK =
      (String id) => '/diet_log_reflections/$id/dieting/day-of-week';
  // GET 节食与地点
  final DIET_EATING_LOCATION =
      (String id) => '/diet_log_reflections/$id/dieting/location';
  // GET 节食与情绪强度
  final DIET_EMOTION_INTENSITY =
      (String id) => '/diet_log_reflections/$id/dieting/emotion-intensity';
  // GET 节食与情绪种类
  final DIET_EMOTION_TYPE =
      (String id) => '/diet_log_reflections/$id/dieting/emotion-type';
  // GET 节食与进食的食物
  final DIET_FOOD_DETAIL =
      (String id) => '/diet_log_reflections/$id/dieting/food-details';

  // GET 获取反思总结接口
  final DIET_LOG_REFLECTION_SUMMARY =
      (int? id) => '/diet_log_reflections/$id/summary';
}
