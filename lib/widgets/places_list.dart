import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/screens/place_detail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.places,
  });

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, i) => ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(
            places[i].image,
          ),
        ),
        title: Text(
          places[i].title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: Text(
          places[i].location.address,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlaceDetailScreen(place: places[i]),
            ),
          );
        },
      ),
    );
  }
}
