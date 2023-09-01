class Event {
  final int id;
  final String title;
  final String local;
  final DateTime date;

  const Event({
    required this.id,
    required this.title,
    required this.local,
    required this.date,
  });

  // Event to Map
  Map<String, dynamic> toMap() => {
        'title': title,
        'local': local,
        'date': date.toString(),
      };

  // Map to Event
  factory Event.fromString(Map<String, dynamic> value) => Event(
      id: value['id'],
      title: value['title'],
      local: value['local'],
      date: DateTime.parse(value['date']));
}
