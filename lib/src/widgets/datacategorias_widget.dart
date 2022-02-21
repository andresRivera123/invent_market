import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/models/categorias_model.dart';
import 'package:inventmarket_app/src/services/data_service.dart';

class DataCategoriaWidget extends StatefulWidget {
  const DataCategoriaWidget({Key? key}) : super(key: key);

  @override
  _DataCategoriaWidgetState createState() => _DataCategoriaWidgetState();
}

class _DataCategoriaWidgetState extends State<DataCategoriaWidget> {

  late final int id;
  late final String url;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Categorias", textAlign: TextAlign.center,)
      ),
      body: FutureBuilder<List<Categorias>>(
          future: getCategorias(),
          
          builder: (context, AsyncSnapshot<List<Categorias>> snapshot) {
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
                children: snapshot.data!.map((categoria) => Card(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ListTile(
                      leading: Image(
                        width: 60,
                        height: 120,
                        image: NetworkImage(
                          categoria.foto != 'null' 
                          ? categoria.foto.toString()
                          : 'https://ugwfupuxmdlxyyjeuzfl.supabase.in/storage/v1/object/public/imagenes/sin_imagen.jpg',
                        ),
                      ),
                      title: Text(categoria.id.toString() + "\n" + categoria.nombre.toString()),
                      subtitle: Text(categoria.descripcion.toString()),
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