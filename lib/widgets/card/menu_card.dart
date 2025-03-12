import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({super.key});

  @override
  State<StatefulWidget> createState() => _MenuCard();
}

class _MenuCard extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                  ),
                ),
              ),
              VerticalDivider(
                indent: 10,
                endIndent: 10,
                color: Colors.black,
                width: 30,
                thickness: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nome do Evento 123456",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Descrição do Evento Descrição do Evento",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
