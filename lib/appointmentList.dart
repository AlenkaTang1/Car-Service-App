import 'package:flutter/material.dart';
import 'main.dart';

class Today {
  final String time;
  final String name;
  final String details;

  Today({required this.name, required this.time, required this.details});
}

class TodayListScreen extends StatefulWidget {
  const TodayListScreen({super.key});

  @override
  _TodayListScreenState createState() => _TodayListScreenState();
}

class _TodayListScreenState extends State<TodayListScreen> {
  List<Today> todos = [
    Today(
        time: '9:00 am',
        name: 'William John',
        details: 'Regular B-Service for 2020 GLA'),
    Today(time: '10:00 am', name: 'Kelly Lee', details: 'collision towed in'),
    Today(
        time: '11:00 am',
        name: 'Amanda Young',
        details: 'Transmission Service'),
    Today(time: '12:00 pm', name: 'Tony Patterson', details: 'Battery Serivce'),
    Today(time: '2:00 pm', name: 'Jackie Gilmuour', details: 'A-Service'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkBlue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Appointments for Today', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      TodayDetailsScreen(today: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TodayDetailsScreen extends StatelessWidget {
  final Today today;

  TodayDetailsScreen({required this.today});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkBlue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(today.time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name:', 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(today.name, style: const TextStyle(color: Colors.white)),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Details:', 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(today.details, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
