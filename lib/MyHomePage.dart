import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              SearchMapPlaceWidget(
                placeType: PlaceType.address,
                placeholder: 'Enter the city name',
                hasClearButton: true,
                apiKey: 'AIzaSyD0mFFadqunaV56Hl8hmJ2PT3aL9n95Jcc',
                onSelected: (Place place) async {
                  print("Seaching$place");
                  Geolocation geolocation = await place.geolocation;
                  _controller.animateCamera(
                      CameraUpdate.newLatLng(geolocation.coordinates));
                  _controller.animateCamera(
                      CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: SizedBox(
                  height: 500.0,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController mapController) {
                      setState(() {
                        _controller = mapController;
                      });
                    },
                    initialCameraPosition:
                        CameraPosition(zoom: 15.0, target: LatLng(25.590231, 85.144630)),
                    mapType: MapType.normal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
