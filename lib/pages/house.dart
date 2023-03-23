import 'package:flutter/material.dart';

class House extends StatelessWidget {
  const House({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(241, 242, 246, 1.0),
      body: SafeArea(
        child: Center(
          child: Text("Coming Soon")
        ),
      ),
    );
  }
}
