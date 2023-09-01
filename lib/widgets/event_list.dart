// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/database_provider.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  late Future _eventList;

  Future _getEventList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchEvents();
  }

  @override
  void initState() {
    super.initState();
    _eventList = _getEventList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _eventList,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Consumer<DatabaseProvider>(builder: (_, db, __) {
                var list = db.events;
                return SingleChildScrollView(
                    child: Container(
                  color: AppColors.orangePrimary,
                  child: Column(
                    children: [
                      Container(
                        height: 160,
                        padding: EdgeInsets.all(20),
                        child: Row(children: const <Widget>[
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
                                      color: AppColors.graphitePrimary,
                                      fontFamily: 'Roboto',
                                      fontSize: 14)),
                            ],
                          )
                        ]),
                      ),
                      GridView.builder(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        itemCount: list.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String eventTitle = list[index].title;
                          DateTime dateTime = list[index].date;
                          String eventDate =
                              DateFormat('dd/MM').format(dateTime);
                          String eventHour =
                              DateFormat('HH:mm').format(dateTime);
                          return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).pushNamed('/event',
                                      arguments: {'id': index})
                                },
                                child: Container(
                                  width: 147,
                                  height: 135,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(eventTitle,
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .graphitePrimary,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  )),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4)),
                                              Text("5 participantes",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.orangePrimary,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ))
                                            ]),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .calendar_month,
                                                              color: AppColors
                                                                  .orangePrimary,
                                                              size: 18),
                                                          Text(eventDate,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .graphitePrimary,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 12,
                                                              ))
                                                        ]),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .query_builder,
                                                              color: AppColors
                                                                  .orangePrimary,
                                                              size: 18),
                                                          Text(eventHour,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .graphitePrimary,
                                                                fontFamily:
                                                                    'Roboto',
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
              });
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
