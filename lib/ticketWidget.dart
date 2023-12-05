import 'package:flutter/material.dart';
import 'package:service_app/main.dart';
import 'package:service_app/ticketDatabase.dart';

class TicketWidget extends StatefulWidget {
  final ServiceTicket ticket;
  final Function(BuildContext context, ServiceTicket ticket) deleteTicket;
  final Function(BuildContext context, bool isNewTicket, ServiceTicket? ticket) changeTicketWidget;

  TicketWidget({
    required this.ticket,
    required this.changeTicketWidget,
    required this.deleteTicket,
  });

  @override
  State<StatefulWidget> createState() => TicketWidgetState();
}

class TicketWidgetState extends State<TicketWidget> {
  late String ticketStatus;

  @override
  Widget build(BuildContext context) {
    if (widget.ticket.isClosed == 1) {
      ticketStatus = 'Mark Open';
    } else {
      ticketStatus = 'Mark Closed';
    }

    return FractionallySizedBox(
      widthFactor: .85,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(255, 237, 237, 237),
        ),
        padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, left: 30.0),
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(8.0), child: Text('Ticket ID: ${widget.ticket.ticketID}', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
            Padding(padding: const EdgeInsets.all(8.0), child: Text('Name: ${widget.ticket.customerName}', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
            Padding(padding: const EdgeInsets.all(8.0), child: Text('Car: ${widget.ticket.carDescription}', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
            Padding(padding: const EdgeInsets.all(8.0), child: Text('Vin: ${widget.ticket.vin}', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
            Padding(padding: const EdgeInsets.all(8.0), child: Text('Service: ${widget.ticket.serviceDescription}', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
            Padding(padding: const EdgeInsets.all(8.0), child: Text('Ticket Creation Date: ${widget.ticket.creationDate}', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
            Padding(padding: const EdgeInsets.all(8.0), child: Text('Ticket Close Date: ${widget.ticket.closeDate}', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
            
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: darkBlue, // Background color
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: TextButton(
                        child: Text(
                          ticketStatus,
                          style: const TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {
                          if (widget.ticket.isClosed == 1) {
                            widget.ticket.isClosed = 0;
                            widget.ticket.closeDate = '';
                            DatabaseHelper.updateTicket(widget.ticket);
                          } else {
                            widget.ticket.isClosed = 1;
                            DateTime now = DateTime.now();
                            widget.ticket.closeDate = now.toString();
                            DatabaseHelper.updateTicket(widget.ticket);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: darkBlue, // Background color
                    ),
                    child: IconButton(
                      onPressed: () {
                        widget.changeTicketWidget(context, false, widget.ticket);
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.red, // Background color
                    ),
                    child: IconButton(
                      onPressed: () {
                        widget.deleteTicket(context, widget.ticket);
                      },
                      icon: const Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
