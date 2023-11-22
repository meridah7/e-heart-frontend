import 'package:flutter/material.dart';

class BingeEatingRecordPage extends StatefulWidget {
  @override
  _BingeEatingRecordPageState createState() => _BingeEatingRecordPageState();
}

class _BingeEatingRecordPageState extends State<BingeEatingRecordPage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Record Binge Eating'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Describe your experience',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text("Date of Incident: ${selectedDate.toLocal()}".split(' ')[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Handle data submission
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
