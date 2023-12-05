import 'dart:async';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:service_app/main.dart';

class ServiceTicket {
  String customerName;
  String carDescription;
  String creationDate;
  String closeDate;
  String serviceDescription;
  String vin;
  int? ticketID;
  int isClosed;

  ServiceTicket({
    this.ticketID,
    required this.isClosed,
    required this.customerName,
    required this.carDescription,
    required this.creationDate,
    required this.closeDate,
    required this.serviceDescription,
    required this.vin,
  });

  Map<String, dynamic> toMap() {
    return {
      'isClosed': isClosed,
      'customerName': customerName,
      'carDescription': carDescription,
      'serviceDescription': serviceDescription,
      'creationDate': creationDate,
      'closeDate': closeDate,
      'vin': vin,
    };
  }

  //Making printing class values easier
  @override
  String toString() {
    return 'ServiceTicket{ticketID: $ticketID, isClosed: $isClosed, customerName: i$customerName, carDescription: $carDescription, serviceDescription: $serviceDescription, creationDate: $creationDate, closeDate: $closeDate, vin: $vin}';
  }
}

class DatabaseHelper {
  static Future<void> insertTicket(ServiceTicket ticket) async {
    // Get a reference to the database.
    final db = await ticketDatabase;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db?.insert(
      'tickets',
      ticket.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateTicket(ServiceTicket? ticket) async {
    // Get a reference to the database.
    final db = await ticketDatabase;

    // Update the given Dog.
    await db?.update(
      'tickets',
      ticket!.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'ticketID = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [ticket.ticketID],
    );
  }

  static Future<void> deleteTicket(ticket) async {
    // Get a reference to the database.
    final db = await ticketDatabase;

    // Remove the Dog from the database.
    await db?.delete(
      'tickets',
      // Use a `where` clause to delete a specific dog.
      where: 'ticketID = ?',
      // \\Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [ticket.ticketID],
    );
  }

  static Future<List<ServiceTicket>> fetchAllTickets(String? searchTerm) async {
    final db = await ticketDatabase;
    final List<Map<String, dynamic>> maps;

    if (searchTerm != null) {
      maps = await db!.rawQuery("SELECT * FROM tickets WHERE "
        "customerName LIKE '%$searchTerm%' OR "
        "carDescription LIKE '%$searchTerm%' OR "
        "serviceDescription LIKE '%$searchTerm%' OR "
        "vin LIKE '%$searchTerm%' OR "
        "creationDate LIKE '%$searchTerm%' OR "
        "closeDate LIKE '%$searchTerm%';"
      );
    }
    else {maps = await db!.query('tickets');}
    return List.generate(maps.length, (i) {
      return ServiceTicket(
        ticketID: maps[i]['ticketID'],
        isClosed: maps[i]['isClosed'],
        customerName: maps[i]['customerName'], 
        carDescription: maps[i]['carDescription'], 
        serviceDescription: maps[i]['serviceDescription'], 
        creationDate: maps[i]['creationDate'], 
        closeDate: maps[i]['closeDate'], 
        vin: maps[i]['vin']);
    });
  }
}