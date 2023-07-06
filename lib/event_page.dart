// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'home_page.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List images = [
    'https://upload.wikimedia.org/wikipedia/commons/1/18/Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/Steve_Jobs_Headshot_2010-CROP2.jpg/640px-Steve_Jobs_Headshot_2010-CROP2.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Bill_Gates_2018.jpg/640px-Bill_Gates_2018.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        color: lightGray,
        child: Column(children: [
          Expanded(
            flex: 3,
            child: Container(
                padding: EdgeInsets.only(bottom: 6),
                height: 200,
                decoration: BoxDecoration(
                    color: orangePrimary,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                    )),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: Colors.white, size: 28),
                            onPressed: () => {
                              Navigator.of(context).pushReplacementNamed('/')
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.more_vert,
                                color: Colors.white, size: 28),
                            onPressed: () => {print("options pressed")},
                          )
                        ],
                      ),
                      Column(children: [
                        Center(
                            child: Text("Aniversário de Fulaninho",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        Padding(padding: EdgeInsets.only(top: 4)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.white, size: 12),
                              Text("Av. Rio Branco, 432",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ]),
                        Padding(padding: EdgeInsets.only(top: 4)),
                        Center(
                            child: Text("31 Mar, 2003",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                        Padding(padding: EdgeInsets.only(top: 4)),
                        Center(
                            child: Text("20:00h",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                      ]),
                      Padding(padding: EdgeInsets.only(top: 12)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < images.length; i++)
                              Align(
                                  widthFactor: 0.4,
                                  child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: orangePrimary,
                                      child: CircleAvatar(
                                          radius: 14,
                                          backgroundImage:
                                              NetworkImage(images[i])))),
                            Align(
                              widthFactor: 0.4,
                              child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: orangePrimary,
                                  child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.white,
                                      child: Text("+1",
                                          style: TextStyle(
                                              color: orangePrimary,
                                              fontSize: 12,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold)))),
                            )
                          ]),
                    ])),
          ),
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 200,
                        child: EventsByStatusWidget(
                            statusName: 'A FAZER', statusColor: Colors.pink)),
                    const SizedBox(width: 36),
                    Container(
                        width: 200,
                        child: EventsByStatusWidget(
                            statusName: 'EM PROGRESSO',
                            statusColor: Colors.blue)),
                    const SizedBox(width: 36),
                    Container(
                        width: 200,
                        child: EventsByStatusWidget(
                            statusName: 'CONCLUÍDO',
                            statusColor: Colors.green)),
                  ],
                )),
          ),
        ]));
  }
}

class EventsByStatusWidget extends StatefulWidget {
  final String statusName;
  final Color statusColor;
  const EventsByStatusWidget(
      {super.key, required this.statusName, required this.statusColor});

  @override
  State<EventsByStatusWidget> createState() => _EventsByStatusWidgetState();
}

class _EventsByStatusWidgetState extends State<EventsByStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: widget.statusColor),
              child: Center(
                  child: Text(widget.statusName,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 12)))),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(maxWidth: 30),
              iconSize: 26,
              icon: Icon(Icons.add, color: orangePrimary),
              onPressed: () => {print("options pressed")},
            ),
            const SizedBox(width: 8),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(maxWidth: 30),
              iconSize: 26,
              icon: Icon(Icons.more_vert, color: orangePrimary),
              onPressed: () => {print("options pressed")},
            )
          ]),
        ]),
        const SizedBox(height: 14),
        ListView.builder(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(bottom: 18),
                  child: Container(
                    width: 200,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.white),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        width: 6,
                                        height: 16,
                                        color: widget.statusColor))
                              ]),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Encomendar mesas e cadeiras',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: graphitePrimary)),
                                          Text('2 observações',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: grayPrimary))
                                        ]),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                          radius: 10,
                                          backgroundImage: NetworkImage(
                                              'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2022/08/Route-e1660761170377.jpg?w=876&h=484&crop=1'))),
                                ]),
                          )
                        ]),
                  ));
            }),
      ],
    ));
  }
}
