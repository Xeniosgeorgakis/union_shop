import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            title: const Text('Home'),
            selected: currentRoute == '/',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != '/') {
                navigateToHome(context);
              }
            },
          ),
          ListTile(
            title: const Text('About Us'),
            selected: currentRoute == '/about',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != '/about') {
                Navigator.pushNamed(context, '/about');
              }
            },
          ),
          ListTile(
            title: const Text('Collections'),
            selected: currentRoute == '/collections',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != '/collections') {
                Navigator.pushNamed(context, '/collections');
              }
            },
          ),
          ListTile(
            title: const Text('SALE!'),
            selected: currentRoute == '/sale',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != '/sale') {
                Navigator.pushNamed(context, '/sale');
              }
            },
          ),
          ExpansionTile(
            title: const Text('PrintShack'),
            initiallyExpanded:
                currentRoute == '/printshark' || currentRoute == '/personalise',
            children: <Widget>[
              ListTile(
                title: const Text('About Print Shack'),
                selected: currentRoute == '/printshark',
                onTap: () {
                  Navigator.pop(context);
                  if (currentRoute != '/printshark') {
                    Navigator.pushNamed(context, '/printshark');
                  }
                },
              ),
              ListTile(
                title: const Text('Personalise'),
                selected: currentRoute == '/personalise',
                onTap: () {
                  Navigator.pop(context);
                  if (currentRoute != '/personalise') {
                    Navigator.pushNamed(context, '/personalise');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
