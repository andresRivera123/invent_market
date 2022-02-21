import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/bloc/singup_bloc.dart';
import 'package:inventmarket_app/src/models/usuario_model.dart';
import 'package:inventmarket_app/src/pages/home_page.dart';
import 'package:inventmarket_app/src/services/usuario_service.dart';
//import 'package:inventmarket_app/src/widgets/init_widget.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  late SignUpBloc bloc;
  UsuarioService usuarioService = UsuarioService();
  bool _obscureText = true;
  @override
  void initState() {
    bloc = SignUpBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Center(
              child: Container(
                  margin: const EdgeInsets.only(
                      left: 0, top: 300, right: 0, bottom: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: const Text("Crea tu cuenta",
                      style: TextStyle(color: Colors.grey))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 300, 50, 0),
              child: Container(
                  height: 400,
                  width: 1000,
                  color: Colors.transparent,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            left: 0, top: 10, right: 0, bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(194, 194, 194, 30),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: StreamBuilder(
                            stream: bloc.usernameStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                                TextField(
                              onChanged: bloc.changeUsername,
                              decoration: InputDecoration(
                                errorText: snapshot.error?.toString(),
                                border: InputBorder.none,
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: "Usuario",
                              ),
                            ),
                          ),
                        ),
                      ),
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
                            stream: bloc.usernameStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                                TextField(
                              onChanged: bloc.changeUsername,
                              decoration: InputDecoration(
                                errorText: snapshot.error?.toString(),
                                border: InputBorder.none,
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: "Nombre de tu negocio",
                              ),
                            ),
                          ),
                        ),
                      ),
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
                            ),
                          ),
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
                          child: StreamBuilder(
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
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                hintText: "Contraseña",
                              ),
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: bloc.signUpValidStream,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(82, 255, 82, 30),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 5),
                              ),
                              onPressed: snapshot.hasData
                                  ? () async {
                                      Usuario usuario = Usuario(
                                          usuario: bloc.username,
                                          email: bloc.email,
                                          password: bloc.password);
                                      int resp = await usuarioService
                                          .postUsuario(usuario);
                                      if (resp == 201) {
                                        //Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()));
                                      }
                                    }
                                  : null,
                              child: const Text("Iniciar Sesión",
                                  style: TextStyle(fontSize: 20)),
                            );
                          }),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
