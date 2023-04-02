import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlcshub_app/pages/pdf_menu.dart';
import 'package:nlcshub_app/pdf_api.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:io';
import 'package:nlcshub_app/myAppBar.dart';
import 'package:nlcshub_app/myDrawer.dart';
import 'package:nlcshub_app/pages/sports.dart';
import 'package:nlcshub_app/main.dart';

import '../state.dart';

class BulletinCall extends StatefulWidget {
  const BulletinCall({super.key});

  @override
  State<BulletinCall> createState() => _BulletinCallState();
}

class _BulletinCallState extends State<BulletinCall> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 242, 246, 1.0),
      appBar: BaseAppBar(appBar: AppBar(), color: const Color.fromRGBO(241, 242, 246, 1.0)),
      body: SafeArea(
        child: LayoutBuilder(
            builder: (context, constraints) {
              if (_selectedIndex == 0) {
                return const Sports();
              } else if (_selectedIndex == 1) {
                return const HomePage();
              }
              else {
                return const Bulletin();
              }
            }
        ),
      ),
      drawer: const BaseDrawer(drawer: Drawer()),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Sports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Bulletin',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff1e73be),
        onTap: _onItemTapped,
      ),
    );
  }
}

class Bulletin extends StatefulWidget {
  const Bulletin({Key? key}) : super(key: key);

  @override
  State<Bulletin> createState() => _BulletinState();
}

class _BulletinState extends State<Bulletin> {
  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFMenu(file: file)),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 3.h, bottom: 3.h, left: 5.w, right: 5.w),
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.watch<Store1>().title.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 9.h,
                width: 100.w,
                child: GestureDetector(
                  onTap: () async {
                    Fluttertoast.showToast(msg: "Loading, please wait.", fontSize: 18.0);
                    final file = await PDFApi.loadFirebase(context.read<Store1>().path[index]);
                    if (file == null) return;
                    openPDF(context, file);
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      padding: EdgeInsets.only(top: 2.7.h, left: 5.w, right: 5.w),
                      child: Text(
                        context.read<Store1>().title[index],
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      );
  }
}
