import 'package:flutter/material.dart';
import 'package:joy_top/example.dart';
import 'package:joy_top/pages/calendar_view.dart';
import 'package:joy_top/pages/favorite.dart';
import 'package:joy_top/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final tabs = [const MainPage(), FavoriteJoy(), Profile()];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: (screenSize.width <= 600)
            ? BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon((_currentIndex == 0)
                          ? Icons.search_rounded
                          : Icons.search_outlined),
                      label: 'search'),
                  BottomNavigationBarItem(
                      icon: Icon((_currentIndex == 1)
                          ? Icons.favorite
                          : Icons.favorite_outline),
                      label: 'wish list'),
                  BottomNavigationBarItem(
                      icon: Icon((_currentIndex == 2)
                          ? Icons.person
                          : Icons.person_outline),
                      label: 'profile'),
                ],
                iconSize: 25,
                onTap: (index) async {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                unselectedFontSize: 11,
                selectedFontSize: 11,
                selectedLabelStyle: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                selectedItemColor: firstColor,
                unselectedItemColor: Colors.black,
                elevation: 0,
                backgroundColor: backColor,
              )
            : null);
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _idController = TextEditingController();
  var _errorText;
  double scaleFactor = 45;
  String? typeValue, capacityValue, areaValue;
  List<IconData> typeIcons = [
    Icons.apartment,
    Icons.diversity_2,
    Icons.space_dashboard_outlined,
    Icons.podcasts_outlined,
    Icons.groups,
    Icons.brush
  ];

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  Widget phoneView(Size screenSize) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: scaleFactor,
                width: 120,
                child: dropDown(
                    error: _errorText,
                    text: 'Type',
                    size: screenSize,
                    list: typeList,
                    value: typeValue,
                    onChanged: (value) {
                      setState(() {
                        typeValue = value!;
                      });
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: scaleFactor,
                width: 120,
                child: dropDown(
                    error: _errorText,
                    text: 'Capacity',
                    size: screenSize,
                    list: capacityList,
                    value: capacityValue,
                    onChanged: (value) {
                      setState(() {
                        capacityValue = value!;
                      });
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: scaleFactor,
                width: 80,
                child: dropDown(
                    error: _errorText,
                    text: 'area',
                    size: screenSize,
                    list: areaList,
                    value: areaValue,
                    onChanged: (value) {
                      setState(() {
                        areaValue = value!;
                      });
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: scaleFactor,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                    //ID text field
                    textInputAction: TextInputAction.next,
                    controller: _idController,
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Enter the Student ID";
                      } else
                        return null;
                    },
                    decoration: fieldDesign(
                        isRound: false,
                        icon: null,
                        text: 'Search...',
                        size: screenSize)),
              ),
              Container(
                  width: scaleFactor,
                  height: scaleFactor,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1, // Border width (thin border)
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0), // Left side rounded
                      bottomLeft: Radius.circular(0), // Left side rounded
                      topRight: Radius.circular(10), // Right side sharp
                      bottomRight: Radius.circular(10), // Right side sharp
                    ), // Optional: Rounded corners
                  ),
                  child: IconButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onPressed: () {}))
            ],
          ),
        ],
      );

  Widget webView(Size screenSize) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: scaleFactor,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
                //ID text field
                textInputAction: TextInputAction.next,
                controller: _idController,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Enter the Student ID";
                  } else
                    return null;
                },
                decoration: fieldDesign(
                    isRound: true,
                    icon: null,
                    text: 'Search...',
                    size: screenSize)),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: scaleFactor,
                width: 120,
                child: dropDown(
                    error: _errorText,
                    text: 'Type',
                    size: screenSize,
                    list: typeList,
                    value: typeValue,
                    onChanged: (value) {
                      setState(() {
                        typeValue = value!;
                      });
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: scaleFactor,
                width: 120,
                child: dropDown(
                    error: _errorText,
                    text: 'Capacity',
                    size: screenSize,
                    list: capacityList,
                    value: capacityValue,
                    onChanged: (value) {
                      setState(() {
                        capacityValue = value!;
                      });
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: scaleFactor,
                width: 80,
                child: dropDown(
                    error: _errorText,
                    text: 'area',
                    size: screenSize,
                    list: areaList,
                    value: areaValue,
                    onChanged: (value) {
                      setState(() {
                        areaValue = value!;
                      });
                    }),
              ),
            ],
          ),
          Container(
              height: scaleFactor,
              width: scaleFactor,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 1, // Border width (thin border)
                ),
                borderRadius:
                    BorderRadius.circular(10), // Optional: Rounded corners
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 18,
                  ),
                  onPressed: () {}))
        ],
      );

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
          title: Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.03),
            child: Text(
              'joytop',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
        body: Column(
          children: [
            (screenSize.width <= 600)
                ? phoneView(screenSize)
                : webView(screenSize),
            Container(
                height: 40,
                width: screenSize.width * 0.9,
                margin: EdgeInsets.only(top: 20),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Horizontal scrolling
                    itemCount: typeList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0), // Add padding between items
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            typeIcons[index],
                            size: 24,
                            color: Colors.black,
                          ), // Display the icon
                          label: Text(
                            typeList[index],
                            style: TextStyle(color: Colors.black),
                          ), // Display the text
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Add border radius
                            ),
                            side: BorderSide(
                                color:
                                    Colors.grey), // Border color for the button
                          ),
                        ),
                      );
                    })),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 30, top: 30, bottom: 10),
              child: Text(
                'Recommendations',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            Container(
              height: (screenSize.width <= 600)
                  ? screenSize.height - 333
                  : screenSize.height - 160,
              margin: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  right: screenSize.width * 0.04),
              child: GridView.builder(
                padding: EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (screenSize.width <= 600)
                      ? 2
                      : (screenSize.width <= 1000)
                          ? 4
                          : 5,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75, // Соотношение сторон для карточек
                ),
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final recommendation = recommendations[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyPage(),
                      ),
                    ),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  15), // Rounded corners with 20px radius
                              child: Image.network(
                                recommendation['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            recommendation['title']!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            recommendation['host']!,
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            recommendation['price']!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
