import 'package:flutter/material.dart';
import 'package:service_app/main.dart';
import 'package:service_app/ticketDatabase.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:service_app/ticketWidget.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<StatefulWidget> createState() => TicketPageState();
}

class TicketPageState extends State<TicketPage> {
  final controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: darkBlue,
        centerTitle: true,
        title: 
        Container(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
              Title(
                child: const Text('Service Tickets', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), 
                color: Colors.white
              ),
            ])
          )
        )
      ),
      body: 
      Column(children: <Widget>[
        const SizedBox(height: 25),
        FractionallySizedBox(
          widthFactor: .8,
          child: SearchBar(
            controller: controller,
            onSubmitted: (text) async {
              await loadTickets(context, text);
              setState(() {});
            },
            trailing: <Widget>[
              Tooltip(
                message: 'Search Button',
                child: IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () async {
                    await loadTickets(context, controller.text);
                    setState(() {});
                  },
                )
              )
            ],
          ),
        ),
        const SizedBox(height: 25),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: darkBlue, // Background color
                ),
                child: TextButton(
                  child: const Text('Show All', style: TextStyle(color: Colors.white, fontSize: 23)),
                  onPressed: () async {
                    await loadTickets(context, null);
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 30),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: darkBlue, // Background color
                ),
                child: TextButton(
                  child: const Text('Add Ticket', style: TextStyle(color: Colors.white, fontSize: 23)),
                  onPressed: () {
                    changeTicketWidget(context, true, null);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        loadTickets(context, null)
      ]),
    );
  }

  Future<void> changeTicketWidget(BuildContext context, bool isNewTicket, ServiceTicket? ticket) async {
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
          backgroundColor: offWhite,
          title: const Text('Enter Ticket Information', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Expanded(
            child: Column(
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
                  child: Align(alignment: Alignment.center, 
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: darkBlue, // Background color
                          ),
                          child: TextButton(
                            onPressed: () {Navigator.of(context).pop();}, 
                            child: const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text('Cancel', style:TextStyle(color: Colors.white, fontSize: 20)))
                          ),
                        ),
                        
                        const SizedBox(width: 12.0),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color.fromARGB(255, 62, 102, 63), // Background color
                          ),
                          child: TextButton(
                            onPressed: () async {
                              canSave = 0;
                              for (var validate in validators) {if (validate.currentState!.validate()) canSave++;}
                              
                              if (canSave == controllers.length) {
                                if (!isNewTicket) {
                                  ticket!.customerName = nameController.text;
                                  ticket.carDescription = carController.text;
                                  ticket.serviceDescription = serviceController.text;
                                  ticket.vin = vinController.text;
                                  await DatabaseHelper.updateTicket(ticket);
                                }
                                else {
                                  DateTime now = DateTime.now();
                                  creationDate = now.toString();

                                  ServiceTicket newTicket = ServiceTicket(isClosed: 0, customerName: nameController.text, carDescription: carController.text, 
                                  creationDate: creationDate, closeDate: '', serviceDescription: serviceController.text, vin: vinController.text);
                                  await DatabaseHelper.insertTicket(newTicket);
                                }

                                setState((){});
                                if (context.mounted) Navigator.of(context).pop();
                              }
                            },
                            child: const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text('Save', style:TextStyle(color: Colors.white, fontSize: 20)))
                          )     
                        )             
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        );
      }
    );    
  }

  Future<void> deleteTicket(BuildContext context, ServiceTicket ticket) {
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
                    color: darkBlue, // Background color
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
                        setState(() {});
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
    TextStyle style = TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
    return Expanded(
      child: FutureBuilder<List<ServiceTicket>>(
        future: DatabaseHelper.fetchAllTickets(searchTerm),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {return const CircularProgressIndicator();} 
          else if (snapshot.hasError) {return Padding(padding: EdgeInsets.only(top: 20), child: Text('Error has occured: ${snapshot.error}', style: style));} 
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {return Padding(padding: EdgeInsets.only(top: 20), child: Text('No tickets available.', style: style));} 
          else {
            List<ServiceTicket> tickets = snapshot.data!;
            
            return ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {return TicketWidget(ticket: tickets[index], changeTicketWidget: changeTicketWidget, deleteTicket: deleteTicket,);}
            );
          }
        }
      )
    );
  }
}