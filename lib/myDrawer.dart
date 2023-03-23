import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlcshub_app/pages/arts.dart';
import 'package:nlcshub_app/pages/beyond_the_classroom.dart';
import 'package:nlcshub_app/pages/humanities.dart';
import 'package:nlcshub_app/pages/languages.dart';
import 'package:nlcshub_app/pages/pdf_menu.dart';
import 'package:nlcshub_app/pages/spatium.dart';
import 'package:nlcshub_app/pages/stem.dart';
import 'package:nlcshub_app/pages/tok.dart';
import 'pdf_api.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:io';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({Key? key,
    required this.drawer,
  }) : super(key: key);

  final Drawer drawer;

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFMenu(file: file)),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromRGBO(241, 242, 246, 1.0),
        elevation: 1.5,
        child: Column(children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 3.h),
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    height: 7.h,
                  ),
                ),
              )
          ),
          Expanded(
              flex: 4,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  /*ListTile(
                    title: const Text('NLCS Sports'),
                    leading: const Icon(Icons.emoji_events, color: Colors.black),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Testing(title: title, path: path, jeoji: jeoji, geomun: geomun, sarah: sarah, mulchat: mulchat, noro: noro, nextH: nextH)), (route) => false);
                    },
                  ),*/
                  ListTile(
                    title: const Text("This Week's Menu"),
                    leading: const Icon(Icons.restaurant_menu, color: Colors.black),
                    onTap: () async {
                      Fluttertoast.showToast(msg: "Loading, please wait.", fontSize: 18.0);
                      const url = 'menu.pdf';
                      final file = await PDFApi.loadFirebase(url);
                      if (file == null) return;
                      openPDF(context, file);
                    },
                  ),
                  ExpansionTile(
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    title: const Text('Categories'),
                    leading: const Icon(Icons.category, color: Colors.black,),
                    children: <Widget> [
                      ListTile(
                        leading: const Text(""),
                        title: const Text("STEM", style: TextStyle(color: Color(0xff343434))),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const STEM()), (route) => false);
                        },
                      ),
                      ListTile(
                        leading: const Text(""),
                        title: const Text("Humanities", style: TextStyle(color: Color(0xff343434))),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Humanities()), (route) => false);
                        },
                      ),
                      ListTile(
                        leading: const Text(""),
                        title: const Text("Languages", style: TextStyle(color: Color(0xff343434))),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Languages()), (route) => false);
                        },
                      ),
                      ListTile(
                        leading: const Text(""),
                        title: const Text("Arts", style: TextStyle(color: Color(0xff343434))),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Arts()), (route) => false);
                        },
                      ),
                      ListTile(
                        leading: const Text(""),
                        title: const Text("TOK", style: TextStyle(color: Color(0xff343434))),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const TOK()), (route) => false);
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    title: const Text("Beyond the Classroom"),
                    leading: const Icon(Icons.public, color: Colors.black),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BeyondTheClassroom()), (route) => false);
                    },
                  ),
                  ListTile(
                    title: const Text("Spatium: Podcast"),
                    leading: const Icon(Icons.podcasts, color: Colors.black),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Spatium()), (route) => false);
                    },
                  )
                ],
              )
          ),
          /*Container(
            color: Colors.black,
            width: double.infinity,
            height: 0.1,
            margin: EdgeInsets.only(bottom: 2.h, left: 5.w, right: 5.w),
          ),
          Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: const Text('Settings'),
                    leading: const Icon(Icons.settings, color: Colors.black),
                    onTap: () {},
                  ),
                  ListTile(
                    // TODO: Login / Logout 다르게 하기
                      title: const Text('Login'),
                      leading: const Icon(Icons.login, color: Colors.black),
                      onTap: () {}
                  )
                ],
              )
          ),*/
        ]
        )
    );
  }
}
