// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/bloc/login_bloc.dart';
import 'package:inventmarket_app/src/models/usuario_model.dart';
import 'package:inventmarket_app/src/pages/home_page.dart';
import 'package:inventmarket_app/src/pages/sing_up_page.dart';
import 'package:inventmarket_app/src/providers/main_provider.dart';
import 'package:inventmarket_app/src/services/usuario_service.dart';
import 'package:provider/provider.dart';

//late String token;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc bloc;
  UsuarioService usuarioService = UsuarioService();
  bool _obscureText = true;

  @override
  void initState() {
    bloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 400,
              width: 1000,
              color: Colors.transparent,
              child: const Center(
                child: Image(
                  height: 200,
                  image: NetworkImage(
                      'https://ugwfupuxmdlxyyjeuzfl.supabase.in/storage/v1/object/public/imagenes/Logo/Logo.jpg'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 350, 50, 0),
              child: Container(
                  height: 400,
                  width: 1000,
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            left: 0, top: 0, right: 0, bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(194, 194, 194, 30),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: StreamBuilder(
                              stream: bloc.emailStream,
                              builder: (BuildContext context,
                                      AsyncSnapshot snapshot) =>
                                  TextField(
                                    onChanged: bloc.changeEmail,
                                    decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      border: InputBorder.none,
                                      icon: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.white,
                                      ),
                                      hintText: "Correo electrónico",
                                    ),
                                  )),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 0, top: 0, right: 0, bottom: 30),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(194, 194, 194, 30),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: StreamBuilder<Object>(
                              stream: bloc.passwordStream,
                              builder: (BuildContext context,
                                      AsyncSnapshot snapshot) =>
                                  TextField(
                                    onChanged: bloc.changePassword,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      border: InputBorder.none,
                                      icon: const Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            _obscureText = !_obscureText;
                                            setState(() {});
                                          },
                                          icon: _obscureText
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility)),
                                      hintText: "Contraseña",
                                    ),
                                  )),
                        ),
                      ),
                      StreamBuilder<Object>(
                          stream: bloc.loginValidStream,
                          builder: (BuildContext context,
                                  AsyncSnapshot snapshot) =>
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromRGBO(82, 255, 82, 30),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80, vertical: 5),
                                ),
                                onPressed: snapshot.hasData
                                    ? () async {
                                        Usuario usuario = Usuario(
                                            email: bloc.email,
                                            password: bloc.password);
                                        String resp =
                                            await usuarioService.login(usuario);
                                        if (resp != "") {
                                          mainProvider.token = resp;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                        } else {
                                          _mostrarAlert(context);
                                        }
                                      }
                                    : null,
                                child: const Text("Iniciar Sesión",
                                    style: TextStyle(fontSize: 20)),
                              )),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(150, 150, 150, 30),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 5),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SingUpPage()));
                        },
                        child: const Text("Crear Cuenta",
                            style: TextStyle(fontSize: 20)),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 40,
                        child: Row(
                          children: const <Widget>[
                            Text("¿Olvidaste tu contraseña? ",
                                style: TextStyle(color: Colors.grey)),
                            Text.rich(TextSpan(
                              text: " Entra aqui",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

void _mostrarAlert(BuildContext context) {
  showDialog(
      barrierColor: Color.fromRGBO(169, 187, 165, 0.5),
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(169, 187, 165, 0.9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Icon(
            Icons.error_outline,
            size: 50,
            color: Color.fromRGBO(226, 44, 41, 0.8),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                'El correo electrónico o contraseña que has introducido no está conectado a una cuenta. Encuentra tu cuenta e inicia sesión.',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(226, 44, 41, 0.8),
                  elevation: 10,
                ),
              ),
            )
          ],
        );
      });
}
