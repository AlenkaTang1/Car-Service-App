import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class ServiceTicket {
  final String customerName;
  final String carDescription;
  final String creationDate;
  final String closeDate;
  final String serviceDescription;
  final int ticketID;
  final int vin;

  const ServiceTicket({
    required this.customerName,
    required this.carDescription,
    required this.creationDate,
    required this.closeDate,
    required this.serviceDescription,
    required this.ticketID,
    required this.vin,
  });

  Map<String, dynamic> toMap() {
    return {
      'ticketID': ticketID,
      'customerName': customerName,
      'carDescription': carDescription,
      'serviceDescription': serviceDescription,
      'creationDate': creationDate,
      'closeDate': closeDate,
      'vin': vin,
    };
  }


  void main() async{
    // Avoid errors caused by flutter upgrade.
    WidgetsFlutterBinding.ensureInitialized();

    // Open the database and store the reference.
    final database = openDatabase(
      join(await getDatabasesPath(), 'ticket_database.db'),

      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tickets(ticketID INTEGER PRIMARY KEY, customerName TEXT, carDescription TEXT, serviceDescription TEXT, creationDate TEXT, closeDate TEXT, vin INTEGER)',
        );
      },

      version: 1,
    );
  }

  //Making printing class values easier
  @override
  String toString() {
    return 'ServiceTicket{ticketID: $ticketID, customerName: $customerName, carDescription: $carDescription, serviceDescription: $serviceDescription, creationDate: $creationDate, closeDate: $closeDate, vin: $vin}';
  }
}
