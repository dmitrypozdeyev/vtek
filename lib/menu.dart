import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            padding: EdgeInsets.zero,
            child: Center(
              child: Text('Главное меню'),
            ),
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
        ],
      ),
    );
  }
}