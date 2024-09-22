import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> fetchVenues() async {
    // Создаем экземпляр Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Получаем данные из коллекции SPR_VENUE
    QuerySnapshot venueSnapshot = await firestore.collection('SPR_VENUE').get();

    // Создаем карту для хранения всех мест
    Map<String, dynamic> venuesMap = {};

    // Проходим по всем документам в коллекции SPR_VENUE
    for (var venueDoc in venueSnapshot.docs) {
      // Получаем данные из документа
      var venueData = venueDoc.data() as Map<String, dynamic>;

      // Получаем id места
      String venueId = venueData['id'];

      // Добавляем данные места в карту
      venuesMap[venueId] = {
        'area': venueData['area'],
        'capacity': venueData['capacity'],
        'description': venueData['description'],
        'merchant_id': venueData['merchant_id'],
        'name': venueData['name'],
        'price': venueData['price'],
        'type': venueData['type'],
      };
    }

    return venuesMap;
  }