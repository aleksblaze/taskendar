import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taskendar/models/event_list.dart'; 

class UnifiedCalendar extends StatefulWidget {
  @override
  _UnifiedCalendarState createState() => _UnifiedCalendarState();
}

class _UnifiedCalendarState extends State<UnifiedCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final eventDatabase = Provider.of<EventDatabase>(context);

    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; 
            });
            _showEventMenu(selectedDay, eventDatabase);
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: (day) => eventDatabase.events.where((event) => isSameDay(event.date, day)).toList(),
          locale: Localizations.localeOf(context).toString(), 
        ),
      ],
    );
  }

  void _showAddEventDialog(DateTime day, EventDatabase eventDatabase) {
    final TextEditingController _eventController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.addEvent),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(hintText: AppLocalizations.of(context)!.eventTitle),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              if (_eventController.text.isNotEmpty) {
                eventDatabase.addEvent(Event(_eventController.text, day));
              }
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.add),
          ),
        ],
      ),
    );
  }

  void _showEventMenu(DateTime day, EventDatabase eventDatabase) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('${AppLocalizations.of(context)!.eventsOn} ${day.toLocal()}'.split(' ')[0]),
          ),
          ...eventDatabase.events.where((event) => isSameDay(event.date, day)).map(
            (event) => ListTile(
              title: Text(event.title),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Navigator.pop(context);
                  eventDatabase.removeEvent(event);
                },
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text(AppLocalizations.of(context)!.addEvent),
            onTap: () {
              Navigator.pop(context);
              _showAddEventDialog(day, eventDatabase);
            },
          ),
        ],
      ),
    );
  }
}