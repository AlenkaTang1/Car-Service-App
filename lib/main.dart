import 'package:flutter/material.dart';
import 'appointmentList.dart';
import 'appointmentPage.dart';
import 'ticketPage.dart';
import 'recallPage.dart';
import 'contactPage.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';


Future<Database>? ticketDatabase;
Color offWhite = const Color.fromARGB(255, 237, 237, 237);
Color darkBlue = const Color.fromARGB(255, 40, 51, 57);

void main() async {
  ticketDatabase = createDatabase();
  runApp(MaterialApp(
    title: 'Service App', 
    theme: ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 126, 128, 102)
    ), 
    initialRoute: '/', 
    routes: {
      '/': (context) => HomeScreen(),
      '/appointment': (context) => const AppointmentPage(),
      '/appointmentList': (context) => const TodayListScreen(),
      '/contact': (context) => const ContactListScreen(),
      '/ticket': (context) => const TicketPage(),
      '/recall': (context) => const RecallPage(),
    }
  ));
}

Future<Database> createDatabase() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  Directory(await getDatabasesPath()).create(recursive: true);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkBlue,
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: darkBlue,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: IconButton(
                        onPressed: () {Navigator.pushNamed(context, '/appointment');}, 
                        icon: const Icon(Icons.calendar_month, color: Colors.white),
                        iconSize: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: darkBlue,
                        borderRadius: BorderRadius.circular(50.0),

                      ),
                      child: IconButton(
                        onPressed: () {Navigator.pushNamed(context, '/contact');}, 
                        icon: const Icon(Icons.perm_contact_calendar, color: Colors.white),
                        iconSize: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: darkBlue,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: IconButton(
                        onPressed: () {Navigator.pushNamed(context, '/recall');}, 
                        icon: const Icon(Icons.taxi_alert, color: Colors.white),
                          iconSize: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: darkBlue,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: IconButton(
                        onPressed: () {Navigator.pushNamed(context, '/ticket');}, 
                        icon: const Icon(Icons.content_paste, color: Colors.white),
                        iconSize: MediaQuery.of(context).size.width * 0.15,
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}