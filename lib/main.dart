import 'package:flutter/material.dart';
import 'appointmentPage.dart';
import 'ticketPage.dart';
import 'recallPage.dart';
import 'contactPage.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


Future<Database>? ticketDatabase;

void main() async {
  ticketDatabase = createDatabase();
  runApp(MaterialApp(title: 'Service App', initialRoute: '/', routes: {
    '/': (context) => const HomeScreen(),
    '/appointment': (context) => const AppointmentPage(),
    '/contact': (context) => const ContactPage(),
    '/ticket': (context) => const TicketPage(),
    '/recall': (context) => const RecallPage(),
  }));
}

Future<Database> createDatabase() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'ticket_database.db'),

    onCreate: (db, version) {
      return db.execute(
        '''
        CREATE TABLE tickets (
          ticketID INTEGER PRIMARY KEY,
          isClosed INTEGER,
          customerName TEXT,
          carDescription TEXT,
          serviceDescription TEXT,
          creationDate TEXT,
          closeDate TEXT,
          vin TEXT
        );
        ''',
      );
    },

    version: 1,
  );

  return database;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
