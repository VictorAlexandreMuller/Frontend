import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/appBar/festora_appbar.dart';
import '../../widgets/appBar/festora_bottomnavigation.dart';
import '../../widgets/list/menu_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String name = 'HomePage';

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int selectedItem = 0;

  void _onBNTapped(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFFd6a467),
        appBar: FestoraAppBar("user"),
        bottomNavigationBar: CustomBottomNavigation(
          onItemSelected: _onBNTapped,
          currentIndex: selectedItem,
        ),
        body: homePage(),
      ),
    );
  }

  Widget homePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        mainList(),
      ],
    );
  }

  Widget mainList() {
    return Expanded(
        child: MenuList(),
    );
  }
}
