import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snap_spot/models/place.dart';

class UserPlaces extends StateNotifier<List<Place>> {
  UserPlaces() : super(const []);

  void addPlace(String placesTitle, File placesImage) {
    final newPlace = Place(
      title: placesTitle,
      image: placesImage,
    );
    state = [
      newPlace,
      ...state,
    ];
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlaces, List<Place>>(
  (ref) => UserPlaces(),
);
