import 'package:flutter/material.dart';

class CalendarButton extends StatefulWidget {
  @override
  _CalendarButtonState createState() => _CalendarButtonState();
}

class _CalendarButtonState extends State<CalendarButton> {
  DateTime selectedDate = DateTime.now(); // 選択された日付を保持する変数

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Button Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('カレンダーを開く'),
            ),
            SizedBox(height: 20),
            Text(
              '選択された日付: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
