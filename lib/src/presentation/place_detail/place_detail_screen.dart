import 'package:flutter/material.dart';

import '../../models/place.dart';
import '../map/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({required this.place, super.key});

  final Place place;

  // String get locationImage {
  //   final lat = place.location!.latitude;
  //   final lng = place.location!.longitude;
  //   return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=YOUR_API_KEY';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // GestureDetector(
                //   onTap: () => Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) =>  MapScreen(
                //         location: place.location!,
                //         isSelecting: false,
                //       ),
                //     ),
                //   ),
                //   child: CircleAvatar(
                //     radius: 70,
                //     backgroundImage: NetworkImage(locationImage),
                //   ),
                // ),
                // Container(
                //   decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [
                //         Colors.transparent,
                //         Colors.black45,
                //       ],
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //     ),
                //   ),
                //   alignment: Alignment.center,
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 25,
                //     vertical: 16,
                //   ),
                //   child: Text(
                //     place.location.address,
                //     textAlign: TextAlign.center,
                //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
                //           color: Theme.of(context).colorScheme.onPrimary,
                //         ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MapScreen(),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Text(
                      'Your place location',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black45,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 30,
                  ),
                  child: Text(
                    'Your place address',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
