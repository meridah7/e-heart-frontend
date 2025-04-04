class ApiAnalytics {
  static final Map<String, List<int>> _responseTime = {};
  static final Map<String, int> _errorCount = {};
  static final Map<String, int> _requestCount = {};
  
  static void recordRequest(String endpoint, DateTime startTime, bool isSuccess, {int? statusCode}) {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMilliseconds;
    
    // 记录响应时间
    if (!_responseTime.containsKey(endpoint)) {
      _responseTime[endpoint] = [];
    }
    _responseTime[endpoint]!.add(duration);
    
    // 记录请求计数
    _requestCount[endpoint] = (_requestCount[endpoint] ?? 0) + 1;
    
    // 记录错误
    if (!isSuccess) {
      _errorCount[endpoint] = (_errorCount[endpoint] ?? 0) + 1;
    }
  }
  
  static Map<String, dynamic> getAnalytics() {
    final Map<String, dynamic> results = {};
    
    for (final endpoint in _requestCount.keys) {
      final totalRequests = _requestCount[endpoint] ?? 0;
      final errors = _errorCount[endpoint] ?? 0;
      final responseTimes = _responseTime[endpoint] ?? [];
      
      double avgResponseTime = 0;
      if (responseTimes.isNotEmpty) {
        avgResponseTime = responseTimes.reduce((a, b) => a + b) / responseTimes.length;
      }
      
      results[endpoint] = {
        'totalRequests': totalRequests,
        'errorRate': totalRequests > 0 ? errors / totalRequests : 0,
        'avgResponseTime': avgResponseTime,
      };
    }
    
    return results;
  }
  
  static void reset() {
    _responseTime.clear();
    _errorCount.clear();
    _requestCount.clear();
  }
} 