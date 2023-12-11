import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snap_spot/src/configs/widget/text/paragraph.dart';
// import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/place.dart';
import '../../../providers/user_places.dart';
import '../../place_detail/place_detail_screen.dart';

class PlacesList extends ConsumerStatefulWidget {
  const PlacesList({
    this.places,
    this.database,
    super.key,
  });

  final List<Place>? places;
  final Database? database;

  @override
  ConsumerState<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends ConsumerState<PlacesList> {
  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider.notifier);

    void deletePlaces(int index) {
      final placeIdToDelete = userPlaces.state[index].id;
      userPlaces.deletePlace(placeIdToDelete);
    }

    if (widget.places!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/places_empty2.png',
              color: Colors.white70,
            ),
            const SizedBox(height: 10),
            const Paragraph(
              content: 'No place added yet!',
              size: 18,
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: widget.places?.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: FileImage(widget.places![index].image),
          ),
          title: Paragraph(
            content: widget.places![index].title,
            size: 16,
          ),
          // Text(
          //   widget.places![index].title,
          //   style: Theme.of(context)
          //       .textTheme
          //       .titleMedium!
          //       .copyWith(color: Theme.of(context).colorScheme.onBackground),
          // ),
          trailing: IconButton(
            onPressed: () => showCupertinoDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Paragraph(
                  content: 'Delete place',
                  color: Colors.black,
                ),
                content: const Paragraph(
                  content: 'Do you want to delete this place?',
                  color: Colors.black,
                  size: 15,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Paragraph(
                      content: 'No',
                      color: Colors.black,
                      size: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      deletePlaces(index);
                      Navigator.pop(context);
                    },
                    child: const Paragraph(
                      content: 'Yes',
                      color: Colors.black,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),

            //
            icon: const Icon(Icons.delete_forever),
          ),
          // subtitle: Text(
          //   places![index].location.address,
          //   style: Theme.of(context)
          //       .textTheme
          //       .bodySmall!
          //       .copyWith(color: Theme.of(context).colorScheme.onBackground),
          // ),
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailScreen(
                  place: widget.places![index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
