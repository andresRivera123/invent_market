import 'dart:io';

//import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:inventmarket_app/src/models/categorias_model.dart';
import 'package:inventmarket_app/src/models/productos_model.dart';
import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://ugwfupuxmdlxyyjeuzfl.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0MDA5ODgxOCwiZXhwIjoxOTU1Njc0ODE4fQ.-N5CvtcNkUnXpnHiNqD_JV8CaA7HzpUJ2k-gnbFCNzA';
final supabaseClient = SupabaseClient(supabaseUrl, supabaseKey);


Future<List<Productos>> getProductos() async {
    var response = await supabaseClient
      .from('inventario')
      .select()
      .order('id', ascending: true)
      .execute();

    final dataList = response.data as List;
    return dataList.map((map) => Productos.fromJson(map)).toList();
}

Future<List<Categorias>> getCategorias() async {
    var response = await supabaseClient
      .from('categorias')
      .select()
      .order('id', ascending: true)
      .execute();

    final dataList = response.data as List;
    return dataList.map((map) => Categorias.fromJson(map)).toList();
}

getCat() async {
  final res = await supabaseClient
  .from('categorias')
  .select('name')
  .execute();

  final data = res.data;
  return data;
}

insertProductos(Productos producto){
  supabaseClient
  .from('inventario')
  .insert([
    {'name': producto.nombre, 'stock': producto.stock, 'valor': producto.valor, 'foto': producto.foto, 'user_id': producto.userid}
  ]).execute();
}

insertCategorias(Categorias categoria){
  supabaseClient
  .from('categorias')
  .insert([
    {'name': categoria.nombre, 'descripcion': categoria.descripcion, 'foto': categoria.foto}
  ]).execute();
}
/*
Future<String> urlImage(File image) async {
  // Create file `example.txt` and upload it in `public` bucket
  final file = File(image.path);
  final name = image.path.split('/').last;
  file.writeAsStringSync('imagen');
  final storageResponse = await supabaseClient
      .storage
      .from('imagenes')
      .upload(name, file);

  final res = supabaseClient
  .storage
  .from('imagenes')
  .getPublicUrl(name);

  final publicURL = res.data;
  //print(publicURL);
  return publicURL.toString();
}
*/

Future<String> geturl(String name) async {
  try{
    final res = supabaseClient
      .storage
      .from('imagenes')
      .getPublicUrl(name);

    final publicURL = res.data;
    return publicURL.toString();
  } catch (e){
    // ignore: avoid_print
    print(e);
    return "";
  }
}

Future<String> urlImage(File image) async {
  final file = File(image.path);
  final name = image.path.split('/').last;
  try{
    supabaseClient
      .storage
      .from('imagenes')
      .upload(name, file);
    final url = geturl(name);
    return url;
  } catch (e){
    // ignore: avoid_print
    print(e);
    return "";
  }
  
}