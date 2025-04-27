import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkStatusBar extends StatefulWidget {
  @override
  _NetworkStatusBarState createState() => _NetworkStatusBarState();
}

class _NetworkStatusBarState extends State<NetworkStatusBar> {
  bool _isOnline = true;
  
  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }
  
  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
  }
  
  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _isOnline = result != ConnectivityResult.none;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isOnline) {
      return SizedBox.shrink(); // No widget when online
    }
    
    return Container(
      color: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Center(
        child: Text(
          '当前处于离线模式',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Add this to the top of your scaffold in the main app:
// body: Column(
//   children: [
//     NetworkStatusBar(),
//     Expanded(child: YourMainContent()),
//   ],
// ), 