// ignore: file_names
import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone_number;
  final String email;
  final String vehicle_info;
  final String rewards;
  final String appointment_info;

  Contact(
      {required this.name,
      required this.phone_number,
      required this.email,
      required this.vehicle_info,
      required this.rewards,
      required this.appointment_info});
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [
    Contact(
        name: 'John Smith',
        phone_number: '(770)123-4567',
        email: 'jsmith@email.com',
        vehicle_info: '2020 c-class',
        rewards: '20 points',
        appointment_info: 'recent appointment: September 21st 2023'),
    Contact(
        name: 'Sharen Kelly',
        phone_number: '(770)223-5567',
        email: 'skelly@email.com',
        vehicle_info: '2021 GLA',
        rewards: '60 points',
        appointment_info: 'recent appointment: August 20th 2023'),
    Contact(
        name: 'Mike Johnson',
        phone_number: '(770)323-6567',
        email: 'mjohnson@email.com',
        vehicle_info: '2022 GLC',
        rewards: '10 points',
        appointment_info: 'recent appointment: October 30th 2023'),
    Contact(
        name: 'Cutsomer1',
        phone_number: '(123)456-6789',
        email: 'customer1@email.com',
        vehicle_info: 'customer1 car',
        rewards: '10 points',
        appointment_info: 'recent appointment: customer1'),
    Contact(
        name: 'Cutsomer2',
        phone_number: '(123)456-6789',
        email: 'customer2@email.com',
        vehicle_info: 'customer2 car',
        rewards: '20 points',
        appointment_info: 'recent appointment: customer2'),
    Contact(
        name: 'Cutsomer3',
        phone_number: '(123)456-6789',
        email: 'customer3@email.com',
        vehicle_info: 'customer3 car',
        rewards: '30 points',
        appointment_info: 'recent appointment: customer3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer CONTACT'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].name),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      ContactDetailsScreen(contact: contacts[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;

  ContactDetailsScreen({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(contact.phone_number),
            const SizedBox(height: 8.0),
            Text(contact.email),
            const SizedBox(height: 8.0),
            Text(contact.vehicle_info),
            const SizedBox(height: 8.0),
            Text(contact.rewards),
            const SizedBox(height: 8.0),
            Text(contact.appointment_info),
          ],
        ),
      ),
    );
  }
}
