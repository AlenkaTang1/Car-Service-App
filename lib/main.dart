import 'package:flutter/material.dart';
import 'appointmentPage.dart';
import 'ticketPage.dart';
import 'recallPage.dart';
import 'contactPage.dart';
import 'appointmentList.dart';

void main() {
  runApp(MaterialApp(title: 'Service App', initialRoute: '/', routes: {
    '/': (context) => const HomeScreen(),
    '/appointment': (context) => const AppointmentPage(),
    '/appointmentList': (context) => TodayListScreen(),
    '/contact': (context) => const ContactListScreen(),
    '/ticket': (context) => const TicketPage(),
    '/recall': (context) => const RecallPage(),
  }));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/appointment');
                    },
                    icon: const Icon(Icons.calendar_month)),
                ElevatedButton(
                  child: const Text('Appointments'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/appointment');
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/contact');
                    },
                    icon: const Icon(Icons.people)),
                ElevatedButton(
                  child: const Text('Contacts'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/recall');
                    },
                    icon: const Icon(Icons.info)),
                ElevatedButton(
                  child: const Text('Recalls'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/recall');
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ticket');
                    },
                    icon: const Icon(Icons.airplane_ticket)),
                ElevatedButton(
                  child: const Text('Tickets'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/ticket');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
