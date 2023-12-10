import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snap_spot/providers/user_places.dart';
import 'package:snap_spot/screens/add_place_screen.dart';
import 'package:snap_spot/widgets/places_list.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () => 
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AddPlaceScreen(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 5,
        ),
        child: PlacesList(
          places: userPlaces,
        ),
      ),
    );
  }
}
