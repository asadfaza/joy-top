import 'package:flutter/material.dart';
import 'package:joy_top/example.dart';
import 'package:joy_top/pages/profile.dart';

class FavoriteJoy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: backColor,
          centerTitle: (screenSize.width <= 600),
          foregroundColor: Colors.black,
          elevation: 0,
          leading: Container(),
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                      label: Text(
                        'whishlist',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton.icon(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile(),
                            ),
                          ),
                      icon: Icon(
                        Icons.person_outline,
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
          child: ListView.builder(
            itemCount: wishlist.length,
            itemBuilder: (context, index) {
              final item = wishlist[index];
              return ListTile(
                leading: item['image'] is IconData
                    ? CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(item['image'], color: Colors.black),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(item['image']),
                        radius: 25,
                      ),
                title: Text(
                  item['title'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'List • ${item['spaces']}',
                  style: TextStyle(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              );
            },
          ),
        ));
  }
}

final List<Map<String, dynamic>> wishlist = [
  {'title': 'Create new list', 'spaces': '0 spaces', 'image': Icons.add},
  {
    'title': 'Wedding',
    'spaces': '2 spaces',
    'image':
        'https://t3.ftcdn.net/jpg/03/05/02/04/360_F_305020459_6TuRfq7z1FakkT3JDJAqxXnxgRJpqQim.jpg'
  },
  {
    'title': 'Birthday',
    'spaces': '1 space',
    'image':
        'https://cdnjs.angroos.com/wp-content/uploads/2024/01/DALL%C2%B7E-2024-01-18-17.07.28-A-realistic-birthday-greeting-card-featuring-a-vibrant-celebratory-background.-In-the-center-_Happy-Birthday_-is-written-in-elegant-cursive-script.jpg'
  },
  {
    'title': 'Corporate',
    'spaces': '3 spaces',
    'image':
        'https://www.brinknews.com/wp-content/uploads/2019/12/shutterstock_1031044285.jpg'
  },
  {
    'title': 'Baby shower',
    'spaces': '0 spaces',
    'image':
        'https://img.freepik.com/free-vector/watercolor-baby-shower-card-with-footprints_1174-18.jpg'
  },
  {
    'title': 'Fundraiser',
    'spaces': '4 spaces',
    'image':
        'https://www.raisinghealth.org.uk/images/general-fr-images/fundraising_cropped-500x353.jpg'
  },
  {
    'title': 'Bridal shower',
    'spaces': '1 space',
    'image':
        'https://outerbloom.com/cdn/shop/articles/6_Perlengkapan_yang_Wajib_Ada_di_Bridal_Shower_1024x1024.jpg?v=1562664352'
  },
  {
    'title': 'Graduation',
    'spaces': '2 spaces',
    'image':
        'https://media.istockphoto.com/id/1371896330/photo/happy-asian-woman-in-his-graduation-day.jpg?s=612x612&w=0&k=20&c=Ur3moWl1fKFms-6UACseglMjoYAynYKzsanZpgK8lFk='
  },
];
