class Sucursal {
  Sucursal({this.id, this.nombre, this.localizacion, this.usuario});

  String? id;
  String? nombre;
  String? localizacion;
  String? usuario;

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
        id: json['id_local'],
        nombre: json['name'],
        localizacion: json['localizacion'],
        usuario: json['user_id']);
  }
}
