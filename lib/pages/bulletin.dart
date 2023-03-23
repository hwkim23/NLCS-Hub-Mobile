import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlcshub_app/pages/pdf_menu.dart';
import 'package:nlcshub_app/pdf_api.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:io';

import '../state.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 242, 246, 1.0),
      body: SafeArea(
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
      ),
    );
  }
}
