import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime today) {
    setState(() {
      day = today;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("selected day: " + today.toString().split(" ")[0]),
            Container(
                child: TableCalendar(
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 15),
              lastDay: DateTime.utc(2030, 10, 15),
              onDaySelected: _onDaySelected,
            )),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
