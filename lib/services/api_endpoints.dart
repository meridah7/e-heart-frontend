// ignore_for_file: constant_identifier_names

class ApiEndpoints {
  static const String BASE_URL = 'http://47.96.108.106/api';
  // static const String BASE_URL = 'http://192.168.86.215:3000/api';
  static const String AGENT_BASE_URL = 'http://223.4.25.37:3000/api/agent';

  // 用户认证
  static const String SEND_CODE = '/auth/sendCode';
  static const String VERIFY_CODE = '/auth/verifyCode';

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
}
