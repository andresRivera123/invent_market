import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/widgets/config_widget.dart';
import 'package:inventmarket_app/src/widgets/init_widget.dart';
import 'package:inventmarket_app/src/widgets/perfil_widget.dart';

class MenuItem{
  String label;
  IconData icon;

  MenuItem(this.label, this.icon);
}

List<MenuItem> menuOptions = [
  MenuItem("Configuración", Icons.settings),
  MenuItem("Inicio", Icons.home),
  MenuItem("Perfil", Icons.person)
];

List<Widget> contentWidgets = [
  const ConfigWidget(),
  const InicioWidget(),
  const PerfilWidget()
];