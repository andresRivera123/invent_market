class Categorias {
  

  Categorias({this.id, this.nombre, this.descripcion, this.foto});

  int? id;
  String? nombre;
  String? descripcion;
  String? foto;

  factory Categorias.fromJson(Map<String, dynamic> json) {
    return Categorias(
        id: json['id'],
        nombre: json['name'],
        descripcion: json['descripcion'],
        foto: json['foto']
      );
  }
}