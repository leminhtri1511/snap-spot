// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place({
    required this.title,
    required this.image,
    // this.location,
    String? identify,
  }) : id = identify ?? uuid.v4();

  final String id;
  final String title;
  final File image;
  // final PlaceLocation? location;
}
