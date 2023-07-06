// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'home_page.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  @override
  Widget build(BuildContext context) {
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
                  CircleImage(
                      'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2022/08/Route-e1660761170377.jpg?w=876&h=484&crop=1'),
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
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () =>
                        {Navigator.of(context).pushReplacementNamed('/evento')},
                    child: Container(
                      width: 147,
                      height: 135,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Festinha na praia",
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
                                              Text("16/06",
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
                                              Text("20:00",
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

class CircleImage extends StatelessWidget {
  final String renderUrl;

  const CircleImage(this.renderUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(renderUrl),
        ),
      ),
    );
  }
}
