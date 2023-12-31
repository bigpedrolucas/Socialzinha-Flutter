// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_app/constants.dart';

import '../models/db_provider.dart';

enum MenuItem { update, delete }

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  MenuItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>;
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    final id = int.parse(routeArgs['id'].toString());

    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.events;
      var event = list.firstWhere((e) => e.id == id);
      String eventTile = event.title;
      String eventLocal = event.local;
      DateTime dateTime = event.date;
      String eventDate = DateFormat('dd MMM yyyy', 'pt_BR').format(dateTime);
      String eventHour = DateFormat('HH:mm').format(dateTime);

      return SafeArea(
        child: Scaffold(
          body: Container(
              color: AppColors.lightGray,
              child: Column(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                      padding: EdgeInsets.only(bottom: 6),
                      height: 200,
                      decoration: BoxDecoration(
                          color: AppColors.orangePrimary,
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
                                      color: Colors.white, size: 26),
                                  onPressed: () => {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/')
                                  },
                                ),
                                PopupMenuButton<MenuItem>(
                                  initialValue: selectedMenu,
                                  onSelected: (value) async {
                                    if (value == MenuItem.update) {
                                      Navigator.of(context).pushNamed(
                                          '/event-form',
                                          arguments: {'id': id});
                                    } else if (value == MenuItem.delete) {
                                      Navigator.of(context).pop();
                                      provider.deleteEvent(id);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: MenuItem.update,
                                        child: Text('Editar')),
                                    PopupMenuItem(
                                        value: MenuItem.delete,
                                        child: Text('Excluir')),
                                  ],
                                )
                              ],
                            ),
                            Column(children: [
                              Center(
                                  child: Text(eventTile,
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
                                    Text(eventLocal,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                              Padding(padding: EdgeInsets.only(top: 4)),
                              Center(
                                  child: Text(eventDate,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                              Padding(padding: EdgeInsets.only(top: 4)),
                              Center(
                                  child: Text('${eventHour}h',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                            ]),
                            Padding(padding: EdgeInsets.only(top: 12)),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < 3; i++)
                                    Align(
                                        widthFactor: 0.4,
                                        child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor:
                                                AppColors.orangePrimary,
                                            child: CircleAvatar(
                                                radius: 14,
                                                backgroundImage: NetworkImage(
                                                    'https://i.pravatar.cc/150?img=$i')))),
                                  Align(
                                    widthFactor: 0.4,
                                    child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            AppColors.orangePrimary,
                                        child: CircleAvatar(
                                            radius: 14,
                                            backgroundColor:
                                                AppColors.graphitePrimary,
                                            child: Text("+1",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                        FontWeight.bold)))),
                                  )
                                ]),
                          ])),
                ),
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(top: 28, left: 28, right: 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 250,
                              child: EventsByStatusWidget(
                                  statusName: 'A FAZER',
                                  statusColor: Colors.pink)),
                          const SizedBox(width: 28),
                          Container(
                              width: 250,
                              child: EventsByStatusWidget(
                                  statusName: 'EM ANDAMENTO',
                                  statusColor: Colors.blue)),
                          const SizedBox(width: 28),
                          Container(
                              width: 250,
                              child: EventsByStatusWidget(
                                  statusName: 'CONCLUÍDO',
                                  statusColor: Colors.green)),
                        ],
                      )),
                ),
              ])),
        ),
      );
    });
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
              icon: Icon(Icons.add, color: AppColors.orangePrimary),
              onPressed: () => {print("add task pressed")},
            ),
            const SizedBox(width: 8),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(maxWidth: 30),
              iconSize: 26,
              icon: Icon(Icons.more_vert, color: AppColors.orangePrimary),
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
                    width: 250,
                    height: 90,
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
                                    width: 190,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Encomendar mesas e cadeiras',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors
                                                      .graphitePrimary)),
                                          Text('2 observações',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.grayPrimary))
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
