// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:social_app/constants.dart';

import '../models/database_provider.dart';
import '../models/event.dart';

final TextEditingController _title = TextEditingController();
final TextEditingController _location = TextEditingController();
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

    return SafeArea(
        child: Scaffold(
      body: Container(
          color: AppColors.orangePrimary,
          child: Column(
            children: [
              TextField(
                controller: _title,
                decoration: const InputDecoration(hintText: 'Título'),
              ),
              TextField(
                controller: _location,
                decoration: const InputDecoration(hintText: 'Local'),
              ),
              TextField(
                controller: _dateTime,
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
                decoration: InputDecoration(
                  labelText: 'Data e Hora',
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final file = Event(
                      id: 0,
                      title: _title.text,
                      date: DateTime.parse(_dateTime.text),
                      local: _location.text,
                    );
                    provider.addEvent(file);
                    Navigator.of(context).pop();
                  },
                  child: Text("Salvar"))
            ],
          )),
    ));
  }
}
