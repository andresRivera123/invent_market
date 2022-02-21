// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/controller/ubicacion_controller.dart';
import 'package:inventmarket_app/src/widgets/lista_sucursale_widget.dart';
import 'package:inventmarket_app/src/widgets/ubicacion_widget.dart';

import '../models/sucursal_model.dart';
import '../services/sucursal_service.dart';
import '../services/usuario_service.dart';

class AddSucursal extends StatefulWidget {
  @override
  createState() => _AddSucursalState();
}

class _AddSucursalState extends State<AddSucursal> {
  final _formKey = GlobalKey<FormState>();
  late String nombre;
  late String idLocal;
  late String localizacion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Sucursal'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: <Widget>[
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/sucursal_image.png"),
                  ))),
              Container(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Ubicacion()));
                      },
                      icon: const Icon(Icons.add_box),
                      label: const Text("Agregar Sucursal")),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(labelText: "ID"),
                        onSaved: (value) {
                          idLocal = value.toString();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese un identificador";
                          }
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Nombre Sucursal"),
                        onSaved: (value) {
                          nombre = value.toString();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese el nombre";
                          }
                        },
                      ),
                      //Boton para guardar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _sendForm();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(226, 44, 41, 0.8),
                          ),
                          icon: const Icon(Icons.save_outlined),
                          label: const Text("Guardar"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DataSucursal()));
                              },
                              icon: const Icon(Icons.list),
                              label: const Text("Lista Sucursales")),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _sendForm() async {
    _formKey.currentState!.save();
    _formKey.currentState!.reset();
    localizacion = coordenadas;
    Sucursal suc = Sucursal(
        nombre: nombre, usuario: id, id: idLocal, localizacion: localizacion);
    insertSucursal(suc);
  }
}
