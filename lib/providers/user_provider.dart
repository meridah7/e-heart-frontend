// lib/providers/user_provider.dart
import 'package:flutter/foundation.dart';
import '../models/user/user.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService apiService;
  User? _user;
  bool _isLoading = false;

  User? get user => _user;

  String? get name => _user?.data?.name;

  int? get id => _user?.data?.id;

  String? get email => _user?.data?.email;

  double get height => _user?.data?.height ?? 0;

  double get weight => _user?.data?.weight ?? 0;

  String? get phoneNumber => _user?.data?.phoneNumber;

  String get uuid => _user?.data?.uuid ?? '';

  DateTime get birthday => _user?.data?.birthday ?? DateTime(2003, 9, 7);

  UserProvider({required this.apiService});

  bool get isLoading => _isLoading;

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();
    _user = await apiService.fetchUser();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    try {
      _user = await apiService.fetchUser();
    } catch (err) {
      print('Error in parse user props $err');
      throw Exception(err);
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    await apiService.logOut();
    _user = null;
    notifyListeners();
  }

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
