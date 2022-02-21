import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/widgets/addcategoria_widget.dart';
import 'package:inventmarket_app/src/widgets/addproducto_widget.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Añadir"),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.fromLTRB(10, 25, 10, 15),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductos()));
                  },
                  splashColor: Colors.blueGrey,
                  child: Center(
                    heightFactor: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text("Productos", style: TextStyle(fontSize: 17),),
                        Icon(Icons.add_shopping_cart_outlined, size: 70.0)
                      ]
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCategorias()));
                  },
                  splashColor: Colors.blueGrey,
                  child: Center(
                    heightFactor: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text("Categoría", style: TextStyle(fontSize: 17),),
                        Icon(Icons.add_chart, size: 70.0)
                      ]
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}