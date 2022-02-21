import 'dart:convert';

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({this.usuario, this.email, this.password, this.nombreNegocio});

  String? usuario;
  String? email;
  String? password;
  String? nombreNegocio;

  Map<String, dynamic> toJson() => {
        "user": usuario,
        "email": email,
        "password": password,
        "nombreNegocio": nombreNegocio
      };
}
