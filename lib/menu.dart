import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const String logoUrl = 'https://t130631.spo.obrazovanie33.ru/upload/uf/437/c0p7f82yzpcy9706p9zhd33r1262n479/Logotip-VTEK.png';
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Column(
              spacing: 8,
              children: [
                SizedBox(height: 120,
                child: Image.network(logoUrl)),
                const Text('Главное меню',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ]
            )
          ),

          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('Новости'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                    (route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.near_me),
            title: const Text('Как поступить'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/enroll');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text('Контакты'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contacts');
            },
          ),
        ],
      ),
    );
  }
}