import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login_page.dart';

class RegisterInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StepInputScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StepInputScreen extends StatefulWidget {
  @override
  _StepInputScreenState createState() => _StepInputScreenState();
}

class _StepInputScreenState extends State<StepInputScreen> {
  final PageController _controller = PageController();
  int _currentStep = 0;
  int _totalSteps = 4;

  int _height = 150;
  int _weight = 60;
  DateTime _birthDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime birthDate = DateTime.now();
  }

  void _enter() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(160, 158, 235, 1),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / _totalSteps,
              backgroundColor: Colors.purple[100] ?? Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.purple[700] ?? Colors.purple),
            ),
          ),
        ),
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              // physics: NeverScrollableScrollPhysics(), // Disable scrolling
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                buildWeightPicker(),
                buildDatePicker(),
                buildHeightPicker(),
                buildFinishWidget(),
              ],
            ),
            Positioned(
              top: 10,
              left: 20,
              right: 20,
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${_weight}kg',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '$_birthDate',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${_height}cm',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ],
        ));
  }

  Widget buildWeightPicker() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 278,
            decoration: BoxDecoration(color: Color.fromRGBO(160, 158, 235, 1)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('选择体重\n获取当前的身体状态', style: TextStyle(fontSize: 24)),
              Text('这不仅是一次记录，更是一个起点'),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: CupertinoPicker(
              itemExtent: 40,
              onSelectedItemChanged: (int index) {
                // Handle weight selection
                setState(() {
                  _weight = 40 + index;
                });
              },
              diameterRatio: 1.5, // Adjusts the curvature
              squeeze: 1.2, // Adjusts the spacing
              children: List<Widget>.generate(100, (int index) {
                return Center(child: Text('${40 + index} kg'));
              }),
            ),
          ),
          SizedBox(height: 20),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildDatePicker() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 278,
            decoration: BoxDecoration(color: Color.fromRGBO(160, 158, 235, 1)),
          ),
          Text('选择出生日期', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          SizedBox(
            height: 200, // Set a fixed height for the date picker
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2000, 1, 1),
              onDateTimeChanged: (DateTime newDateTime) {
                // Handle date selection
                setState(() {
                  _birthDate = newDateTime;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildHeightPicker() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 278,
            decoration: BoxDecoration(
              color: Color.fromRGBO(160, 158, 235, 1),
            ),
          ),
          Text('选择身高', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: CupertinoPicker(
              itemExtent: 40,
              onSelectedItemChanged: (int index) {
                // Handle height selection
                setState(() {
                  _height = index + 100;
                });
              },
              children: List<Widget>.generate(160, (int index) {
                return Center(child: Text('${100 + index} cm'));
              }),
            ),
          ),
          SizedBox(height: 20),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildFinishWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 278,
            decoration: BoxDecoration(
              color: Color.fromRGBO(160, 158, 235, 1),
            ),
          ),
          Text('准备好', style: TextStyle(fontSize: 24)),
          Text('进入...', style: TextStyle(fontSize: 24)),
          SizedBox(
            height: 200,
          ),
          SizedBox(
            width: 140,
            height: 52,
            child: ElevatedButton(
              onPressed: _enter,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[400]),
              child: Text(
                '进入',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_controller.page!.toInt() > 0) {
              _controller.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Text('跳过'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.page!.toInt() < _totalSteps - 1) {
              _controller.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text('确定'),
        ),
      ],
    );
  }
}
