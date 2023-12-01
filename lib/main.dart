import 'package:flutter/material.dart';
import 'appointmentPage.dart';
import 'ticketPage.dart';
import 'recallPage.dart';
import 'contactPage.dart';

void main() {
  runApp(MaterialApp(title: 'Service App', initialRoute: '/', routes: {
    '/': (context) => const HomeScreen(),
    '/appointment': (context) => const AppointmentPage(),
    '/contact': (context) => const ContactPage(),
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
                ElevatedButton(
                  child: const Text('Appointments'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/appointment');
                  },
                ),
                const SizedBox(width: 20),
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
                ElevatedButton(
                  child: const Text('Recalls'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/recall');
                  },
                ),
                const SizedBox(width: 20),
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
