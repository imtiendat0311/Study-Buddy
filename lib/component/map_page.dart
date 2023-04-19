import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Map<String, Marker> _markers = {};
  var _selectedLocation;
  late GoogleMapController mapController;
  final LatLng downtown = const LatLng(42.963780123790706, -85.67955023003141);

  final LatLng healthcmp = const LatLng(42.971365869427345, -85.66226978456905);
  final LatLng allendale = const LatLng(42.96446862948017, -85.88915847813448);

  var location = [
    ["Steelcase Library", const LatLng(42.96394614131739, -85.68093140007414)],
    ["Health Campus", const LatLng(42.971365869427345, -85.66226978456905)],
    [
      "Kennedy Hall of Engineering",
      const LatLng(42.9640679023643, -85.6771772308788)
    ],
    ["Herny Hall", const LatLng(42.964827735285574, -85.88817864568391)],
    ["Kirkhof Center", const LatLng(42.962653026795245, -85.88932252309189)],
    ["Calder Art Center", const LatLng(42.96140660284385, -85.88308298077384)],
    ["Makinak Hall", const LatLng(42.966965050462, -85.88716259207733)],
    ["Au Sable Hall", const LatLng(42.96318816198113, -85.88564124914255)],
    [
      "Mary Idema Pew Library",
      const LatLng(42.96299943993292, -85.89003569458096)
    ],
    ["Padnos Hall", const LatLng(42.965338676743634, -85.88743217558815)],
  ];
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.clear();
      location.forEach((element) {
        final marker = Marker(
          markerId: MarkerId(element[0] as String),
          position: element[1] as LatLng,
          infoWindow: InfoWindow(title: element[0] as String?),
          onTap: () => setState(() {
            _selectedLocation = element[0] as String?;
          }),
        );
        _markers[element[0] as String] = marker;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     widget.onClosed(returnValue: "Hello");
      //   },
      //   child: Icon(FontAwesomeIcons.buildingColumns),
      // ),
      body: SafeArea(
          child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: allendale,
              zoom: 16,
            ),
            markers: _markers.values.toSet(),
          ),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 100,
                    height: 60,
                    child: FilledButton.tonal(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, _selectedLocation);
                        },
                        child: const Text("Submit")),
                  ))),
          Positioned(
              top: 10,
              right: 10,
              child: PopupMenuButton(
                  initialValue: allendale,
                  child: const SizedBox(
                      width: 70,
                      height: 70,
                      child: Card(
                        child: Icon(FontAwesomeIcons.buildingColumns),
                      )),
                  onSelected: (item) {
                    mapController.animateCamera(CameraUpdate.newLatLng(item));
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                            value: allendale, child: Text("Allendale Campus")),
                        PopupMenuItem(
                            value: downtown, child: Text("Downtown Campus")),
                        PopupMenuItem(
                            value: healthcmp, child: Text("Health Campus"))
                      ]))
        ],
      )),
    );
  }
}
