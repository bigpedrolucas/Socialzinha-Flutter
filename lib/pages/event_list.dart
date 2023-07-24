// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/events.dart';
import 'home.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    final Events events = Provider.of(context);

    return SingleChildScrollView(
        child: Container(
      color: orangePrimary,
      child: Column(
        children: [
          Container(
            height: 160,
            padding: EdgeInsets.all(20),
            child: Row(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                          'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2022/08/Route-e1660761170377.jpg?w=876&h=484&crop=1')),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Text("Olá bigpedrolucas",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Text("Bem vindo à página inicial",
                      style: TextStyle(
                          color: graphitePrimary,
                          fontFamily: 'Roboto',
                          fontSize: 14)),
                ],
              )
            ]),
          ),
          GridView.builder(
            padding: EdgeInsets.only(left: 4, right: 4),
            itemCount: events.count,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String eventTitle = events.byIndex(index)['titulo'];
              String dateTime = events.byIndex(index)['dataHora'];
              DateTime parsedDateTime = DateTime.parse(dateTime);
              String eventDate = DateFormat('dd/MM').format(parsedDateTime);
              String eventHour = DateFormat('HH:mm').format(parsedDateTime);

              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () =>
                        {Navigator.of(context).pushNamed('/event', arguments: {'id': index})},
                    child: Container(
                      width: 147,
                      height: 135,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(eventTitle,
                                      style: TextStyle(
                                        color: graphitePrimary,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                  Padding(padding: EdgeInsets.only(top: 4)),
                                  Text("5 participantes",
                                      style: TextStyle(
                                        color: orangePrimary,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ))
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.calendar_month,
                                                  color: orangePrimary,
                                                  size: 18),
                                              Text(eventDate,
                                                  style: TextStyle(
                                                    color: graphitePrimary,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                  ))
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(Icons.query_builder,
                                                  color: orangePrimary,
                                                  size: 18),
                                              Text(eventHour,
                                                  style: TextStyle(
                                                    color: graphitePrimary,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                  ))
                                            ]),
                                      ])
                                ])
                          ]),
                    ),
                  ));
            },
          ),
        ],
      ),
    ));
  }
}
