// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inventmarket_app/src/widgets/addSucursal.dart';
import '../theme/ubicacion_theme.dart';

late String coordenadas;

/* extends ChangeNotifier nos da acceso al notifyListeners() */
class UbicacionController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};
  /* Este método convierte el marker a un tipo setMarker */
  Set<Marker> get markers => _markers.values.toSet();
  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  final initialCameraPosition =
      CameraPosition(target: LatLng(-1.0463388, -78.5929473), zoom: 15);

  bool _loading = true;
  /* get => Para recuperar el valor  */
  bool get loading => _loading;

  late bool _gpsEnabled;
  bool get gpsEnabled => _gpsEnabled;

  StreamSubscription? _gpsSubscription;

  UbicacionController() {
    _init();
  }

  Future<void> _init() async {
    _gpsEnabled = await Geolocator.isLocationServiceEnabled();
    _loading = false;
    /*De esta manera escuchamos cuando el GPS se enciende o se apaga  */
    _gpsSubscription = Geolocator.getServiceStatusStream().listen((status) {
      _gpsEnabled = status == ServiceStatus.enabled;
      notifyListeners();
    });
    notifyListeners();
  }

  /* Estilo del GoogleMaps */
  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_mapStyle);
  }

  /* Para activar el GPS con el button */
  Future<void> turnOnGPS() => Geolocator.openLocationSettings();

  //Agregar un marcador al mapa desde la posición proporcionada
  void onTap(LatLng position) {
    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    coordenadas = ('$position');
    final marker = Marker(
        markerId: markerId,
        position: position,
        /* draggable: Para mover el marcador a otra ubicación */
        draggable: true,
        /* anchor: Offset(0.5, 1), */
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        onTap: () {
          _markersController.sink.add(id);
        },
        onDragEnd: (newPosition) {
          print('New position $newPosition');
        });

    _markers[markerId] = marker;
    notifyListeners();
  }

  @override
  void dispone() {
    /* Cuando la página sea destruida vamos a dejar de escuchar los cambies en el GPS */
    _gpsSubscription?.cancel();
    _markersController.close();
    super.dispose();
  }
}

final _mapStyle = jsonEncode(mapStyle);
