import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/models/productos_model.dart';
import 'package:inventmarket_app/src/services/data_service.dart';

class DataProductsWidget extends StatefulWidget {
  const DataProductsWidget({Key? key}) : super(key: key);

  @override
  _DataProductsWidgetState createState() => _DataProductsWidgetState();
}

class _DataProductsWidgetState extends State<DataProductsWidget> {

  late final int id;
  late final String url;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Productos", textAlign: TextAlign.center,)
      ),
      body: FutureBuilder<List<Productos>>(
          future: getProductos(),
          
          builder: (context, AsyncSnapshot<List<Productos>> snapshot) {
            if(snapshot.hasData == false){
              return Container(
                alignment: Alignment.center,
                child: const Center(
                        child: CircularProgressIndicator(),
                ),
              ); 
            }
            return ListView(
                padding: const EdgeInsets.all(10),
                children: snapshot.data!.map((producto) => Card(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ListTile(
                      leading: Image(
                        width: 60,
                        height: 120,
                        image: NetworkImage(
                          producto.foto != 'null' 
                          ? producto.foto.toString()
                          : 'https://ugwfupuxmdlxyyjeuzfl.supabase.in/storage/v1/object/public/imagenes/sin_imagen.jpg',
                        ),
                      ),
                        /*radius: 50,
                        child: Icon(
                          Icons.brunch_dining_outlined
                        )
                      ),*/
                      title: Text(producto.id.toString() + "\n" + producto.nombre.toString()),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("Stock \n" + producto.stock.toString()),
                          ),
                          Expanded(
                            child: Text("Precio \n" + producto.valor.toString()),
                          ),
                        ]
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                )).toList(),
              );
          }
        ),
    );
  }
  
}