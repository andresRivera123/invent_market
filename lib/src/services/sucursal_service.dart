import 'package:supabase/supabase.dart';
import 'package:inventmarket_app/src/models/sucursal_model.dart';

const supabaseUrl = 'https://ugwfupuxmdlxyyjeuzfl.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0MDA5ODgxOCwiZXhwIjoxOTU1Njc0ODE4fQ.-N5CvtcNkUnXpnHiNqD_JV8CaA7HzpUJ2k-gnbFCNzA';
final supabaseClient = SupabaseClient(supabaseUrl, supabaseKey);

insertSucursal(Sucursal sucursal) {
  supabaseClient.from('sucursales').insert([
    {
      'name': sucursal.nombre,
      'user_id': sucursal.usuario,
      'id_local': sucursal.id,
      'localizacion': sucursal.localizacion
    }
  ]).execute();
}

Future<List<Sucursal>> getSucursales() async {
  var response = await supabaseClient
      .from('sucursales')
      .select()
      .order('id', ascending: true)
      .execute();

  final dataList = response.data as List;
  return dataList.map((map) => Sucursal.fromJson(map)).toList();
}
