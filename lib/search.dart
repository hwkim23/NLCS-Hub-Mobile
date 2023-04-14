import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:lottie/lottie.dart';

import 'article.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final webScraper = WebScraper('https://nlcshub.com');

  List<Map<String, dynamic>>? title;
  late List<Map<String, dynamic>> read;
  late List<Map<String, dynamic>> date;
  late List<Map<String, dynamic>> image;
  late List<Map<String, dynamic>> url;
  late List<Map<String, dynamic>> category;
  late List<Map<String, dynamic>> subsubCategory;

  void fetchData(String searchTerm) async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('/?s=$searchTerm')) {
      setState(() {
        title = webScraper.getElement('h2.entry-title > a', ['href', 'rel']);
        date = webScraper.getElement('ul.post-meta > li.meta-date', ['class']);
        read = webScraper
            .getElement('ul.post-meta > li.meta-reading-time', ['class']);
        image = webScraper
            .getElement('div.cs-overlay-background > img', ["data-orig-file"]);
        url = webScraper.getElement('div.cs-overlay-hover > a', ['href']);
        category = webScraper.getElement(
            'div.meta-category > a.category-style > span.label', ['class']);
        subsubCategory = webScraper.getElement('article', ['class']);
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchParagraph(String url) async {
    late List<Map<String, dynamic>> paragraph;
    if (await webScraper.loadWebPage(url)) {
      paragraph = webScraper.getElement('div.entry-content > p', ["style"]);
    }
    return paragraph;
  }

  void put(url, title, category, imageURL, date) async {
    final fetchedParagraph = await fetchParagraph(url);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Article(
                  url: url,
                  title: title,
                  category: category,
                  imageURL: imageURL,
                  date: date,
                  paragraph: fetchedParagraph,
                )));
  }

  String convert(String s) {
    String cut = s.substring(19);
    return cut;
  }

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String? searchTerm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(241, 242, 246, 1.0),
          iconTheme: const IconThemeData(color: Colors.black),
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(Icons.clear, color: Colors.black54),
                  ),
                  border: InputBorder.none,
                  hintText: 'Search...',
                ),
                controller: searchController,
                onSubmitted: (String str) {
                  setState(() {
                    searchTerm = str;
                  });
                  fetchData(str);
                },
              ),
            ),
          )),
      body: SafeArea(
        child: searchTerm == null
            ? const SizedBox()
            : title == null
                ? Center(child: Lottie.asset('assets/lottie.json'))
                : Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          searchTerm!.isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    searchTerm!.capitalize(),
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                ),
                          searchTerm!.isEmpty
                              ? const SizedBox()
                              : Container(
                                  margin: EdgeInsets.only(bottom: 3.h),
                                  child: ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: title!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Map<String, dynamic> attributes2 =
                                            url[index]['attributes'];
                                        Map<String, dynamic> attributes =
                                            image[index]['attributes'];
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: 1.1.h, top: 1.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                put(
                                                    convert(
                                                        attributes2["href"]),
                                                    title![index]['title'],
                                                    category[index]['title'],
                                                    attributes[
                                                        "data-orig-file"],
                                                    date[index]['title']);
                                              },
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Container(
                                                  width: 130,
                                                  padding: EdgeInsets.all(1.h),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 100,
                                                        width: 100,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: attributes[
                                                                "data-orig-file"],
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                    url) =>
                                                                Container(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.04)),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        fit: FlexFit.loose,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 60,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                    title![index]
                                                                        [
                                                                        'title'],
                                                                    maxLines: 3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize: 16
                                                                            .sp,
                                                                        height:
                                                                            1.3,
                                                                        color: const Color(
                                                                            0xff343434))),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 7),
                                                                child: Text(
                                                                  read[index]
                                                                      ['title'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color: const Color(
                                                                          0xffA3A3A3)),
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
                                      }),
                                )
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
