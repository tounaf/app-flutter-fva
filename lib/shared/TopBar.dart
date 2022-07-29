import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.red,
      elevation: 15,
      bottom: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.group)),
          Tab(icon: Icon(Icons.money)),
          Tab(icon: Icon(Icons.people)),
        ],
      ),
      title: const Text('Fva'),
      actions: const [
        Icon(Icons.favorite),
        Icon(Icons.more_vert)
      ],
      backgroundColor: Colors.pink.shade400,
    );
  }
}
