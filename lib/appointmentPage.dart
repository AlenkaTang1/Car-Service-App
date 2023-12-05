import 'package:flutter/material.dart';
import 'package:service_app/main.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

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
        centerTitle: true,
        backgroundColor: darkBlue,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Appointment Page', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("selected day: ${today.toString().split(" ")[0]}", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20,),
            FractionallySizedBox(
              widthFactor: .9,
              child: 
              Container(
                decoration: BoxDecoration(color: Color.fromARGB(255, 226, 226, 226), borderRadius: BorderRadius.circular(30)),
                child: TableCalendar(
                  headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 15),
                  lastDay: DateTime.utc(2030, 10, 15),
                  onDaySelected: _onDaySelected,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(color: darkBlue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/appointmentList');
                },
                child: const Text('Appointments for Today', style: TextStyle(color: Colors.white)),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(color: darkBlue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Go back!', style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
