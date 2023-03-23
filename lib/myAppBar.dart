import 'package:flutter/material.dart';
import 'search.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({Key? key,
    required this.appBar,
    required this.color
  })
      : super(key: key);

  final AppBar appBar;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: color,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage()));
          }
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
