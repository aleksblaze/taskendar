import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Event {
  final String title;
  final DateTime date;

  Event(this.title, this.date);

  String timeToEvent(BuildContext context) {
    final difference = date.difference(DateTime.now());
    final localization = AppLocalizations.of(context)!;

    if (difference.inDays == 1) {
      return localization.oneDay(difference.inDays);
    } else if (difference.inDays > 2 && difference.inDays < 5) {
      return localization.twoDays(difference.inDays);
    } else if (difference.inDays >= 5) {
      return localization.inDays(difference.inDays);
    } else {
      return localization.today;
    }
  }

  @override
  String toString() => '$title on ${date.toLocal()}';
}

class EventDatabase extends ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => List.unmodifiable(_events);

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void removeEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  List<Event> getUpcomingEvents() {
    final now = DateTime.now();
    final upcomingEvents = _events.where((event) => event.date.isAfter(now)).toList();
    upcomingEvents.sort((a, b) => a.date.compareTo(b.date));
    return upcomingEvents.take(3).toList();
  }
}