import 'package:flutter/material.dart';
import 'package:joy_top/example.dart';
import 'package:table_calendar/table_calendar.dart';

class UserInfoDisplay extends StatefulWidget {
  @override
  _UserInfoDisplayState createState() => _UserInfoDisplayState();
}

class _UserInfoDisplayState extends State<UserInfoDisplay> {
  // Variables to store selected date
  DateTime today = DateTime.now();
  DateTime month = DateTime.now();
  String selectedTimeSlot = '';
  String selectedPaymentMethod = '';

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Widget calendarView() => TableCalendar(
      //headerVisible: false,
      rowHeight: 35,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: HeaderStyle(
          headerPadding: EdgeInsets.only(left: 10, bottom: 20),
          leftChevronVisible: false,
          rightChevronVisible: false,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      availableGestures: AvailableGestures.all,
      focusedDay: today,
      calendarStyle: const CalendarStyle(
        selectedDecoration:
            BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
        todayDecoration: BoxDecoration(
            color: Color.fromRGBO(213, 217, 231, 1), shape: BoxShape.circle),
      ),
      selectedDayPredicate: (day) => isSameDay(day, today),
      onDaySelected: _onDaySelected,
      firstDay: DateTime.utc(2022, 01, 01),
      lastDay: DateTime.utc(2025, 01, 01));

  Widget phoneView(Size screenSize) => ListView(
        children: [
          SizedBox(height: 30),
          Container(
              height: 350,
              width: 350,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: calendarView()),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: payment(),
          )
        ],
      );

  Widget webView() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: 500,
                  width: 400,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: calendarView()),
              Container(height: 700, width: 500, padding: EdgeInsets.all(10), child: payment())
            ],
          ),
        ],
      );

  Widget payment() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event details
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    15), // Rounded corners with 20px radius
                child: Image.network(
                  'https://admin.cspace.uz/uploads/03_2_d8c5812eb3.jpg', // Replace with your image URL
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Open the Olympic Games at Musée d\'Orsay',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Hosted by Said Mukhtidinov',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '100,000 UZS/hour',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),

          // Time slots section
          Text('Time slots',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2.5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            shrinkWrap: true,
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTimeSlot = timeSlots[index];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedTimeSlot == timeSlots[index]
                        ? Colors.yellow
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    timeSlots[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selectedTimeSlot == timeSlots[index]
                          ? Colors.black
                          : Colors.grey[700],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16.0),

          // Payment section
          Text('Payment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Total payment', style: TextStyle(color: Colors.grey)),
          Text(
            '200,000 UZS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          // Payment method selection
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            shrinkWrap: true,
            itemCount: paymentMethods.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = paymentMethods[index]['name'];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        selectedPaymentMethod == paymentMethods[index]['name']
                            ? Colors.grey[300]
                            : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(paymentMethods[index]['icon'],
                          size: 30, color: Colors.black),
                      Text(paymentMethods[index]['name']),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16.0),

          // Proceed payment button
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (selectedTimeSlot.isNotEmpty &&
                    selectedPaymentMethod.isNotEmpty) {
                  // Proceed with payment logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Payment of 200,000 UZS with $selectedPaymentMethod at $selectedTimeSlot is processed.'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Please select a time slot and payment method.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              child: Text('Proceed Payment'),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backColor,
        body: (screenSize.width >= 600) ? webView() : phoneView(screenSize));
  }
}
