// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:social_app/constants.dart';

final TextEditingController _titleController = TextEditingController();
final TextEditingController _locationController = TextEditingController();
final TextEditingController _dateTimeController = TextEditingController();

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    //final Events events = Provider.of(context);

    return SafeArea(
        child: Scaffold(
      body: Container(
          color: AppColors.orangePrimary,
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Título'),
              ),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(hintText: 'Local'),
              ),
              TextField(
                controller: _dateTimeController,
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

                              _dateTimeController.text =
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
                    // Navigator.of(context).popUntil((route) => route.isFirst);
                    // Map<String, Object?> data = {
                    //   'titulo': _titleController.text,
                    //   'local': _locationController.text,
                    //   'dataHora': _dateTimeController.text
                    // };

                    // await events.addItem('evento', data);
                  },
                  child: Text("Salvar"))
            ],
          )),
    ));
  }
}
