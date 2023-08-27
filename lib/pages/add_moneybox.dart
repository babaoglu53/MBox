import 'package:mbox/common/common.dart';


class AddMB extends StatefulWidget {
  const AddMB({super.key});

  @override
  State<AddMB> createState() => _AddMBState();
}

class _AddMBState extends State<AddMB> {
  var rowTextSize = 15.0;
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  Position? currentLocation;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.8809, 33.2577),
    zoom: 15,
  );

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            "Yeni Kumbara Ekle",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: SafeArea(
          child: Material(
            child: Container(
              color: Colors.white10,
              // height: 250,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      //autofocus: true,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "İşletme Adı",
                        prefixIcon: Icon(Icons.add_box),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: rowTextSize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "İşletme Sahibi",
                        prefixIcon: Icon(Icons.add_box),
                        border: OutlineInputBorder(),
                        // hintText: 'İşletme Sahibi',
                      ),
                      style: TextStyle(fontSize: rowTextSize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "İşletme Telefon No",
                        prefixIcon: Icon(Icons.add_box),
                        border: OutlineInputBorder(),
                        // hintText: 'İşletme Sahibi',
                      ),
                      style: TextStyle(fontSize: rowTextSize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "İşletme Adres",
                        prefixIcon: Icon(Icons.add_box),
                        border: OutlineInputBorder(),
                        // hintText: 'İşletme Sahibi',
                      ),
                      style: TextStyle(fontSize: rowTextSize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "İşletme Adres Detayı",
                        prefixIcon: Icon(Icons.add_box),
                        border: OutlineInputBorder(),
                        // hintText: 'İşletme Sahibi',
                      ),
                      style: TextStyle(fontSize: rowTextSize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: GoogleMap(
                            scrollGesturesEnabled: false,
                            liteModeEnabled: false,
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            markers: _markers,
                            zoomControlsEnabled: false,
                            myLocationEnabled: true,
                            gestureRecognizers: {
                              Factory<OneSequenceGestureRecognizer>(
                                  () => ScaleGestureRecognizer()),
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _goToLocation(),
                            icon: const Icon(Icons.location_on_sharp),
                            label: const Text("Konum Al"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text("Kumbara Ekle"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentLocation = position;
    });
  }

  Future<void> _goToLocation() async {
    var lat = currentLocation!.latitude;
    var long = currentLocation!.longitude;

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 15));
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_loc'),
          position: LatLng(lat, long),
          infoWindow: const InfoWindow(
            title: 'Konumunuz',
            snippet: 'İşletme konumu olarak\nburası kaydedilecektir',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

/*** Daha sonra birden fazla marker eklemek istersen bakarsin  ***/
  // static const LatLng firstLocation = LatLng(40.8809, 29.2577);

  // Set<Marker> getmarkers() {
  //   setState(() {
  //     _markers.add(const Marker(
  //       markerId: MarkerId("Marker 1"),
  //       position: firstLocation,
  //       infoWindow: InfoWindow(
  //         title: 'Konumunuz',
  //       ),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ));
  //   });

  //   return _markers;
  // }
}
