import 'package:flutter/material.dart';
import 'package:snap_spot/models/place.dart';

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
      itemBuilder: (context, index) => ListTile(
        title: Text(
          places![index].title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
