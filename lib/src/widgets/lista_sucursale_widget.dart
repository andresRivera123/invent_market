import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/models/sucursal_model.dart';

import '../services/sucursal_service.dart';

class DataSucursal extends StatefulWidget {
  const DataSucursal({Key? key}) : super(key: key);

  @override
  _DataSucursalState createState() => _DataSucursalState();
}

class _DataSucursalState extends State<DataSucursal> {
  late final int id;
  late final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Sucursales",
            textAlign: TextAlign.center,
          )),
      body: FutureBuilder<List<Sucursal>>(
          future: getSucursales(),
          builder: (context, AsyncSnapshot<List<Sucursal>> snapshot) {
            if (snapshot.hasData == false) {
              return Container(
                alignment: Alignment.center,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(10),
              children: snapshot.data!
                  .map((sucursal) => Card(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: ListTile(
                            leading: const Image(
                              width: 140,
                              height: 140,
                              image: NetworkImage(
                                  'https://ugwfupuxmdlxyyjeuzfl.supabase.in/storage/v1/object/public/imagenes/Logo/ejemplo_loc.jfif'),
                            ),
                            title: Text(sucursal.id.toString() +
                                "\n" +
                                sucursal.nombre.toString()),
                            subtitle: Text(sucursal.localizacion.toString()),
                            trailing: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                              child: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }),
    );
  }
}
