import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/providers/places_provider.dart';
import 'package:favorite_places_app/screens/place_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({
    super.key,
    required this.places,
    required this.messenger,
  });

  final List<Place> places;
  final ScaffoldMessengerState messenger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      itemBuilder: (ctx, i) => Dismissible(
        key: ValueKey(places[i].id),
        onDismissed: (direction) async {
          try {
            await ref.read(placesProvider.notifier).removePlace(places[i]);
          } catch (e) {
            messenger.showSnackBar(
              const SnackBar(
                content: Text('There was an error removing the place.'),
              ),
            );
          }
        },
        child: ListTile(
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
      ),
    );
  }
}
