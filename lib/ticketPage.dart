import 'package:flutter/material.dart';
import 'package:service_app/main.dart';
import 'package:service_app/ticketDatabase.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<StatefulWidget> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final controller = SearchController();
  String? searchTerm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500.0),
            color: const Color.fromARGB(255, 237, 237, 237),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
              Title(
                child: const Text(
                  'Service Tickets', 
                  style: TextStyle(fontWeight: FontWeight.bold)), 
                  color: Colors.black
                ),
                const SizedBox(width: 20.0),
                IconButton(
                  onPressed: () {changeTicketWidget(context, true, null);}, 
                  icon: const Icon(Icons.add_circle, color: Colors.blueGrey, size: 40.0),
                ),
            ])
          )
        )
      ),
      body: 
      Column(children: <Widget>[
        SearchBar(
          controller: controller,
          padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
          trailing: <Widget>[
            Tooltip(
              message: 'Search Button',
              child: IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () {searchTerm = controller.text;},
              )
            )
          ],
        ),
        
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.blueGrey, // Background color
          ),
          child: TextButton(
              child: const Text('Show All', style: TextStyle(color: Colors.white)),
              onPressed: searchTerm = null,
          ),
        ),

        loadTickets(context, searchTerm)
      ]),
    );
  }

  static Future<void> changeTicketWidget(BuildContext context, bool isNewTicket, ServiceTicket? ticket) async {
    const String errorMessage = 'Field cannot be empty';
    String creationDate;

    final nameController = TextEditingController();
    final carController = TextEditingController();
    final vinController = TextEditingController();
    final serviceController = TextEditingController();
    List<TextEditingController> controllers = [nameController, carController, vinController, serviceController];

    if (ticket != null) {
      nameController.text = ticket.customerName;
      carController.text = ticket.carDescription;
      serviceController.text = ticket.serviceDescription;
      vinController.text = ticket.vin;
    }

    final GlobalKey<FormFieldState> nameKey = GlobalKey();
    final GlobalKey<FormFieldState> carKey = GlobalKey();
    final GlobalKey<FormFieldState> vinKey = GlobalKey();
    final GlobalKey<FormFieldState> serviceKey = GlobalKey();
    var validators = [nameKey, carKey, vinKey, serviceKey];
    int canSave = 0;

    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Ticket'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //Customer name field
              TextFormField(
                
                key: nameKey,
                controller: nameController, 
                validator: (value) {
                  if (value == null || value.isEmpty) return errorMessage;
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Enter customer name.'), 
              ),

              //Car description field
              TextFormField(
                key: carKey,
                controller: carController, 
                validator: (value) {
                  if (value == null || value.isEmpty) return errorMessage;
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Enter car description.'), 
              ),

              //VIN field
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(17)],
                key: vinKey,
                controller: vinController, 
                validator: (value) {
                  if (value == null || value.isEmpty) return errorMessage;
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Enter VIN.'), 
              ),

              //Service description field
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                key: serviceKey,
                controller: serviceController, 
                validator: (value) {
                  if (value == null || value.isEmpty) return errorMessage;
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Enter service description.'), 
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blueGrey, // Background color
                      ),
                      child: TextButton(
                        onPressed: () {Navigator.of(context).pop();}, 
                        child: const Text('Cancel', style:TextStyle(color: Colors.white))
                      ),
                    ),
                    
                    const SizedBox(width: 12.0),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.green, // Background color
                      ),
                      child: TextButton(
                        onPressed: () async {
                          canSave = 0;
                          for (var validate in validators) {if (validate.currentState!.validate()) canSave++;}
                          
                          if (!isNewTicket) {
                            ticket!.customerName = nameController.text;
                            ticket.carDescription = carController.text;
                            ticket.serviceDescription = serviceController.text;
                            ticket.vin = vinController.text;

                            DatabaseHelper.updateTicket(ticket);
                          }

                          if (canSave == controllers.length) {
                            DateTime now = DateTime.now();
                            creationDate = now.toString();

                            ServiceTicket ticket = ServiceTicket(isClosed: 0, customerName: nameController.text, carDescription: carController.text, 
                            creationDate: creationDate, closeDate: '', serviceDescription: serviceController.text, vin: vinController.text);
                            await DatabaseHelper.insertTicket(ticket);
                            if (context.mounted) Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Save', style:TextStyle(color: Colors.white))
                      )     
                    )             
                  ],
                ),
              )
            ],
          ),
        );
      }
    );    
  }

  static Future<void> deleteTicket(BuildContext context, ServiceTicket ticket) {
    return showDialog(
      context:  context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this?', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blueGrey, // Background color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    ),
                  )
                ),
                const SizedBox(width: 12.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.red, // Background color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 5),
                    child: TextButton(
                      onPressed: () {
                        DatabaseHelper.deleteTicket(ticket);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    ),
                  )
                ),
              ]
            )
          )
        );
      }
    );
  }

  Expanded loadTickets(BuildContext context, String? searchTerm) {
    return Expanded(
      child: FutureBuilder<List<ServiceTicket>>(
        future: DatabaseHelper.fetchAllTickets(searchTerm),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {return const CircularProgressIndicator();} 
        else if (snapshot.hasError) {return const Padding(padding: EdgeInsets.only(top: 20), child: Text('No tickets available.'));} 
        else if (!snapshot.hasData || snapshot.data!.isEmpty) {return const Padding(padding: EdgeInsets.only(top: 20), child: Text('No tickets available.'));} 
        else {
          List<ServiceTicket> tickets = snapshot.data!;
          
          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {return TicketWidget(ticket: tickets[index]);}
          );
        }
      })
    );
  }
}

class TicketWidget extends StatelessWidget {
  TextStyle style = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  late String ticketStatus;
  final ServiceTicket ticket;

  TicketWidget({required this.ticket});

  @override
  Widget build(BuildContext context) {
    if (ticket.isClosed == 0) {ticketStatus = 'Mark Open';}
    else {ticketStatus = 'Mark Closed';}

    return Container(
      width: MediaQuery.of(context).size.width * .6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(255, 237, 237, 237),
      ),
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, left: 30.0),
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(8.0), child: Text('Ticket ID: ${ticket.ticketID}', style: style)),
          Padding(padding: const EdgeInsets.all(8.0), child: Text('Name: ${ticket.customerName}', style: style)),
          Padding(padding: const EdgeInsets.all(8.0), child: Text('Car: ${ticket.carDescription}', style: style)),
          Padding(padding: const EdgeInsets.all(8.0), child: Text('Vin: ${ticket.vin}', style: style)),
          Padding(padding: const EdgeInsets.all(8.0), child: Text('Service: ${ticket.serviceDescription}', style: style)),
          Padding(padding: const EdgeInsets.all(8.0), child: Text('Ticket Creation Date: ${ticket.creationDate}', style: style)),
          Padding(padding: const EdgeInsets.all(8.0), child: Text('Ticket Close Date: ${ticket.closeDate}', style: style)),
          
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: <Widget>[

                // Style for the Mark Closed button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blueGrey, // Background color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 5),
                    child: TextButton(
                      child: Text(ticketStatus, style: const TextStyle(color: Colors.white, fontSize: 20.0)),
                      onPressed: () {
                        if (ticket.isClosed == 0) {
                          ticket.isClosed = 1;
                          ticket.closeDate = '';
                          DatabaseHelper.updateTicket(ticket);
                        } else {
                          ticket.isClosed = 0;
                          DateTime now = DateTime.now();
                          ticket.closeDate = now.toString();
                          DatabaseHelper.updateTicket(ticket);
                        }
                      },
                    ),
                  )
                ),

                const SizedBox(width: 12.0),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blueGrey, // Background color
                  ),
                  child: IconButton(
                    onPressed: () {
                      _TicketPageState.changeTicketWidget(context, false, ticket);
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),

                // Add spacing between buttons
                const SizedBox(width: 12.0),

                // Style for the Delete button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.red, // Background color
                  ),
                  child: IconButton(
                    onPressed: () {
                      _TicketPageState.deleteTicket(context, ticket);
                    },
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ]
            )
          )
        ]
      )
    );
  }
}