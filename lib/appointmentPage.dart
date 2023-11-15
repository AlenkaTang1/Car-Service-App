import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Go back!'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calendar');
              },
              child: const Text('View Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}
