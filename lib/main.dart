import 'package:flutter/material.dart';
import 'appointmentPage.dart';
import 'ticketPage.dart';
import 'recallPage.dart';
import 'contactPage.dart';

void main() {
  runApp(MaterialApp(title: 'Service App', initialRoute: '/', routes: {
    '/': (context) => const HomeScreen(),
    '/appointment': (context) => AppointmentPage(),
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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButtonWithImage(
                    context,
                    'Appointments',
                    'assets/appointment_image.jpeg',
                    '/appointment',
                  ),
                  _buildButtonWithImage(
                    context,
                    'Contacts',
                    'assets/contacts_image.png',
                    '/contact',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButtonWithImage(
                    context,
                    'Recalls',
                    'assets/recalls_image.png',
                    '/recall',
                  ),
                  _buildButtonWithImage(
                    context,
                    'Tickets',
                    'assets/tickets_image.png',
                    '/ticket',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

Widget _buildButtonWithImage(
  BuildContext context,
  String buttonText,
  String imagePath,
  String route,
) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Container(
      width: 150,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white, 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), 
          ),
        ],
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 10),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}


}
