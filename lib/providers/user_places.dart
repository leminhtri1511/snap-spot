import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snap_spot/models/place.dart';

class UserPlaces extends StateNotifier<List<Place>> {
  UserPlaces() : super(const []);

  void addPlace(String placesTitle) {
    final newPlace = Place(title: placesTitle);
    state = [
      newPlace,
      ...state,
    ];
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlaces, List<Place>>(
  (ref) => UserPlaces(),
);
