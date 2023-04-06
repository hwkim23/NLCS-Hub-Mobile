import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nlcshub_app/myAppBar.dart';
import 'package:nlcshub_app/pages/sports.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../main.dart';
import '../myDrawer.dart';
import '../pod_play.dart';
import '../state.dart';
import 'bulletin.dart';

class Spatium extends StatefulWidget {
  const Spatium({
    Key? key,
  }) : super(key: key);

  @override
  State<Spatium> createState() => _SpatiumState();
}

class _SpatiumState extends State<Spatium> {
  void put(url, title, imageUrl, date) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PodPlay(podUrl: url, podTitle: title, podDate: date, imgUrl: imageUrl)));
  }

  int _selectedIndex = -1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List subString = [];

  String convert(String s) {
    String cut = s.substring(19);
    return cut;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), color: const Color.fromRGBO(241, 242, 246, 1.0)),
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
        currentIndex: (_selectedIndex != -1) ? _selectedIndex : 0,
        selectedFontSize: (_selectedIndex != -1) ? 14 : 12,
        selectedItemColor: (_selectedIndex != -1) ? const Color(0xff1e73be) : Colors.black54,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: LayoutBuilder(
            builder: (context, constraints) {
              if (_selectedIndex == -1) {
                return Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Spatium: Podcast',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: context.watch<Store1>().podDate.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: 1.1.h, top: 1.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        put(context.read<Store1>().podMp3[index], context.read<Store1>().podTitle[index], context.read<Store1>().podImg[index], context.read<Store1>().podDate[index]);
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Container(
                                          width: 130,
                                          padding: EdgeInsets.all(1.h),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 11.h,
                                                width: 11.h,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: CachedNetworkImage(
                                                    imageUrl: context.watch<Store1>().podImg[index],
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, url) => Container(color: Colors.black.withOpacity(0.04)),
                                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                fit: FlexFit.loose,
                                                child: Container(
                                                  margin: const EdgeInsets.only(left: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        height: 70,
                                                        padding: const EdgeInsets.only(right: 20),
                                                        child: Text(
                                                            context.watch<Store1>().podTitle[index],
                                                            maxLines: 3,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                height: 1.3,
                                                                color: const Color(0xff343434)
                                                            )
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.only(
                                                            top: 0),
                                                        child: Text(
                                                          context.watch<Store1>().podDate[index],
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color: const Color(
                                                                  0xffA3A3A3)
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (_selectedIndex == 0) {
                return const Sports();
              } else if (_selectedIndex == 1) {
                return const HomePage();
              } else {
                return const Bulletin();
              }
            }
        ),
      ),
    );
  }
}
