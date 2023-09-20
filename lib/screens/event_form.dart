// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:social_app/constants.dart';

import '../models/db_provider.dart';
import '../models/event.dart';

final TextEditingController _title = TextEditingController();
final TextEditingController _local = TextEditingController();
final TextEditingController _dateTime = TextEditingController();

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    final customSpacing = MediaQuery.of(context).size.width / 1.10;
    Event event;
    int id = -1;

    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.events;
      var isUpdating = routeArgs != null && routeArgs is Map<String, int>;

      if (isUpdating) {
        id = int.parse(routeArgs['id'].toString());
        event = list.firstWhere((e) => e.id == id);
        _title.text = event.title;
        _local.text = event.local;
        _dateTime.text = event.date.toString();
      }

      return SafeArea(
          child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 16, bottom: 16),
            color: AppColors.orangePrimary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width),
                    Container(
                      height: 55,
                      width: customSpacing,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _title,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          hintText: 'Título',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 109, 84, 84),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: customSpacing,
                      margin: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _local,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          hintText: 'Local',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 109, 84, 84),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 1.10,
                      margin: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _dateTime,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          hintText: 'Data e Hora',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 109, 84, 84),
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: today,
                            firstDate: DateTime(today.year),
                            lastDate: DateTime(today.year + 10),
                          ).then(
                            (selectedDate) {
                              if (selectedDate != null) {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then(
                                  (selectedTime) {
                                    if (selectedTime != null) {
                                      DateTime combinedDateTime = DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );

                                      _dateTime.text =
                                          combinedDateTime.toIso8601String();
                                    }
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                    height: 55,
                    width: customSpacing,
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                          final file = Event(
                            id: (isUpdating) ? id : 0,
                            title: _title.text,
                            date: DateTime.parse(_dateTime.text),
                            local: _local.text,
                          );
                          if (isUpdating) {
                            provider.updateEvent(file);
                          } else {
                            provider.addEvent(file);
                            _title.text = '';
                            _local.text = '';
                            _dateTime.text = '';
                          }

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: AppColors.orangePrimary),
                        )))
              ],
            )),
      ));
    });
  }
}
