import 'package:flutter/material.dart';
import 'package:joy_top/example.dart';
import 'package:joy_top/pages/favorite.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: backColor,
          centerTitle: (screenSize.width <= 600),
          foregroundColor: Colors.black,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.03),
            child: GestureDetector(
              onTap: () =>
                  (screenSize.width <= 600) ? null : Navigator.pop(context),
              child: Text(
                'joytop',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          actions: (screenSize.width >= 600)
              ? [
                  TextButton.icon(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoriteJoy(),
                            ),
                          ),
                      icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.black,
                      ),
                      label: Text(
                        'whishlist',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      label: Text(
                        'profile',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.help_outline,
                        color: Colors.black,
                      ),
                      label: Text(
                        'help',
                        style: TextStyle(color: Colors.black),
                      )),
                  SizedBox(
                    width: screenSize.width * 0.05,
                  )
                ]
              : null,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Profile Section
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    // Profile Image and Info
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Profile Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg', // Replace with actual URL or asset
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Maggie',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '24 y.o.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '+998 90 999 99 99',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Tashkent, Uzbekistan',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 20),
                          // Events Card
                          Card(
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    '100+',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'events',
                                    style: TextStyle(color: Colors.grey, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 20),

              // Right Content Section
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // About Section
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. '
                      'Donec pharetra est quam cras facilisis. '
                      'Magna purus ipsum eu odio nunc dignissim nibh condimentum. '
                      'Id blandit facilisi diam consequat. Nibh in quisque orci fermentum amet.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    // Specialties Section
                    Text(
                      'Specialties',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        SpecialtyChip('Conferences'),
                        SpecialtyChip('Seminars'),
                        SpecialtyChip('Workshops'),
                        SpecialtyChip('Product launches'),
                        SpecialtyChip('Team-building activities'),
                        SpecialtyChip('Business meetings'),
                        SpecialtyChip('Networking events'),
                        SpecialtyChip('Trade shows and exhibitions'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecialtyChip extends StatelessWidget {
  final String label;

  SpecialtyChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
