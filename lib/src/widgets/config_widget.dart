import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/pages/login_page.dart';
import 'package:inventmarket_app/src/providers/main_provider.dart';
import 'package:inventmarket_app/src/services/usuario_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> opciones = <String>[
  'Tema',
  'Actualizar datos',
  'Permitir capturas de pantalla',
  'Versión de la aplicación'
];

class ConfigWidget extends StatelessWidget {
  const ConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    UsuarioService usuarioService = UsuarioService();
    return Scaffold(
      /*appBar: AppBar(
        centerTitle: true,
        title: const Text("Configuración"),
      ),*/
      body: Stack(children: <Widget>[
        Container(
          height: 150,
          width: 1000,
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          color: Colors.blueAccent,
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: const Text("Configuración",
                      style: TextStyle(color: Colors.white, fontSize: 25)))
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
          margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: ListView(
            children: <Widget>[
              Container(
                height: 50,
                padding: const EdgeInsets.all(5),
                color: Colors.transparent,
                child: ListTile(
                  leading: const Icon(Icons.brightness_2_outlined),
                  title: const Text("Tema"),
                  trailing: Switch(
                      value: mainProvider.mode,
                      onChanged: (bool value) async {
                        mainProvider.mode = value;
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool("mode", value);
                      }),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.all(5),
                color: Colors.transparent,
                child: const ListTile(
                  title: Text("Actualizar datos"),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.all(5),
                color: Colors.transparent,
                child: const ListTile(
                  title: Text("Permitir capturas de pantalla"),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.all(5),
                color: Colors.transparent,
                child: const ListTile(
                  title: Text("Versión de la aplicación"),
                ),
              ),
              const SizedBox(
                height: 175,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                child: ElevatedButton(
                    onPressed: () {
                      String resp = usuarioService.singout().toString();
                      if (resp != " ") {
                        mainProvider.index = 1;
                        mainProvider.token = '';
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(226, 44, 41, 0.8),
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 5),
                    ),
                    child: const Text("Cerrar Sesión",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700))),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
