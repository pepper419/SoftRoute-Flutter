import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF6200EE),
      flexibleSpace: Container(
        height: 120, // Ajusta la altura deseada
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/boxlogo.png',
              width: 50,
              height: 50,
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://pm1.aminoapps.com/6503/a6fa68b88ce479e7352ad253f294e5f4d8b4c36a_hq.jpg'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Welcome James!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Acción al presionar el ícono de configuración
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.0); // Ajusta la altura deseada
}

