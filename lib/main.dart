//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlcshub_app/pages/arts.dart';
import 'package:nlcshub_app/pages/bulletin.dart';
import 'package:nlcshub_app/pages/humanities.dart';
import 'package:nlcshub_app/pages/languages.dart';
import 'package:nlcshub_app/pages/stem.dart';
import 'package:nlcshub_app/pages/sports.dart';
import 'package:nlcshub_app/pages/tok.dart';
import 'dart:async';
import 'package:nlcshub_app/pages/pdf_menu.dart';
import 'package:nlcshub_app/pdf_api.dart';
import 'package:nlcshub_app/state.dart';
import 'package:provider/provider.dart';
import 'package:web_scraper/web_scraper.dart';
import 'dart:io';

//Icon import하기
import 'article.dart';
import 'house_logo_icons.dart';

//BaseAppBar import하기
import 'myAppBar.dart';

//Style import하기
import 'myDrawer.dart';
import 'style.dart' as style;

//Firebase import하기
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Responsive sizer import하기
import 'package:responsive_sizer/responsive_sizer.dart';

//SVG Image enable하기
import 'package:flutter_svg/flutter_svg.dart';

//Fl chart import하기
import 'package:fl_chart/fl_chart.dart';

//Circular Avatar import하기
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

//Cached image
import 'package:cached_network_image/cached_network_image.dart';

List<String> features = ['/languages/2561/', '/languages/2552/', '/languages/2543/', '/stem/2537/'];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //App portrait mode으로 set하기
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => Store1()),
          ChangeNotifierProvider(create: (c) => Store2()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: style.theme,
            title: 'NLCS Hub Mobile',
            home: const MyApp()
        )
      )
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    //context.read<Store1>().getData();
    context.read<Store2>().fetchData(features[0], 0);
    context.read<Store2>().fetchData(features[1], 1);
    context.read<Store2>().fetchData(features[2], 2);
    context.read<Store2>().fetchData(features[3], 3);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return FutureBuilder<bool>(
            future: context.read<Store1>().getData(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              //print('hi');
              if (!snapshot.hasData) {return Container(color: const Color.fromRGBO(241, 242, 246, 1.0), child: const Center(child: CircularProgressIndicator()));}
              return const HomePagePage();
            },
        );
      },
    );
  }
}

// TODO: wrtie code
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}


class HomePagePage extends StatefulWidget {
  const HomePagePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePagePageState createState() => _HomePagePageState();
}

class _HomePagePageState extends State<HomePagePage> {
  // TODO: Lottie Animation Loading
  // TODO: Youtube
  // TODO: Categories load all articles

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFMenu(file: file)),
  );

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

//Expansion tile
class ItemTile extends StatefulWidget {
  const ItemTile({super.key,});

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool _expanded = true;

  double max = 0;

  void getMax() {
    if (context.read<Store1>().jeoji > max) {
      max = context.read<Store1>().jeoji;
    }
    if (context.read<Store1>().geomun > max) {
      max = context.read<Store1>().geomun;
    }
    if (context.read<Store1>().sarah > max) {
      max = context.read<Store1>().sarah;
    }
    if (context.read<Store1>().mulchat > max) {
      max = context.read<Store1>().mulchat;
    }
    if (context.read<Store1>().noro > max) {
      max = context.read<Store1>().noro;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getMax();
    return GestureDetector(
      onTap: (){
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.only(top: 2.5.h, bottom: 2.5.h),
        duration: const Duration(milliseconds: 200),
        height: _expanded
            ? 40.h
            : 9.h,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'House Competition',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      _expanded
                        ? const Icon(Icons.expand_less)
                        : const Icon(Icons.expand_more),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: _expanded
                      ? 25.h
                      : 0,
                  width: 80.w,
                  child: _expanded
                      ? ItemExpandedTile(max: max,)
                      : const SizedBox(height: 0.00),
                ),
                Container(
                  padding: _expanded
                      ? EdgeInsets.only(top: 3.h)
                      : const EdgeInsets.only(top: 0),
                  child: _expanded
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Coming Up Next: ${context.read<Store1>().nextCompetition}',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                          ],
                  )
                      : const SizedBox(height: 0.00),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Widget which is shown after expanding
class ItemExpandedTile extends StatelessWidget {
  const ItemExpandedTile({super.key,
    required this.max
  });

  final double max;

  @override
  Widget build(BuildContext context) {
    return _BarChart(jeoji: context.read<Store1>().jeoji, geomun: context.read<Store1>().geomun, sarah: context.read<Store1>().sarah, mulchat: context.read<Store1>().mulchat, noro: context.read<Store1>().noro, max: max);
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({
    required this.jeoji,
    required this.geomun,
    required this.sarah,
    required this.mulchat,
    required this.noro,
    required this.max
  });

  final double jeoji;
  final double geomun;
  final double sarah;
  final double mulchat;
  final double noro;
  final double max;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        ///Score이 270점을 넘지 않는다는 가정하에
        maxY: 350,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Color(0xff1e73be),
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    IconData? icon;
    Color c;
    switch (value.toInt()) {
      case 0:
        icon = HouseLogo.jeoji;
        c = const Color(0xfff3bd34);
        break;
      case 1:
        icon = HouseLogo.geomun;
        c = const Color(0xff30a1ee);
        break;
      case 2:
        icon = HouseLogo.sarah;
        c = const Color(0xffd4251e);
        break;
      case 3:
        icon = HouseLogo.mulchat;
        c = const Color(0xff387b2c);
        break;
      case 4:
        icon = HouseLogo.noro;
        c = const Color(0xff65449e);
        break;
      default:
        icon = null;
        c = Colors.black;
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Icon(icon, size: 35, color: c),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradientJ => const LinearGradient(
    colors: [
      Color.fromRGBO(204, 204, 204, 204.26),
      //Color(0xffffffff),
      Color.fromRGBO(149, 149, 149, 1)
      //Color(0xfff3bd34)
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  LinearGradient get _barsGradientG => const LinearGradient(
    colors: [
      Color.fromRGBO(204, 204, 204, 204.26),
      //Color(0xffffffff),
      Color.fromRGBO(149, 149, 149, 1)
      //Color(0xff30a1ee)
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  LinearGradient get _barsGradientS => const LinearGradient(
    colors: [
      Color.fromRGBO(204, 204, 204, 204.26),
      //Color(0xffffffff),
      Color.fromRGBO(149, 149, 149, 1)
      //Color(0xffd4251e)
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  LinearGradient get _barsGradientM => const LinearGradient(
    colors: [
      Color.fromRGBO(204, 204, 204, 204.26),
      //Color(0xffffffff),
      Color.fromRGBO(149, 149, 149, 1)
      //Color(0xff387b2c)
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  LinearGradient get _barsGradientN => const LinearGradient(
    colors: [
      Color.fromRGBO(204, 204, 204, 204.26),
      //Color(0xffffffff),
      Color.fromRGBO(149, 149, 149, 1)
      //Color(0xff65449e)
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: jeoji,
          gradient: _barsGradientJ,
          width: 22,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: geomun,
          gradient: _barsGradientG,
          width: 22,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: sarah,
          gradient: _barsGradientS,
          width: 22,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: mulchat,
          gradient: _barsGradientM,
          width: 22,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          toY: noro,
          gradient: _barsGradientN,
          width: 22,
        )
      ],
      showingTooltipIndicators: [0],
    ),
  ];
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future refresh() async {
    context.read<Store1>().getData();
    context.read<Store2>().fetchData(features[0], 0);
    context.read<Store2>().fetchData(features[1], 1);
    context.read<Store2>().fetchData(features[2], 2);
    context.read<Store2>().fetchData(features[3], 3);
  }

  final webScraper = WebScraper('https://nlcshub.com');

  Future<List<Map<String, dynamic>>> fetchParagraph(String url) async {
    late List<Map<String, dynamic>> paragraph;
    if (await webScraper
        .loadWebPage(url)) {
      paragraph = webScraper.getElement(
          'div.entry-content > p', ["style"]);
    }
    return paragraph;
  }

  void put(url, title, category, imageURL, date) async {
    final fetchedParagraph = await fetchParagraph(url);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Article(url: url, title: title, category: category, imageURL: imageURL, date: date, paragraph: fetchedParagraph,)));
  }

  static const imgs = <String>[
    'https://images.unsplash.com/photo-1564325724739-bae0bd08762c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
    'https://images.unsplash.com/photo-1584592487914-a29c64f25887?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1769&q=80',
    'https://images.unsplash.com/photo-1533709475520-a0745bba78bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
    'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80',
    'https://images.unsplash.com/photo-1609619385076-36a873425636?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80'
  ];

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFMenu(file: file)),
  );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // TODO: Change color
      onRefresh: refresh,
      child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 3.h),
                        child: SvgPicture.asset(
                          'assets/logo.svg',
                          height: 7.h,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: Text(
                        "This Week's Bulletin",
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 9.h,
                        width: 100.w,
                        child: GestureDetector(
                          onTap: () async {
                            Fluttertoast.showToast(msg: "Loading, please wait.", fontSize: 18.0);
                            String url = context.read<Store1>().path[0];
                            final file = await PDFApi.loadFirebase(url);
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
                                context.watch<Store1>().title[0],
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 17.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const ItemTile(),
                    Text(
                      'Explore',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      height: 12.h,
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            List categories = [
                              ["STEM", const STEM()],
                              ["Humanities", const Humanities()],
                              ["Languages", const Languages()],
                              ["Arts", const Arts()],
                              ["TOK", const TOK()]
                            ];
                            return Padding(
                              padding: EdgeInsets.only(right: 3.h),
                              child: CircularProfileAvatar(
                                imgs[index],
                                radius: 6.h,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => categories[index][1]));
                                },
                                initialsText: Text(
                                  categories[index][0],
                                  style: TextStyle(fontSize: 15.sp,
                                      color: Colors.white),
                                ),
                                showInitialTextAbovePicture: true,
                                cacheImage: true,
                              ),
                            );
                          }
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: Text(
                        'Featured Articles',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    Container(
                      height: 318,
                      clipBehavior: Clip.none,
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> attributes =
                            context.watch<Store2>().image[index][0]['attributes'];
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: 1.1.h, top: 2.h, bottom: 3.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    put(features[index], context.read<Store2>().title![index][0]['title'], context.read<Store2>().category[index][0]['title'], attributes['src'], context.read<Store2>().date[index][0]['title']);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      width: 260,
                                      padding: EdgeInsets.all(1.h),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 140,
                                            width: 260,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: attributes['src'],
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => Container(color: Colors.black.withOpacity(0.04)),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 15),
                                            height: 83,
                                            width: 230,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 3),
                                                  child: Text(
                                                      context.read<Store2>().category[index][0]['title'],
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: const Color(
                                                              0xffA3A3A3)
                                                      )
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: Text(
                                                      context.read<Store2>().title![index][0]['title'],
                                                      maxLines: 2,
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
                                                      top: 7),
                                                  child: Text(
                                                    context.read<Store2>().read[index][0]['title'],
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: const Color(
                                                            0xffA3A3A3)
                                                    ),
                                                  ),
                                                )
                                              ],
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
      ),
    );
  }
}