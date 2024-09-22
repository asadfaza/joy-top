import 'package:flutter/material.dart';
import 'package:joy_top/pages/card_view.dart';

class PropertyPage extends StatelessWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 200,
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      15), // Rounded corners with 20px radius
                  child: Image.network(
                    'https://admin.cspace.uz/uploads/03_2_d8c5812eb3.jpg', // Replace with real image URL
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(height: 16),

            // Description Section
            const Text(
              'Open the Olympic Games at Musée d’Orsay',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem ipsum dolor sit amet consectetur. Donec pharetra est quam cras facilisis. '
              'Magna purus ipsum eu odio nunc dignissim nibh condimentum. Id blandit facilisi '
              'diam consequat.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Property Details
            Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.people),
                    SizedBox(width: 8),
                    Text('15 people'),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.apartment),
                    SizedBox(width: 8),
                    Text('Studio'),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.square_foot),
                    SizedBox(width: 8),
                    Text('70 m²'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Amenities Section
            const Text(
              'Amenities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Chip(label: Text('Balcony')),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Chip(label: Text('Great View')),
                ),
                Chip(label: Text('Lights')),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Chip(label: Text('Bar')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Rating and Reviews
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    SizedBox(width: 4),
                    Text('4.9'),
                    SizedBox(width: 4),
                    Text('(24 reviews)'),
                  ],
                ),
                Text('100+ rents'),
              ],
            ),
            const SizedBox(height: 16),

            // Reviews Section
            const Text(
              'Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ListTile(
                  title: Text('Iroda'),
                  subtitle: Text(
                    'Lorem ipsum dolor sit amet consectetur. Aliquet cursus donec volutpat elementum lorem vel.',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Favorite Button and Continue Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Toggle favorite state here
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 50),
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    // Navigate to another page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfoDisplay(),
                      ),
                    );
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
