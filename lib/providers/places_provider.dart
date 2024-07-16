import 'package:favorite_places_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  void addPlace(Place place) {
    state = [...state, place];
  }

  void removePlace(Place place) {
    state = state.where((plc) => plc.id != place.id).toList();
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
