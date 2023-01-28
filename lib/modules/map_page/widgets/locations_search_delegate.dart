import 'package:flutter/material.dart';

import '../../../app/utils/text_styles.dart';
import '../../../domain/map_api.dart';

class LocationsSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final MapApi api = MapApi();
    return Scaffold(
        body: ListView.builder(
      itemCount: api.address.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => close(context, []),
          title: Text(
            api.address[index].address ?? 'No address',
            style: TextStyles.w500(12),
          ),
        );
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final MapApi api = MapApi();
    api.getNearbyDirections(query);
    return ListView.builder(
      itemCount: api.address.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => close(context, api.address[index]),
          title: Text(
            api.address[index].address ?? 'No address',
            style: TextStyles.w500(12),
          ),
        );
      },
    );
  }
}
