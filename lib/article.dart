import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'myAppBar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:lottie/lottie.dart';

class Article extends StatefulWidget {
  const Article(
      {Key? key,
      required this.url,
      required this.title,
      required this.category,
      required this.imageURL,
      required this.date,
      this.paragraph})
      : super(key: key);

  final String url;
  final String title;
  final String category;
  final String imageURL;
  final String date;
  final List<Map<String, dynamic>>? paragraph;

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  final webScraper = WebScraper('https://nlcshub.com');

  List<Map<String, dynamic>>? paragraph;

  void fetchData() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage(widget.url)) {
      setState(() {
        paragraph = webScraper.getElement('div.entry-content > p', ["style"]);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    paragraph = widget.paragraph;
    if (paragraph == null) {
      fetchData();
    } else {
      if (paragraph![0]['title'].contains('img')) {
        paragraph!.removeAt(0);
      }
      for (int i = 0; i < paragraph!.length; i++) {
        if (paragraph![i]['title'].contains('Bibliography')) {
          while (i < paragraph!.length) {
            paragraph!.removeAt(i);
          }
          paragraph!.removeAt(i - 1);
        }
      }
    }
    //context.read<Store1>().changeName(Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), color: Colors.white),
      body: SafeArea(
        child: paragraph == null
            ? Center(child: Lottie.asset('assets/lottie.json'))
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 3.h),
                          child: Text(
                            widget.category,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xffA3A3A3)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                          child: Text(
                            widget.title,
                            style: TextStyle(fontSize: 19.sp),
                          ),
                        ),
                        Text(
                          widget.date,
                          style: TextStyle(
                              fontSize: 16.sp, color: const Color(0xffA3A3A3)),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 2.h),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.imageURL,
                                  ),
                                ),
                              );
                            }),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (paragraph!.length),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 2.h),
                                child: Text(
                                  paragraph![index]['title'],
                                  style: TextStyle(fontSize: 17.sp, height: 2),
                                  textAlign: TextAlign.justify,
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
