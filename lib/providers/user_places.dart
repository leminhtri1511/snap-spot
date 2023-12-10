import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snap_spot/models/place.dart';
import 'package:snap_spot/models/place_location.dart';

class UserPlaces extends StateNotifier<List<Place>> {
  UserPlaces() : super(const []);

  void addPlace(
    String placesTitle,
    File placesImage,
    // PlaceLocation placeLocation,
  ) {
    final newPlace = Place(
      title: placesTitle,
      image: placesImage,
      // location: placeLocation,
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
