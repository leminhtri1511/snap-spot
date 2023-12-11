import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import '../models/place.dart';

Future<Database> getDataBase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        // 'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class UserPlaces extends StateNotifier<List<Place>> {
  UserPlaces() : super(const []);

  Future<void> fetchSavedPlaces() async {
    final db = await getDataBase();
    final data = await db.query('user_places');

    final places = data
        .map(
          (row) => Place(
            identify: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            // location: PlaceLocation(
            //   latitude: row['lat'] as double,
            //   longitude: row['lng'] as double,
            //   address: row['address'] as String,
            // ),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(String placesTitle, File placesImage
      // PlaceLocation placeLocation,
      ) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(placesImage.path);
    final copiedImage = await placesImage.copy('${appDir.path}/$fileName');

    final newPlace = Place(
      title: placesTitle, image: copiedImage,
      // location: placeLocation,
    );

    final db = await getDataBase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      // 'lat': newPlace.location!.latitude,
      // 'lng': newPlace.location!.longitude,
      // 'address': newPlace.location!.address,
    });

    state = [newPlace, ...state];
  }

   Future<void> deletePlace(String placeId) async {
    final db = await getDataBase();
    await db.delete(
      'user_places',
      where: 'id = ?',
      whereArgs: [placeId],
    );

    state = state.where((place) => place.id != placeId).toList();
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlaces, List<Place>>(
  (ref) => UserPlaces(),
);
