import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmgapp/src/doctors/home/dateProvider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime now = DateTime.now();

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendar')),
      body: Consumer<DateProvider>(
          builder: (BuildContext context, DateProvider dateProviderModel, Widget? child)=>TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(now.year, now.month - 1, now.day),
        lastDay: DateTime(now.year, now.month + 1, 0),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            dateProviderModel.selectedDate = selectedDay;
            print('New selected date1 $selectedDay' );
            dateProviderModel.setDate(selectedDay);
            Navigator.of(context).pop();
          });
        },
      ),
    ));
  }
}
