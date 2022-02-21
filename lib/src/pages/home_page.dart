import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/providers/main_provider.dart';
import 'package:inventmarket_app/src/utils/main_menu.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
   return Scaffold(
        body: contentWidgets[mainProvider.index],
        bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          mainProvider.index = index;
        },
        type: BottomNavigationBarType.fixed,
        items: menuOptions
          .map((e) => BottomNavigationBarItem(label: e.label, icon: Icon(e.icon))).toList(),
            currentIndex: mainProvider.index
          ),
    );
  }
}