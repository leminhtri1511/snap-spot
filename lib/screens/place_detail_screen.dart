import 'package:flutter/material.dart';
import 'package:snap_spot/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({this.place, super.key});

  final Place? place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place!.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place!.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
