// import 'dart:convert';
// import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:http/http.dart' as http;
import 'package:snap_spot/models/place_location.dart';
import 'package:snap_spot/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    // required this.onSelectLocation,
  });

  // final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? pickedLocation;

  var isGettingLocation = false;

  // String get locationImage {
  //   if (pickedLocation == null) {
  //     return 'empty location data';
  //   }
  //   final latitude = pickedLocation?.latitude;
  //   final longitude = pickedLocation?.longitude;

  //   return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=YOUR_API_KEY';
  // }

  Future<void> savePlace(double lat, double lng) async {
    // final url = Uri.parse(
    //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=YOUR_API_KEY');
    // final response = await http.get(url);
    // final resData = jsonDecode(response.body);
    // final address = resData['results'][0]['formatted_address'];

    setState(() {
      // pickedLocation = PlaceLocation(
      //   latitude: lat,
      //   longitude: lng,
      //   address: address,
      // );
      isGettingLocation = false;
    });

    // widget.onSelectLocation(pickedLocation!);
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    LocationData locationData;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    if (kDebugMode) {
      print('Vi do: $lat');
      print('Kinh do: $lng');
    }

    savePlace(lat, lng);
  }

  void openGgMap() async {
    final locationOnMap = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );

    if (locationOnMap == null) {
      return;
    }

    savePlace(locationOnMap.latitude, locationOnMap.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'Place location',
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    // if (pickedLocation != null) {
    //   previewContent = Image.network(
    //     locationImage,
    //     fit: BoxFit.cover,
    //     width: double.infinity,
    //     height: double.infinity,
    //   );
    // }

    if (isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
            ),
            TextButton.icon(
              onPressed: openGgMap,
              icon: const Icon(Icons.map),
              label: const Text('Open map'),
            ),
          ],
        )
      ],
    );
  }
}
