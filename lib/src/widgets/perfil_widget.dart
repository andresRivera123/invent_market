import 'package:flutter/material.dart';

class PerfilWidget extends StatelessWidget {
  const PerfilWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.person_outline, size: 50.0),
          Text("Perfil", style: Theme.of(context).textTheme.headline4)
        ],
      ),
    );
  }
}