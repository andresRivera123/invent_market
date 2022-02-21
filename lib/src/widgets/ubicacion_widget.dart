// ignore_for_file: prefer_const_constructors, empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inventmarket_app/src/controller/ubicacion_controller.dart';
import 'package:inventmarket_app/src/services/usuario_service.dart';
import 'package:inventmarket_app/src/widgets/addSucursal.dart';
import 'package:provider/provider.dart';

import '../models/sucursal_model.dart';
import '../services/sucursal_service.dart';

class Ubicacion extends StatefulWidget {
  @override
  createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UbicacionController>(
      create: (_) {
        final controller = UbicacionController();
        /* Para navegar a una página especifíca*/
        controller.onMarkerTap.listen((String id) {
          print("Vamos a $id");
        });
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ubicación'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
                width: 400,
                height: 500,
                margin: EdgeInsets.all(15),
                child: Selector<UbicacionController, bool>(
                  /* De esta mánera se vuelve a renderizar el sleector solo si cambia el valor de _loading */
                  selector: (_, controller) => controller.loading,
                  builder: (context, loading, loadingWidget) {
                    if (loading) {
                      return loadingWidget!;
                    }
                    return Consumer<UbicacionController>(
                      builder: (_, controller, gpsMessageWidget) {
                        /* Con esto comprobamos si el gps esta activado */
                        if (!controller.gpsEnabled) {
                          return gpsMessageWidget!;
                        }
                        return GoogleMap(
                          markers: controller.markers,
                          onMapCreated: controller.onMapCreated,
                          initialCameraPosition:
                              controller.initialCameraPosition,
                          scrollGesturesEnabled: true,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          mapType: MapType.normal,
                          /* compassEnabled: true */
                          onTap: controller.onTap,
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                'Para utilizar la Ubicación debe activar el GPS en el dispositivo',
                                textAlign: TextAlign.center),
                            SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () {
                                  final controller =
                                      context.read<UbicacionController>();
                                  controller.turnOnGPS();
                                },
                                child: Text('Activar GPS')),
                          ],

                        ),
                        
                      ),
                      
                    );
                  },
                  
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
                Padding(
                        padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context, MaterialPageRoute(builder: (context) => AddSucursal()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(226, 44, 41, 0.8),
                          ),
                          icon: const Icon(Icons.save_outlined),
                          label: const Text("Guardar"),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
