// ignore_for_file: constant_identifier_names

class ApiEndpoints {
  // static const String BASE_URL = 'http://47.96.108.106/api';
  static const String BASE_URL = 'http://192.168.86.215:3000/api';
  static const String AGENT_BASE_URL = 'http://223.4.25.37:3000/api/agent';

  // 用户信息
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String PROFILE = '/profile';

  // 冲动应对 GET-获取策略 PUT-更新策略 POST-添加策略
  static const String IMPULSE_STRATEGIES = '/impulse/impulse-strategies';
}
