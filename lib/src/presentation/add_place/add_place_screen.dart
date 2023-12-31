import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/place_location.dart';
import '../../providers/user_places.dart';
import 'components/image_input.dart';
import 'components/location_input.dart';


class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final titleController = TextEditingController();
  File? selectedImage;
  PlaceLocation? selectedLocation;

  void savePlace() {
    final enteredTitle = titleController.text;

    if (enteredTitle.isEmpty || selectedImage == null
        // ||
        // selectedLocation == null
        ) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        // .addPlace(enteredTitle, selectedImage!, selectedLocation!);
        .addPlace(enteredTitle, selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: ImageInput(
                onPickImage: (image) => selectedImage = image,
              ),
            ),
            const LocationInput(
                // onSelectLocation: (location) => selectedLocation = location,
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: savePlace,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
