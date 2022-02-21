import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventmarket_app/src/models/categorias_model.dart';
import 'package:inventmarket_app/src/services/data_service.dart';

class AddCategorias extends StatefulWidget {
  const AddCategorias({Key? key}) : super(key: key);

  @override
  _AddCategoriasState createState() => _AddCategoriasState();
}

class _AddCategoriasState extends State<AddCategorias> {

  late String nombre;
  late String descripcion;
  late String url;

  File? _image;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Añadir Categoria"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 205,
            width: 1000,
            color: Colors.transparent,
            child: Card(
              child: Column(
                children: <Widget>[
                   Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Center(
                      child: _image == null
                        ? const Icon(Icons.add_a_photo_outlined, size: 100.0)
                        : Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                        ),
                    ),
                  ), 
                  Row(
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () => pickImage(ImageSource.gallery), 
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          label: const Text("Galeria")
                        ),
                      ), 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: ()=> pickImage(ImageSource.camera),
                          icon: const Icon(Icons.camera_alt_outlined),
                          label: const Text("Cámara")
                        ),
                      ),  
                    ],
                  )
                ],
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 200, 25, 0),
            child: ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Nombre"),
                        onSaved: (value){
                          nombre = value.toString();
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return "Ingrese un nombre";
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Descripción"),
                        onSaved: (value){
                          descripcion = value.toString();
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return "Ingrese una descripción";
                          }
                        },
                      ),
                      //Boton para guardar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                        child: ElevatedButton.icon(
                          onPressed: (){
                            _sendForm();
                          }, 
                          icon: const Icon(Icons.save_outlined),
                          label: const Text("Guardar")
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

 Future pickImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      _image = null;
    }
    setState(() {});
 }

  _sendForm() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      if(_image == null){
        url = 'null';
      } else{
        url = await urlImage(_image!);
      }
      Categorias cat = Categorias(nombre: nombre, descripcion: descripcion, foto: url);
      insertCategorias(cat);
      _formKey.currentState!.reset();
    }
  }
}