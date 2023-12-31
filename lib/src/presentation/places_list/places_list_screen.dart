import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snap_spot/src/configs/widget/text/paragraph.dart';

import '../../providers/user_places.dart';

import '../add_place/add_place_screen.dart';
import 'components/places_list.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});

  @override
  ConsumerState<PlacesListScreen> createState() {
    return _PlacesListScreen();
  }
}

class _PlacesListScreen extends ConsumerState<PlacesListScreen> {
  late Future<void> placesFuture;

  @override
  void initState() {
    super.initState();
    placesFuture = ref.read(userPlacesProvider.notifier).fetchSavedPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(title: const Paragraph(content: 'Your places')
          // actions: [
          //   IconButton(
          //     onPressed: () => Navigator.push(
          //       context,
          //       CupertinoPageRoute(
          //         builder: (context) => const AddPlaceScreen(),
          //       ),
          //     ),
          //     icon: const Icon(Icons.add),
          //   ),
          // ],
          ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 5,
        ),
        child: FutureBuilder(
          future: placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : PlacesList(
                      places: userPlaces,
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const AddPlaceScreen(),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
