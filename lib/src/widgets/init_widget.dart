import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/widgets/addSucursal.dart';
import 'package:inventmarket_app/src/widgets/datacategorias_widget.dart';
import 'package:inventmarket_app/src/widgets/dataproductos_widget.dart';
import 'package:inventmarket_app/src/widgets/ubicacion_widget.dart';

import 'add_widget.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({Key? key}) : super(key: key);

  @override
  _InicioWidgetState createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: 150,
            width: 1000,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              color: Colors.blueAccent,
              child: Column(
                children: <Widget> [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Text("Bienvenido", style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16)),
                        const Text("Usuario", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DataProductsWidget()));
                      },
                      splashColor: Colors.blueGrey,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.shopping_cart_outlined, size: 70.0),
                            Text("Productos", style: TextStyle(fontSize: 17),)
                          ]
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: (){},
                      splashColor: Colors.blueGrey,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.inventory_rounded , size: 70.0),
                            Text("Inventario", style: TextStyle(fontSize: 17),)
                          ]
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DataCategoriaWidget()));
                      },
                      splashColor: Colors.blueGrey,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.card_travel_outlined , size: 70.0),
                            Text("Categorias", style: TextStyle(fontSize: 17),)
                          ]
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Add()));
                      },
                      splashColor: Colors.blueGrey,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.addchart , size: 70.0),
                            Text("Añadir", style: TextStyle(fontSize: 17),)
                          ]
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddSucursal()));
                      },
                      splashColor: Colors.blueGrey,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.storefront , size: 70.0),
                            Text("Ubicación", style: TextStyle(fontSize: 17),)
                          ]
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),          
        ],
        ),
    );
  }
}
