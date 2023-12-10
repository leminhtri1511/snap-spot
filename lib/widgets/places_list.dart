import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snap_spot/models/place.dart';
import 'package:snap_spot/screens/place_detail_screen.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    this.places,
    super.key,
  });

  final List<Place>? places;

  @override
  Widget build(BuildContext context) {
    if (places!.isEmpty) {
      return Center(
        child: Text(
          'No places yet!',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
      itemCount: places?.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading:  CircleAvatar(
            radius: 25,
            backgroundImage: FileImage(places![index].image),
          ),
          title: Text(
            places![index].title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlaceDetailScreen(
                place: places![index],
              ),
            ));
          },
        ),
      ),
    );
  }
}
