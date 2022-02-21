import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventmarket_app/src/models/productos_model.dart';
//import 'package:inventmarket_app/src/pages/login_page.dart';
import 'package:inventmarket_app/src/services/data_service.dart';
import 'package:inventmarket_app/src/services/usuario_service.dart';

class AddProductos extends StatefulWidget {
  const AddProductos({Key? key}) : super(key: key);

  @override
  _AddProductosState createState() => _AddProductosState();
}

class _AddProductosState extends State<AddProductos> {

  late String nombre;
  late int stock;
  late double valor;
  late String url;
  late String categoria;
  late String token;

  File? _image;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Añadir Producto"),
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
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Stock"),
                        onSaved: (value){
                          stock = int.parse(value!);
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return "Ingrese el Stock";
                          }
                        },
                      ),
                      
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Valor"),
                        onSaved: (value){
                          valor = double.parse(value!);
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return "Ingrese un valor";
                          }
                        },
                      ),
                      //Boton para guardar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                        child: ElevatedButton.icon(
                          onPressed: (){
                            token = id;
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
      Productos prod = Productos(nombre: nombre, stock: stock, valor: valor, foto: url, userid: token);
      insertProductos(prod);
      _formKey.currentState!.reset();
    }
  }
}