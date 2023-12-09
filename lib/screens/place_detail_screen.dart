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
      body: Center(
        child: Text(
          place!.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
