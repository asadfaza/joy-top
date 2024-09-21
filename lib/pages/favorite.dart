import 'package:flutter/material.dart';
import 'package:joy_top/example.dart';
import 'package:table_calendar/table_calendar.dart';

class FavoriteJoy extends StatefulWidget {
  const FavoriteJoy({super.key});

  @override
  State<FavoriteJoy> createState() => _FavoriteJoyState();
}

class _FavoriteJoyState extends State<FavoriteJoy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Center(
            child: Text('joytop',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'DelaGothicOne'))),
      ),
      body: UserInfoDisplay()
    );
  }
}
class UserInfoDisplay extends StatefulWidget {
  @override
  _UserInfoDisplayState createState() => _UserInfoDisplayState();
}

class _UserInfoDisplayState extends State<UserInfoDisplay> {
  // Variables to store selected date
  DateTime today = DateTime.now();
  DateTime month = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Column(
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20
              ),
              child: TableCalendar(
                  //headerVisible: false,
                  rowHeight: 35,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: HeaderStyle(
                      headerPadding: EdgeInsets.only(
                          left: 10,
                          bottom: 20),
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  availableGestures: AvailableGestures.all,
                  focusedDay: today,
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                        color: Color.fromRGBO(213, 217, 231, 1),
                        shape: BoxShape.circle),
                  ),
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  onDaySelected: _onDaySelected,
                  firstDay: DateTime.utc(2022, 01, 01),
                  lastDay: DateTime.utc(2025, 01, 01)),
            ),
          ),]));}
          }
