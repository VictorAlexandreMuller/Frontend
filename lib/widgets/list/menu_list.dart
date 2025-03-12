import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../card/menu_card.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<StatefulWidget> createState() => _MenuList();
}

class _MenuList extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return MenuCard();
      },
    );
  }
}
