import 'package:flutter/material.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/utils/error_handler.dart';

class TreatmentOptimizer extends StatefulWidget {
  @override
  _TreatmentOptimizerState createState() => _TreatmentOptimizerState();
}

class _TreatmentOptimizerState extends State<TreatmentOptimizer> {
  bool _isLoading = true;
  dynamic _error;
  final DioClient dioClient = DioClient();
  
  List<TreatmentSuggestion> _suggestions = [];
  Map<String, dynamic> _userMetrics = {};
  
  @override
  void initState() {
    super.initState();
    _loadOptimizationData();
  }
  
  Future<void> _loadOptimizationData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      final response = await dioClient.getRequest('/treatment/optimize');
      
      if (response.statusCode == 200) {
        setState(() {
          _suggestions = (response.data['suggestions'] as List)
              .map((item) => TreatmentSuggestion.fromJson(item))
              .toList();
          _userMetrics = response.data['metrics'];
          _isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      ErrorHandler.logError(e, stackTrace: stackTrace);
      setState(() {
        _error = e;
        _isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return _isLoading
      ? Center(child: CircularProgressIndicator())
      : _error != null
        ? ErrorHandler.buildErrorWidget(_error, _loadOptimizationData)
        : SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserMetricsSection(),
                SizedBox(height: 24),
                _buildSuggestionsSection(),
              ],
            ),
          );
  }
  
  Widget _buildUserMetricsSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('治疗评估指标', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildMetricItem('进步速度', _userMetrics['progressRate'], 'fast'),
            Divider(),
            _buildMetricItem('情绪稳定性', _userMetrics['emotionalStability'], 'medium'),
            Divider(),
            _buildMetricItem('饮食行为改善', _userMetrics['dietaryImprovement'], 'high'),
            Divider(),
            _buildMetricItem('冲动控制力', _userMetrics['impulseControl'], 'medium'),
            Divider(),
            _buildMetricItem('社交支持程度', _userMetrics['socialSupport'], 'low'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMetricItem(String label, double value, String category) {
    Color color;
    String levelText;
    
    switch(category) {
      case 'low':
        color = Colors.red;
        levelText = '较低';
        break;
      case 'medium':
        color = Colors.orange;
        levelText = '一般';
        break;
      case 'high':
      case 'fast':
        color = Colors.green;
        levelText = '良好';
        break;
      default:
        color = Colors.grey;
        levelText = '未知';
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Row(
          children: [
            Container(
              width: 150,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 150 * value,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: color,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(levelText, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
  
  Widget _buildSuggestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('个性化建议', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        ..._suggestions.map((suggestion) => _buildSuggestionCard(suggestion)).toList(),
      ],
    );
  }
  
  Widget _buildSuggestionCard(TreatmentSuggestion suggestion) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getSuggestionIcon(suggestion.category),
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
                SizedBox(width: 12),
                Text(
                  suggestion.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              suggestion.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '优先级: ${_getPriorityText(suggestion.priority)}',
                  style: TextStyle(
                    color: _getPriorityColor(suggestion.priority),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 实现添加到计划功能
                  },
                  child: Text('添加到计划'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  IconData _getSuggestionIcon(String category) {
    switch(category) {
      case 'diet': return Icons.restaurant;
      case 'emotional': return Icons.mood;
      case 'behavioral': return Icons.psychology;
      case 'social': return Icons.people;
      case 'exercise': return Icons.fitness_center;
      default: return Icons.lightbulb;
    }
  }
  
  String _getPriorityText(int priority) {
    switch(priority) {
      case 1: return '高';
      case 2: return '中';
      case 3: return '低';
      default: return '未知';
    }
  }
  
  Color _getPriorityColor(int priority) {
    switch(priority) {
      case 1: return Colors.red;
      case 2: return Colors.orange;
      case 3: return Colors.blue;
      default: return Colors.grey;
    }
  }
}

class TreatmentSuggestion {
  final String id;
  final String title;
  final String description;
  final String category;
  final int priority;
  
  TreatmentSuggestion({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
  });
  
  factory TreatmentSuggestion.fromJson(Map<String, dynamic> json) {
    return TreatmentSuggestion(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      priority: json['priority'],
    );
  }
} 