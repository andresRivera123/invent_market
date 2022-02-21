//import 'dart:convert';

import 'package:inventmarket_app/src/models/usuario_model.dart';
import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://ugwfupuxmdlxyyjeuzfl.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0MDA5ODgxOCwiZXhwIjoxOTU1Njc0ODE4fQ.-N5CvtcNkUnXpnHiNqD_JV8CaA7HzpUJ2k-gnbFCNzA';
final supabaseClient = SupabaseClient(supabaseUrl, supabaseKey);

late String id;
class UsuarioService{

  Future<String> login(Usuario usuario) async{
   
      final res = await supabaseClient.auth.signIn(
        email: usuario.email,
        password: usuario.password
      );
      final user = res.data?.user;
      if(res.data == null) return "";
      id = user!.id;
      return id.toString();
  }

  Future<String> singout() async {
    final res = await supabaseClient.auth.signOut();
    final error = res.error;
    return error.toString();
  }

  Future<int> postUsuario(Usuario usuario) async {
    try{
      final res = await supabaseClient.auth.signUp(
        usuario.email.toString(), 
        usuario.password.toString(),
      );
      if(res.data == null) return 400;
      return 201;
    } catch (ex){
      return 500;
    }
  }
}